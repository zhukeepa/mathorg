latest = "YS-trig-blue.txt"

# Format:             "#{Rails.root}/data_loading/data/handouts/#{latest}",
# <<<Title: [explanation title]
# Author(s): [comma-separated list of explanation titles]
# Description: [description]
# Topics: [comma-separated list of topics]>>>
# [Everything after is the body of the post]
default_user = User.find(1)
#filenames = ["#{Rails.root}/data_loading/data/handouts/Symmedians.txt", 
#             "#{Rails.root}/data_loading/data/handouts/blue-weights-and-coloring.txt",
#             "#{Rails.root}/data_loading/data/handouts/black-integer-polynomials.txt",
#             "#{Rails.root}/data_loading/data/handouts/inversion.txt"]

filenames = Dir["#{Rails.root}/data_loading/data/handouts/*.txt"] | Dir["#{Rails.root}/data_loading/data/handouts2/*.txt"]
#filenames = ["#{Rails.root}/data_loading/data/handouts/2012MOPBlueSimilarity.txt"]
#filenames = ["#{Rails.root}/data_loading/data/handouts/analytic_geo.txt"]

bad_topics = []
prev_problem = nil

filenames.each do |fn|
  file = File.open(fn, "rb")
  content = file.read 

  e = Explanation.new
  # pull & delete metadata
  content.gsub!("\r", "")
  content.gsub!(/<<<(.*)>>>/m) do |match| 
    meta = $1
    meta.gsub(/Title: (.*)\nAuthor\(s\): (.*)\nDescription: (.*)\nTopics: (.*)\n/m) do |match2| 
      e.title = $1
      e.authors_string = $2
      e.description = $3
      e.topics_string = $4
    end

    next ''
  end

  content.strip!

  content.gsub!(/\{\{\{(.*?)\}\}\}|\(\(\((.*?)\)\)\)/m) do |match| 
    if !$1.nil? && !$1.empty?
      body = $1 
      body.strip!

      parens_string = ""
      prev_problem = Problem.new(description: "Problem from handout \"#{e.title}\"", body: body, topics_string: e.topics_string)
      if !body[0].nil? && body[0] == '('
        inside = body.match(/\((.*?)\)/)[1]  # get inside of parens
        body.sub!(/\((.*?)\)\s*/, "")        # remove that parens from the start
        prev_problem.body = body 
        prev_problem.source = inside if inside.match(/\d/)

        parens_string = "(#{inside}) "
      end
      if !body[0].nil? && body[0] == '['
        inside = body.match(/\[(.*?)\]/)[1]  # get inside of brackets
        body.sub!(/\[(.*?)\]\s*/, "")        # remove that bracket from the start
        prev_problem.body = body 
        prev_problem.source = inside if inside.match(/\d/)

        parens_string = "(#{inside}) "
      end
      prev_problem.save!

      # add this file if one of the topics entered was a typo
      bad_topics << fn if prev_problem.topics.size < e.topics_string.count(',')+1

      if e.topics_string.count(',') > 0
        prev_problem.topics_string = ""
        prev_problem.save!
      end
      next "#{parens_string}[problem]#{prev_problem.id}[/problem]"
    end

    if !$2.nil? && !$2.empty?
      s = prev_problem.solutions.create(author_id: "#{default_user.id}", body: $2, hints_string: "", topics_string: e.topics_string)
      next "[solution]#{prev_problem.id}.#{prev_problem.solutions.size-1}[/solution]"
    end
  end

  e.body = RichText.new(text: content)
  e.save!

  file.close
end

puts bad_topics

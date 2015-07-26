latest = "YS-trig-blue.txt"

# Format:             "#{Rails.root}/data_loading/data/handouts/#{latest}",
# <<<Title: [explanation title]
# Author(s): [comma-separated list of explanation titles]
# Description: [description]
# Topics: [comma-separated list of topics]>>>
# [Everything after is the body of the post]
default_user = User.find(1)
filenames = ["#{Rails.root}/data_loading/data/handouts/Symmedians.txt", 
             "#{Rails.root}/data_loading/data/handouts/blue-weights-and-coloring.txt",
             "#{Rails.root}/data_loading/data/handouts/black-integer-polynomials.txt",
             "#{Rails.root}/data_loading/data/handouts/inversion.txt"]
filenames.each do |fn|
  file = File.open(fn, "rb")
  content = file.read 

  e = Explanation.new
  # pull & delete metadata
  content.gsub!(/<<<(.*)>>>\n/m) do |match| 
    meta = $1
    meta.gsub(/Title: (.*)\nAuthor\(s\): (.*)\nDescription: (.*)\nTopics: (.*)\n/m) do |match2| 
      e.title = $1
      e.authors_string = $2
      e.description = $3
      e.topics_string = $4
    end

    next ''
  end

  prev_problem = nil
  content.gsub!(/\[\[\[(.*?)\]\]\]|\(\(\((.*?)\)\)\)/m) do |match| 
    if !$1.nil? && !$1.empty? 
      prev_problem = Problem.new(description: "Problem from handout \"#{e.title}\"", body: $1, topics_string: e.topics_string)
      prev_problem.save!
      next "[problem]#{prev_problem.id}[/problem]"
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

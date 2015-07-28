# copy/paste into rails console

filenames = ["#{Rails.root}/data_loading/data/contest_jsons/USAMO.json",
             "#{Rails.root}/data_loading/data/contest_jsons/ISL.json"]

filenames.each do |filename|
  file = File.open(filename, "rb")
  problems_json = file.read
  contest_hashes = ActiveSupport::JSON.decode(problems_json)

  contest_hashes.each do |c|
    ps = ProblemSet.new({name: c["name"]})
    p_ids = []

    problems = c["problems"] 
    problems.sort_by{ |p| p["number"].to_i }.each do |p|
    	p_db = Problem.new
    	p_db[:description] = ""
    	p_db[:body] = p["text"]
    	p_db.save

    	p_ids.append(p_db.id)
    end

    ps.problem_ids = p_ids.join(',')
    ps.save
  end

  file.close
end
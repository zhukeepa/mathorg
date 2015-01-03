# copy/paste into rails console

file = File.open("#{Rails.root}/data_loading/data/contests.json", "rb")
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

  ps.problem_ids_string = p_ids.join(',')
  ps.save
end

file.close

file = File.open("#{Rails.root}/scraped_to_db/jsontest.json", "rb")
problems_json = file.read
contest_hashes = ActiveSupport::JSON.decode(problems_json)

contest_hashes.each do |c|
  ps = ProblemSet.new({name: c["name"]})
  p_ids = []

  p = Problem.new
  problems = c["problems"] 
  problems.sort_by{ |p| p.number.to_i }.each do |p|
  	p_db = Problem.new
  	p_db[:description] = #
  	p_db[:body] = #
  	p_db.save

  	p_ids.append(p_db.id)
  end

  ps.problem_ids_string = p_ids.join(',')
end

file.close
file = File.open("#{Rails.root}/scraped_to_db/jsontest.json", "rb")
problems_json = file.read
problems_hashes = ActiveSupport::JSON.decode(problems_json)

psd = {}

problems_hashes.each do |ph|
  p = Problem.new(ph.permit(:body, :description))
  if p.save
    if psd[ph["contest"]].nil?
      ps = ProblemSet.new({name: ph["contest"]})
      psd[ph["contest"]] = { ps: ps, problem_indexes: Array.new(50) }
    end

    psd[ph["contest"]][:problem_indexes][p.number.to_i] = p.id
  else
    puts ph.index
  end
end

psd.each do |foo|
  foo[:ps].problem_ids_string = foo[:problem_indexes].compact.join(',')
  foo[:ps].save
end

file.close
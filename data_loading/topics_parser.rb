# copy/paste into rails console

file = File.open("#{Rails.root}/data_loading/data/topics.oml", "r")
contents = file.read

# reformat contents so that each subsection also counts as a bullet point
# replaces <outline text="Olympiads" > with <outline text="Olympiads" /><outline text="Olympiads" >
regex = /<outline text=\"[[[:alnum:]][[:punct:]][[:space:]]]*\" >/
contents = contents.gsub(regex) { |s| s[0..-2]+"/>" + s }

opml = OpmlSaw::Parser.new(contents)
opml.parse

puts opml.feeds.sort_by { |t| t[:text] }.join("\n")

topics = {}
Topic.all.each do |t|
  topics[t[:name]] = t
end

opml.feeds.each do |p|
  topics[p[:text]] ||= Topic.new({ name: p[:text] })

  if !p[:tag].nil?
    topics[p[:tag]] ||= Topic.new({ name: p[:tag] })
    topics[p[:text]].parents.append(topics[p[:tag]])
  end
end

topics.each { |n, t| t.save }

file.close

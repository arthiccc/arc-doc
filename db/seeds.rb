# Purge existing data
Document.destroy_all
ActiveStorage::Attachment.all.each(&:purge)
ActiveStorage::Blob.all.each(&:purge)

puts "Old documents cleared. Generating 100 realistic documents..."

finance = Department.find_by(name: "Finance")
hr = Department.find_by(name: "Human Resources")
academic = Department.find_by(name: "Academic")

categories = Category.all
names = ["Alice Thompson", "Bob Richards", "Charlie Davis", "Diana Prince", "Edward Norton"]

# Realistic content templates
contents = {
  "Report" => "FINANCIAL QUARTERLY REPORT\n\nExecutive Summary: The budget for this period has been optimized. \nKey Findings: 15% reduction in waste. \nRecommendations: Continue monitoring procurement.",
  "Contract" => "EMPLOYMENT AGREEMENT\n\nThis contract is entered into by the University and the employee. \nTerms: Full-time employment with benefits. \nConfidentiality: All campus data is strictly private.",
  "Memo" => "INTERNAL MEMORANDUM\n\nTo: All Staff\nFrom: Administration\nSubject: Campus Holiday Schedule\n\nPlease note the following closures for the upcoming academic break.",
  "Policy" => "CAMPUS USAGE POLICY\n\nSection 1: Facility access is restricted to authorized personnel. \nSection 2: Security protocols must be followed at all times.",
  "Schedule" => "ACADEMIC CALENDAR 2026\n\nMonday: Faculty Meetings\nTuesday: Enrollment Services\nWednesday: Departmental Workshops"
}

100.times do |i|
  type = contents.keys.sample
  name = names.sample
  cat = categories.sample
  year = [2024, 2025, 2026].sample
  
  title = "#{type}: #{name} - #{year}"
  body = "Reference ID: CA-#{1000 + i}\n\n#{contents[type]}\n\nValidated by the Archive System on #{Time.now.strftime("%Y-%m-%d")}."

  doc = Document.new(
    title: title,
    description: "Official #{type.downcase} document for #{name}.",
    category: cat,
    created_at: rand(1..365).days.ago
  )

  temp_file = Tempfile.new(["doc_#{i}", ".txt"])
  temp_file.write(body)
  temp_file.rewind

  doc.file.attach(io: File.open(temp_file.path), filename: "#{title.parameterize}.txt", content_type: "text/plain")
  doc.save!
  
  temp_file.close
  temp_file.unlink
  print "." if (i + 1) % 10 == 0
end

puts "\nSuccessfully seeded 100 realistic documents."

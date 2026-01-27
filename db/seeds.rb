# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

# Skills Seeding
skills = [
    "Ruby on Rails",
    "Node",
    "Python",
    "React",
    "PostgreSQL",
    "Tailwind CSS",
    "Java",
    "MySQL",
    "C++",
    "Git",
    "GitHub"
]

puts "Seeding initial skills..."

skills.each do |skill_name|
    Skill.find_or_create_by!(name: skill_name)
end

puts "Finished seeding #{Skill.count} skills."

# Users Seeding
puts "Seeding test users and corresponding profiles..."

user1 = User.find_or_create_by!(email: 'user1@example.com') do |user|
  user.password = 'secret'
end
Profile.find_or_create_by!(user: user1) do |profile|
  profile.first_name = 'Penny'
  profile.last_name = 'Gadget'
  profile.skill_level = 'beginner'
end

user2 = User.find_or_create_by!(email: 'user2@example.com') do |user|
  user.password = 'secret'
end
Profile.find_or_create_by!(user: user2) do |profile|
  profile.first_name = 'Gadget'
  profile.last_name = 'Hackwrench'
  profile.skill_level = 'beginner'
end

user3 = User.find_or_create_by!(email: 'user3@example.com') do |user|
  user.password = 'secret'
end
Profile.find_or_create_by!(user: user3) do |profile|
  profile.first_name = 'Velma'
  profile.last_name = 'Dinkley'
  profile.skill_level = 'beginner'
end

user4 = User.find_or_create_by!(email: 'user4@example.com') do |user|
  user.password = 'secret'
end
Profile.find_or_create_by!(user: user4) do |profile|
  profile.first_name = 'Jimmy'
  profile.last_name = 'Neutron'
  profile.skill_level = 'beginner'
end

puts "Finished seeding #{User.count} users and #{Profile.count} profiles."

puts "Seeding projects..."

projects_data = [
  {
    title: "Personal Portfolio Website",
    description: "A personal portfolio website built with Ruby on Rails and Tailwind CSS.",
    status: 0,
    user_email: "user1@example.com",
    skill_names: [ "Ruby on Rails", "Tailwind CSS", "Git", "GitHub" ]
  },
  {
    title: "E-commerce App",
    description: "An online shop website with full CRUD and user authentication.",
    status: 1,
    user_email: "user1@example.com",
    skill_names: [ "Ruby on Rails", "PostgreSQL", "React" ]
  }
]

projects_data.each do |project_data|
  user = User.find_by(email: project_data[:user_email])
  next unless user

  project = Project.find_or_create_by!(
    title: project_data[:title],
    user: user
  ) do |p|
    p.description = project_data[:description]
    p.status = project_data[:status]
  end

  skills_by_name = Skill.where(name: project_data[:skill_names]).index_by(&:name)
  existing_skill_ids = ProjectSkill.where(
    project: project,
    skill_id: skills_by_name.values.map(&:id)
  ).pluck(:skill_id)

  project_data[:skill_names].each do |skill_name|
    skill = skills_by_name[skill_name]
    next unless skill
    next if existing_skill_ids.include?(skill.id)

    ProjectSkill.create!(project: project, skill: skill)
  end
end

puts "Finished seeding projects: #{Project.count}"

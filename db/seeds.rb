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


# Profile Skills Seeding
puts "Seeding profile skills..."

profile_skill_map = {
  "user1@example.com"  => [ "Ruby on Rails", "React", "PostgreSQL", "Tailwind CSS", "Git", "GitHub" ],
  "user2@example.com" => [ "Ruby on Rails", "Git" ],
  "user3@example.com" => [ "Python" ]
}

profile_skill_map.each do |email, skill_list|
  user = User.find_by(email: email)
  raise "Seed error: user not found for #{email}" unless user

  profile = Profile.find_by(user: user)
  raise "Seed error: profile not found for #{email}" unless profile

  matched_skills = Skill.where(name: skill_list)
  missing_skills = skill_list - matched_skills.pluck(:name)

  unless missing_skills.empty?
    raise "Seed error: missing skills for profile with email #{email}: #{missing_skills.join(', ')}"
  end

  existing_skill_ids = ProfileSkill.where(profile: profile, skill: matched_skills).pluck(:skill_id)
  skills_to_create = matched_skills.reject { |skill| existing_skill_ids.include?(skill.id) }

  skills_to_create.each do |skill|
    ProfileSkill.create!(
      profile: profile,
      skill: skill
    )
  end
end

puts "Finished seeding profile skills."

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

  matched_skills = Skill.where(name: project_data[:skill_names])

  if matched_skills.empty?
    puts "No skills found for project #{project_data[:title]}"
    next
  end

  project = Project.find_or_initialize_by(
    title: project_data[:title],
    user: user
  )

  project.description = project_data[:description]
  project.status = project_data[:status]

  project.skills = matched_skills

  project.save!

  puts "Seeded project: #{project.title}"
end


# Resources Seeding
resources = [
  {
    title: 'Resource 1',
    url: 'https://example.com/resource1',
    description: "I'm a description of resource one!",
    user: user1
  },
  {
    title: 'Resource 2',
    url: 'https://example.com/resource2',
    description: nil,
    user: user1
  },
  {
    title: 'Resource 3',
    url: 'https://example.com/resource3',
    description: "I'm a description of resource three! Lorem ipsum dolor sit amet consectetur adipiscing elit. Quisque faucibus ex sapien vitae pellentesque sem placerat. In id cursus mi pretium tellus duis convallis. Tempus leo eu aenean sed diam urna tempor. Pulvinar vivamus fringilla lacus nec metus bibendum egestas. Iaculis massa nisl malesuada lacinia integer nunc posuere. Ut hendrerit semper vel class aptent taciti sociosqu. Ad litora torquent per conubia nostra inceptos himenaeos.",
    user: user1
  },
  {
    title: 'Resource 4',
    url: 'https://example.com/resource4',
    description: "I'm a description of resource four!",
    user: user2
  },
  {
    title: 'Resource 5',
    url: 'https://example.com/resource5',
    description: nil,
    user: user2
  }
]

puts 'Seeding initial resources...'

resources.each do |resource|
  resource_record = Resource.find_or_initialize_by(url: resource[:url])
  resource_record.assign_attributes(
    title: resource[:title],
    description: resource[:description],
    user: resource[:user]
  )
  resource_record.save!
end

puts "Finished seeding #{Resource.count} resources."

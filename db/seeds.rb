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
    raise "Seed error: missing skills for profile #{first_name}: #{missing_skills.join(', ')}"
  end


  matched_skills.each do |skill|
    ProfileSkill.find_or_create_by!(
      profile: profile,
      skill: skill
    )
  end
end

puts "Finished seeding profile skills."

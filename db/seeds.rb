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

User.destroy_all

user1 = User.create!(
  email: 'user1@example.com',
  password: 'secret'
)
Profile.create!(
  user: user1,
  first_name: 'Penny',
  last_name: 'Gadget'
)

user2 = User.create!(
  email: 'user2@example.com',
  password: 'secret'
)
Profile.create!(
  user: user2,
  first_name: 'Gadget',
  last_name: 'Hackwrench'
)

user3 = User.create!(
  email: 'user3@example.com',
  password: 'secret'
)
Profile.create!(
  user: user3,
  first_name: 'Velma',
  last_name: 'Dinkley'
)

user4 = User.create!(
  email: 'user4@example.com',
  password: 'secret'
)
Profile.create!(
  user: user4,
  first_name: 'Jimmy',
  last_name: 'Neutron'
)

puts "Finished seeding #{User.count} users and #{Profile.count} profiles."

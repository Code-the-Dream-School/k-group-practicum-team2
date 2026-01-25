# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end
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


# Profile Skills Seeding 
puts "Seeding profile skills..."

profile_skill_map = {
    "Ramon" => ["Ruby on Rails", "React", "Node"],
    "Riche" => ["Node", "Java", "MySQL"],
    "Jennifer" => ["Python", "Git"],
    "Michael" => ["Ruby on Rails", "Tailwind CSS", "GitHub"]
}

profile_skill_map.each do |first_name, skill_names|
    profile = Profile.find_by(first_name: first_name)
    next unless profile 

    skill_names.each do |skill_name|
        skill = Skill.find_by(name: skill_name)
        next unless skill 
        
        ProfileSkill.find_or_create_by!(
            profile: profile,
            skill: skill 
        )
    end 
end 

puts "Finished seeding profile skills."
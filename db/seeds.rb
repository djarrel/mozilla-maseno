# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
User.create!(name: "Ben Ten", email: "ben.ten@mozillamaseno.com", password: "passpass",
             password_confirmation: "passpass")

99.times do |n|
  name = Faker::Name.name
  email = "user-#{n+1}@mozillamaseno.com"
  password = "passpass"
  password_confirmation = password
  User.create!(name: name, email: email, password: password, password_confirmation: password)
end


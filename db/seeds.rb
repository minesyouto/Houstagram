# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

User.create!(
    name:"管理者",
    username: "Admin",
    email: "admin@gmail.com",
    password:  "11111111",
    password_confirmation: "11111111",
    admin: true)
    
5.times do |n|
    User.create!(
      name: "テストユーザー#{n + 1}",
      username: "Test#{n + 1}",
      email: "test#{n + 1}@gmail.com",
      password: "111111",
      password_confirmation: "111111",
    )
  end
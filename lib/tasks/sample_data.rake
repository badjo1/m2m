namespace :db do
  desc "Fill database with sample data"
  task populate: :environment do
    Party.create!(name: "Example User",
                 email: "test@shiatsuwijzer.org",
                 password: "foobar123",
                 password_confirmation: "foobar123")
    99.times do |n|
      name  = Faker::Name.name
      email = "example-#{n+1}@shiatsuwijzer.org"
      password  = "password"
      Party.create!(name: name,
                   email: email,
                   password: password,
                   password_confirmation: password)
    end
  end
end
namespace :db do
  desc "Fill database with sample data"
  task populate: :environment do
    User.create!(name: "An Other User",
                 email: "taxuy@mail.ru",
                 mphone: "79996772342",
                 password: "foobar",
                 password_confirmation: "foobar")
    99.times do |n|
      name  = Faker::Name.name
      email = "tren-#{n+1}@bk.ru"
      mphone = "749501434#{n+1}" 
      password  = "password"
      User.create!(name: name,
                   email: email,
                   mphone: mphone,
                   password: password,
                   password_confirmation: password)
    end
  end
end

namespace :db do
  desc "Fill database with sample data"
  task populate: :environment do
    User.create!(name: "Vlad Sychev",
                 email: "vladsy@mail.ru",
                 mphone: "79162020449",
                 password: "vladsy",
                 password_confirmation: "vladsy")
    15.times do |n|
      name  = Faker::Name.name
      email = Faker::Internet.email
      mphone = "749501434#{n+1}" 
      password  = "password"
      User.create!(name: name,
                   email: email,
                   mphone: mphone,
                   password: password,
                   password_confirmation: password)
    end

def date_rand(from = Time.now, to = Time.now + 1.year)
  Time.at(from + rand * (to.to_f - from.to_f)).to_date
end

def phone_rand
  rand(222222222 - 975999999)
end

     99.times do |n|
       name = Faker::Name.name
       email = Faker::Internet.email
       mphone = phone_rand
       body = Faker::Lorem.sentence(10)
       date_r = date_rand
       time_r = Random.new.rand(12).to_s + ":" + Random.new.rand(59).to_s
       lease_t = rand(2-21) 
       car_t = Array["limousine", "retro car", "VIP minivan"].shuffle.first
       Contract.create!(contractor_name: name,
                        contractor_email: email,
                        contractor_mphone: mphone,
                        body_contract: body,
                        date_rent: date_r,
                        time_rent: time_r,
                        lease_time: lease_t,
                        active: true,
                        t_car: car_t)
     end

     users = User.all(limit:25)
     contracts = Contract.all(limit: 50)
     2.times do
       content = Faker::Lorem.sentence(5)
       contracts.each do |contract| 
          users.each do |user| 
           price = rand(1000) + 99 + rand(2000) + rand(500)  
           user.offers.create!(:contract_id => contract.id, :price => price, :adword => content ) 
          end
       end
     end 
  end
end

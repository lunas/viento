require 'factory_girl'
require 'ffaker'

FactoryGirl.define do

  factory :client do
    first_name    {Faker::Name.first_name}
    last_name     {Faker::Name.last_name}
    city          {Faker::Address.city}
    company       {Faker::Company.name}
    email         {Faker::Internet.email}
    phone_home    {Faker::PhoneNumber.phone_number}
    phone_work    {Faker::PhoneNumber.phone_number}
    phone_mobile  {Faker::PhoneNumber.phone_number}
    profession    {Faker::Job.title}
    sequence(:status) {|n| n % 5 == 0 ? 'passiv' : 'aktiv'}
    sequence(:roles_mask) {|n| 2**(n % Client::ROLES.size)}
    street        {Faker::Address.street_name}
    sequence(:street_number) {|n| n % 10 + 1}
    zip           {Faker::AddressUS.zip_code}

  end


end

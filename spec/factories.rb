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
    sequence(:status) {|n| n % 5 == 0 ? 'nein' : 'ja'}
    sequence(:roles_mask) {|n| 2**(n % Client::ROLES.size)}
    mailing       {Client::MAILINGS.sample}
    street        {Faker::Address.street_name}
    sequence(:street_number) {|n| n % 10 + 1}
    zip           {Faker::AddressUS.zip_code}
  end

  factory :piece do
    collection { %w[00 00/01 01 01/02 02 02/03 03 03/04 04 04/05 05 05/06 06 06/07 07 07/08 08 08/09 09 09/10 10 10/11 11 11/12 12 12/13].sample }
    color      { %w[noir rouge marine marine starlight orange pink mauve fleuve bave grive neige beige meige apricot concombre, grenouille].sample }
    fabric     { %w[jeans velvet milano mahler cotton wolle satin glismet soie manchester ghaeklet].sample }
    size       { [34, 36, 38, 40, 42, 44].sample }
    name       { %w[Bastos Chelsea Sputnik Concorde Sphinx Merkaat Nuguru Klavia Onix Rados Phlux Xana Memphis].sample }
    costs      { [100, 200, 300, 400, 500, 600, 700].sample }
    price      { costs * 2 }
    count_produced { [10, 15, 20, 25, 30, 35, 40].sample }
  end

  factory :user do
    username              'Anja'
    email                 'anjaboije@viento.ch'
    password              'viento'
    password_confirmation 'viento'
    roles                 ['boss']
  end

  factory :sale do
    client
    piece
    date         { Time.new( (2001..2013).to_a.sample, (1..12).to_a.sample, (1..30).to_a.sample) }
    actual_price { piece.price }
  end

end

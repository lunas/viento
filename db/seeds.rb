(1..400).each do
  FactoryGirl.create(:client)
end

FactoryGirl.create(:user, username: 'anja',  email: 'anjaboije@viento.ch', password: 'viento', password_confirmation: 'viento', roles: ['boss'])
FactoryGirl.create(:user, username: 'lukas', email: 'lukasnick@gmail.ch',  password: 'viento', password_confirmation: 'viento', roles: ['boss'])

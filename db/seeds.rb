1200.times { FactoryGirl.create(:client) }

200.times { FactoryGirl.create(:piece)}

FactoryGirl.create(:user, username: 'anja',  email: 'anjaboije@viento.ch', password: 'viento', password_confirmation: 'viento', roles: ['boss'])
FactoryGirl.create(:user, username: 'lukas', email: 'lukasnick@gmail.ch',  password: 'viento', password_confirmation: 'viento', roles: ['boss'])

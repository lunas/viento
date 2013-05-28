1200.times { FactoryGirl.create(:client) }

200.times do
  p = FactoryGirl.create(:piece)
  (0..7).to_a.sample.times do
    p.clients << Client.find( (1..1200).to_a.sample )
  end
  print '.'
end

FactoryGirl.create(:user, username: 'anja',  email: 'anjaboije@viento.ch', password: 'viento', password_confirmation: 'viento', roles: ['boss'])
FactoryGirl.create(:user, username: 'lukas', email: 'lukasnick@gmail.ch',  password: 'viento', password_confirmation: 'viento', roles: ['admin'])

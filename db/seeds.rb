(1..40).each do
  FactoryGirl.create(:client)
end

#FactoryGirl.create(:user, first_name: 'Anja', last_name: 'Boije', email: 'anjaboije@viento.ch', password: '10yearsafter', password_confirmation: '10yearsafter', roles: ['boss'])
#FactoryGirl.create(:user, first_name: 'Lukas', last_name: 'Nick', email: 'lukasnick@gmail.ch', password: '10yearsafter', password_confirmation: '10yearsafter', roles: ['boss'])

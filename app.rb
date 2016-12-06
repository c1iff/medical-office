require('sinatra')
require('sinatra/reloader')
also_reload('lib/**/*.rb')
require('./lib/doctor')
require('./lib/patient')
require('pg')
require('pry')

DB = PG.connect({:dbname => "office"})

get('/') do
  @doctors_list = Doctor.all()
  erb(:index)
end

post('/new_doctor') do
  @first_name = params.fetch('first_name')
  @last_name = params.fetch('last_name')
  @speciality_name = params.fetch('speciality_name')
  @new_doctor = Doctor.new(:first_name => @first_name, :last_name => @last_name, :speciality_name => @speciality_name)
  @new_doctor.save()
  erb(:success)
end

get('/doctor/:id') do
  current_doctor = Doctor.find(params.fetch('id'))
end

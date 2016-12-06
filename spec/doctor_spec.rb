require ('rspec')
require ('pg')
require ('doctor')

DB = PG.connect({:dbname => 'office_test'})

RSpec.configure do |config|
  config.after(:each) do
    DB.exec('DELETE FROM doctors *;')
  end

describe(Doctor)
  describe('#first_name') do
    it ('returns the first name of a doctor') do
      new_doctor = Doctor.new(:first_name => 'Bob', :last_name => 'Blahblah', :speciality_name => 'Pediatics')
      expect(new_doctor.first_name).to(eq('Bob'))
    end
  end
  describe('#last_name') do
    it ('returns the last name of a doctor') do
      new_doctor = Doctor.new(:first_name => 'Bob', :last_name => 'Blahblah', :speciality_name => 'Pediatics')
      expect(new_doctor.last_name).to(eq('Blahblah'))
    end
  end
  describe('#speciality_name') do
    it ('returns the last name of a doctor') do
      new_doctor = Doctor.new(:first_name => 'Bob', :last_name => 'Blahblah', :speciality_name => 'Pediatics')
      expect(new_doctor.speciality_name).to(eq('Pediatics'))
    end
  end
  describe('.all') do
    it ('returns all doctors in an array') do
      new_doctor = Doctor.new(:first_name => 'Bob', :last_name => 'Blahblah', :speciality_name => 'Pediatics')
      new_doctor.save()
      new_doctor_two = Doctor.new(:first_name => 'Julia', :last_name => 'Gonzalez', :speciality_name => 'Pediatics')
      new_doctor_two.save()
      expect(Doctor.all()).to(eq([new_doctor, new_doctor_two]))
    end
  end
  describe("#==") do
    it('is the same doctor if the first name and last names are the same text') do
      new_doctor = Doctor.new(:first_name => 'Julia', :last_name => 'Gonzalez', :speciality_name => 'Pediatics')
      new_doctor_two = Doctor.new(:first_name => 'Julia', :last_name => 'Gonzalez', :speciality_name => 'Pediatics')
      expect(new_doctor).to(eq(new_doctor_two))
    end
  end
  describe('#id') do
    it ('returns the id number of a doctor') do
      new_doctor= Doctor.new(:first_name => 'Bob', :last_name => 'Blahblah', :speciality_name => 'Pediatics')
      new_doctor.save()
      expect(new_doctor.id()).to(be_an_instance_of(Fixnum))
    end
  end
end

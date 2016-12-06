require ('rspec')
require ('pg')
require ('patient')

DB = PG.connect({:dbname => 'office_test'})

RSpec.configure do |config|
  config.after(:each) do
    DB.exec('DELETE FROM patients *;')
  end

describe(Patient)
  describe('#first_name') do
    it ('returns the first name of a patient') do
      new_patient = Patient.new(:first_name => 'Sarah', :last_name => 'Davis', :birthdate => '1992-05-01 00:00:00')
      expect(new_patient.first_name).to(eq('Sarah'))
    end
  end

  describe('#last_name') do
    it ('returns the first name of a patient') do
      new_patient = Patient.new(:first_name => 'Sarah', :last_name => 'Davis', :birthdate => '1992-05-01 00:00:00')
      expect(new_patient.last_name).to(eq('Davis'))
    end
  end

  describe('#birthdate') do
    it ('returns the birthdate of a patient') do
      new_patient = Patient.new(:first_name => 'Sarah', :last_name => 'Davis', :birthdate => '1992-05-01 00:00:00')
      expect(new_patient.birthdate).to(eq('1992-05-01 00:00:00'))
    end
  end

  describe('.all') do
    it ('returns all patients in an array') do
      new_patient = Patient.new(:first_name => 'Bob', :last_name => 'Blahblah', :birthdate => '1992-05-01 00:00:00')
      new_patient.save()
      new_patient_two = Patient.new(:first_name => 'Julia', :last_name => 'Gonzalez', :birthdate => '1992-05-01 00:00:00')
      new_patient_two.save()
      expect(Patient.all()).to(eq([new_patient, new_patient_two]))
    end
  end
  describe("#==") do
    it('is the same doctor if the first name and last names are the same text') do
      new_patient = Patient.new(:first_name => 'Julia', :last_name => 'Gonzalez', :birthdate => '1992-05-01 00:00:00')
      new_patient_two = Patient.new(:first_name => 'Julia', :last_name => 'Gonzalez', :birthdate => '1992-05-01 00:00:00')
      expect(new_patient).to(eq(new_patient_two))
    end
  end
  describe('#id') do
    it ('returns the id number of a doctor') do
      new_patient= Patient.new(:first_name => 'Bob', :last_name => 'Blahblah', :birthdate => '1992-05-01 00:00:00')
      new_patient.save()
      expect(new_patient.id()).to(be_an_instance_of(Fixnum))
    end
  end

end

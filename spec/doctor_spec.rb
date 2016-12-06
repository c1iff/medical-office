require ('spec_helper')

describe(Doctor) do

  describe('#first_name') do
    it ('returns the first name of a doctor') do
      new_doctor = Doctor.new(:first_name => 'Bob', :last_name => 'Blahblah', :speciality_name => 'Pediatrics')
      expect(new_doctor.first_name).to(eq('Bob'))
    end
  end
  describe('#last_name') do
    it ('returns the last name of a doctor') do
      new_doctor = Doctor.new(:first_name => 'Bob', :last_name => 'Blahblah', :speciality_name => 'Pediatrics')
      expect(new_doctor.last_name).to(eq('Blahblah'))
    end
  end
  describe('#speciality_name') do
    it ('returns the last name of a doctor') do
      new_doctor = Doctor.new(:first_name => 'Bob', :last_name => 'Blahblah', :speciality_name => 'Pediatrics')
      expect(new_doctor.speciality_name).to(eq('Pediatrics'))
    end
  end
  describe('.all') do
    it ('returns all doctors in an array') do
      new_doctor = Doctor.new(:first_name => 'Bob', :last_name => 'Blahblah', :speciality_name => 'Pediatrics')
      new_doctor.save()
      new_doctor_two = Doctor.new(:first_name => 'Julia', :last_name => 'Gonzalez', :speciality_name => 'Pediatrics')
      new_doctor_two.save()
      expect(Doctor.all()).to(eq([new_doctor, new_doctor_two]))
    end
  end
  describe("#==") do
    it('is the same doctor if the first name and last names are the same text') do
      new_doctor = Doctor.new(:first_name => 'Julia', :last_name => 'Gonzalez', :speciality_name => 'Pediatrics')
      new_doctor_two = Doctor.new(:first_name => 'Julia', :last_name => 'Gonzalez', :speciality_name => 'Pediatrics')
      expect(new_doctor).to(eq(new_doctor_two))
    end
  end
  describe('#id') do
    it ('returns the id number of a doctor') do
      new_doctor= Doctor.new(:first_name => 'Bob', :last_name => 'Blahblah', :speciality_name => 'Pediatrics')
      new_doctor.save()
      expect(new_doctor.id()).to(be_an_instance_of(Fixnum))
    end
  end
  describe('.find') do
    it ('returns a doctor based on an id') do
      new_doctor = Doctor.new(:first_name => 'Bob', :last_name => 'Blahblah', :speciality_name => 'Pediatrics')
      new_doctor.save()
      expect(Doctor.find(new_doctor.id())).to(eq(new_doctor))
    end
  end
  describe('.find_doctor_speciality') do
    it ('returns an array of doctors based on speciality') do
      new_doctor = Doctor.new(:first_name => 'Bob', :last_name => 'Blahblah', :speciality_name => 'Pediatrics')
      new_doctor.save()
      new_doctor_two = Doctor.new(:first_name => 'Julia', :last_name => 'Gonzalez', :speciality_name => 'Pediatrics')
      new_doctor_two.save()
      new_doctor_three = Doctor.new(:first_name => 'Joy', :last_name => 'Blahblah', :speciality_name => 'Internal Medicine')
      new_doctor_three.save()
      expect(Doctor.find_doctor_speciality('Pediatrics')).to(eq([new_doctor, new_doctor_two]))
    end
  end
  describe('.get_speciality_name') do
    it('returns an array of unique specialities stored in table') do
      new_doctor = Doctor.new(:first_name => 'Bob', :last_name => 'Blahblah', :speciality_name => 'Pediatrics')
      new_doctor.save()
      new_doctor_two = Doctor.new(:first_name => 'Julia', :last_name => 'Gonzalez', :speciality_name => 'Pediatrics')
      new_doctor_two.save()
      new_doctor_three = Doctor.new(:first_name => 'Joy', :last_name => 'Blahblah', :speciality_name => 'Internal Medicine')
      new_doctor_three.save()
      expect(Doctor.get_speciality_name()).to(eq(['Pediatrics', 'Internal Medicine']))
    end
  end
  describe('.sort_doctors') do
    it('returns sorted list of doctor names') do
      new_doctor = Doctor.new(:first_name => 'Bob', :last_name => 'Blahblah', :speciality_name => 'Pediatrics')
      new_doctor.save()
      new_doctor_two = Doctor.new(:first_name => 'Julia', :last_name => 'Gonzalez', :speciality_name => 'Pediatrics')
      new_doctor_two.save()
      new_doctor_three = Doctor.new(:first_name => 'Joy', :last_name => 'Dennis', :speciality_name => 'Internal Medicine')
      new_doctor_three.save()
      expect(Doctor.sort_doctors()).to(eq([new_doctor, new_doctor_three, new_doctor_two]))
    end
  end
end

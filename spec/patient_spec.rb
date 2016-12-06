require ('spec_helper')

describe(Patient) do
  describe('#first_name') do
    it ('returns the first name of a patient') do
      new_patient = Patient.new(:first_name => 'Sarah', :last_name => 'Davis', :birthdate => '1992-05-01 00:00:00', :doctor_id => 1)
      expect(new_patient.first_name).to(eq('Sarah'))
    end
  end

  describe('#last_name') do
    it ('returns the first name of a patient') do
      new_patient = Patient.new(:first_name => 'Sarah', :last_name => 'Davis', :birthdate => '1992-05-01 00:00:00', :doctor_id => 1)
      expect(new_patient.last_name).to(eq('Davis'))
    end
  end

  describe('#birthdate') do
    it ('returns the birthdate of a patient') do
      new_patient = Patient.new(:first_name => 'Sarah', :last_name => 'Davis', :birthdate => '1992-05-01 00:00:00', :doctor_id => 1)
      expect(new_patient.birthdate).to(eq('1992-05-01 00:00:00'))
    end
  end

  describe('.all') do
    it ('returns all patients in an array') do
      new_patient = Patient.new(:first_name => 'Bob', :last_name => 'Blahblah', :birthdate => '1992-05-01 00:00:00', :doctor_id => 1)
      new_patient.save()
      new_patient_two = Patient.new(:first_name => 'Julia', :last_name => 'Gonzalez', :birthdate => '1992-05-01 00:00:00', :doctor_id => 2)
      new_patient_two.save()
      expect(Patient.all()).to(eq([new_patient, new_patient_two]))
    end
  end
  describe("#==") do
    it('is the same doctor if the first name and last names are the same text') do
      new_patient = Patient.new(:first_name => 'Julia', :last_name => 'Gonzalez', :birthdate => '1992-05-01 00:00:00', :doctor_id => 1)
      new_patient_two = Patient.new(:first_name => 'Julia', :last_name => 'Gonzalez', :birthdate => '1992-05-01 00:00:00', :doctor_id => 1)
      expect(new_patient).to(eq(new_patient_two))
    end
  end
  describe('#id') do
    it ('returns the id number of a doctor') do
      new_patient= Patient.new(:first_name => 'Bob', :last_name => 'Blahblah', :birthdate => '1992-05-01 00:00:00', :doctor_id => 1)
      new_patient.save()
      expect(new_patient.id()).to(be_an_instance_of(Fixnum))
    end
  end

  describe('#doctor_id') do
    it ('returns the doctor_id for the patient') do
      new_patient= Patient.new(:first_name => 'Bob', :last_name => 'Blahblah', :birthdate => '1992-05-01 00:00:00', :doctor_id => 1)
      expect(new_patient.doctor_id()).to(eq(1))

    end
  end

  describe('.get_patient_group') do
    it ('returns an array containing all the patients with a doctor id') do
      new_patient = Patient.new(:first_name => 'Julia', :last_name => 'Gonzalez', :birthdate => '1992-05-01 00:00:00', :doctor_id => 1)
      new_patient.save()
      new_patient_two = Patient.new(:first_name => 'Julia', :last_name => 'Gonzalez', :birthdate => '1992-05-01 00:00:00', :doctor_id => 1)
      new_patient_two.save()
      new_patient_three = Patient.new(:first_name => 'Julia', :last_name => 'Gonzalez', :birthdate => '1992-05-01 00:00:00', :doctor_id => 2)
      new_patient_three.save()
      expect(Patient.get_patient_group(1)).to(eq([new_patient, new_patient_two]))

    end
  end

end

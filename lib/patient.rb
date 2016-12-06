class Patient
  attr_reader(:first_name, :last_name, :birthdate, :id)

  define_method(:initialize) do |attributes|
    @first_name = attributes.fetch(:first_name)
    @last_name = attributes.fetch(:last_name)
    @birthdate = attributes.fetch(:birthdate)
    @id = nil
  end


  define_method(:save) do
    result = DB.exec("INSERT INTO patients (first_name, last_name, birthdate) VALUES ('#{@first_name}', '#{@last_name}', '#{@birthdate}') RETURNING id;")
    @id = result.first().fetch("id").to_i()
  end

  define_singleton_method(:all) do
    returned_patients = DB.exec('SELECT * FROM patients')
    patient_array = []
    returned_patients.each() do |patient|
      current_patient = Patient.new(:first_name => patient.fetch('first_name'), :last_name => patient.fetch('last_name'), :birthdate => patient.fetch('birthdate'))
      patient_array.push(current_patient)
    end
    patient_array
  end

  define_method(:==) do |another_patient|
    self.first_name().==(another_patient.first_name()).
    &(self.last_name().==(another_patient.last_name())).
    &(self.birthdate().==(another_patient.birthdate()))
  end
end

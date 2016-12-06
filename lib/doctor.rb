class Doctor
  attr_reader(:first_name, :last_name, :speciality_name, :id)

  define_method(:initialize) do |attributes|
    @first_name = attributes.fetch(:first_name)
    @last_name = attributes.fetch(:last_name)
    @speciality_name = attributes.fetch(:speciality_name)
    @id = nil
  end

  define_method(:save) do
    result = DB.exec("INSERT INTO doctors (first_name, last_name, speciality_name) VALUES ('#{@first_name}', '#{@last_name}', '#{@speciality_name}') RETURNING id;")
    @id = result.first().fetch("id").to_i()
  end

  define_singleton_method(:all) do
    returned_doctors = DB.exec('SELECT * FROM doctors')
    doctor_array = []
    returned_doctors.each() do |doctor|
      current_doctor = Doctor.new(:first_name => doctor.fetch('first_name'), :last_name => doctor.fetch('last_name'), :speciality_name => doctor.fetch('speciality_name'))
      doctor_array.push(current_doctor)
    end
    doctor_array
  end

  define_method(:==) do |another_doctor|
    self.first_name().==(another_doctor.first_name()).
    &(self.last_name().==(another_doctor.last_name())).
    &(self.speciality_name().==(another_doctor.speciality_name()))
  end
end

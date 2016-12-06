class Doctor
  attr_reader(:first_name, :last_name, :speciality_name, :id)

  define_method(:initialize) do |attributes|
    @first_name = attributes.fetch(:first_name)
    @last_name = attributes.fetch(:last_name)
    @speciality_name = attributes.fetch(:speciality_name)
    @id = attributes.fetch(:id, nil)
  end

  define_method(:save) do
    result = DB.exec("INSERT INTO doctors (first_name, last_name, speciality_name) VALUES ('#{@first_name}', '#{@last_name}', '#{@speciality_name}') RETURNING id;")
    @id = result.first().fetch("id").to_i()
  end

  define_singleton_method(:all) do
    returned_doctors = DB.exec("SELECT * FROM doctors;")
    doctor_array = []
    returned_doctors.each() do |doctor|
      current_doctor = Doctor.new(:first_name => doctor.fetch('first_name'), :last_name => doctor.fetch('last_name'), :speciality_name => doctor.fetch('speciality_name'), :id => doctor.fetch('id'))
      doctor_array.push(current_doctor)
    end
    doctor_array
  end

  define_method(:==) do |another_doctor|
    self.first_name().==(another_doctor.first_name()).
    &(self.last_name().==(another_doctor.last_name())).
    &(self.speciality_name().==(another_doctor.speciality_name()))
  end

  define_singleton_method(:find) do |doctor_id|
    doctor_id_found = DB.exec("SELECT * FROM doctors WHERE id = '#{doctor_id}';").first()
    found_doctor = Doctor.new(:first_name => doctor_id_found.fetch('first_name'), :last_name => doctor_id_found.fetch('last_name'), :speciality_name => doctor_id_found.fetch('speciality_name'), :id => doctor_id_found.fetch('id'))
    found_doctor
  end

  define_singleton_method(:find_doctor_speciality) do |speciality_name|
    doctor_speciality_found = DB.exec("SELECT * FROM doctors WHERE speciality_name = '#{speciality_name}';")
    speciality_array = []
    doctor_speciality_found.each() do |doctor|
      current_doctor = Doctor.new(:first_name => doctor.fetch('first_name'), :last_name => doctor.fetch('last_name'), :speciality_name => doctor.fetch('speciality_name'), :id => doctor.fetch('id'))
      speciality_array.push(current_doctor)
    end
    speciality_array
  end

  define_singleton_method(:get_speciality_name) do
    result = DB.exec("SELECT DISTINCT speciality_name FROM doctors;")
    speciality_types_array = []
    result.each() do |speciality|
      speciality_types_array.push(speciality.fetch('speciality_name'))
    end
    speciality_types_array
  end

  define_singleton_method(:sort_doctors) do
    returned_sort_doctors = DB.exec("SELECT * FROM doctors ORDER BY last_name ASC;")
    sorted_doctors_array = []
    returned_sort_doctors.each() do |doctor|
      current_doctor = Doctor.new(:first_name => doctor.fetch('first_name'), :last_name => doctor.fetch('last_name'), :speciality_name => doctor.fetch('speciality_name'), :id => doctor.fetch('id'))
      sorted_doctors_array.push(current_doctor)
    end
    sorted_doctors_array
  end
end

require_relative "patients"
require 'securerandom'

class Employee
	attr_reader :name, :hospital, :id
	attr_writer :salary

	def initialize(name, hospital, salary)
		@name = name
		@hospital = hospital
		@salary = salary
		@id = SecureRandom.uuid
	end

end

#Admins can access patients & records
class Admin < Employee
	def initialize(name, hospital, salary)
		super
		@patients = Array.new
	end

	def find_patients(options = {})
		if options[:id]
			return @patients.find {|p| p.id == patient_id}
		end
		filter_patients = @patients
		if options[:name]
			filter_patients = filter_patients.select! {|p| p.name == options[:name]
		end
		if  options[:hospital]
			filter_patients = filter_patients.select! {|p| p.hospital == options[:hospital]
		end
	end

	#adds patient to your list
	def add_patient(patient)
		@patients.push(patient)
	end

	#removes patient from your list
	def remove_patient(patient_id)
		@patients.delete_if {|patient| patient.id == patient_id}
	end

	#can only view records of patients on your list
	def get_records(patient_id)
		patient = @patients.find {|p| p.id == patient_id}
		if patient
			records = patient.records
		end

		# if patient
		# 	puts "RECORDS: "
		# 	patient.records.each do |record|
		# 		puts "#{record.text}\n"
		# 	end
		# 	puts "END OF RECORDS"
		# else
		# 	puts "No patient found with id #{patient_id}."
		# end
	end
end

#Doctors are admins who can also add records
class Doctor < Admin
	def add_record(patient_id)
		patient = @patients.find {|p| p.id == patient_id}
		if patient
			puts "Enter Record:"
			record = Record.new(gets.chomp, @id)
			patient.add_record(record)
		end
	end
end


class Janitor < Employee
	def initialize(name, hospital, salary)
		super
		@daily_tasks = Array.new
	end

	def add_daily_task(task)
		@daily_tasks.push(task)
	end

end

#Receptionists are admins who can also add patients
class Receptionist < Admin
	def create_patient(name)
		new_patient = Patient.new(name)
		@hospital.add(new_patient)
	end
end
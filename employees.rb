require_relative "patients"
require 'securerandom'

class Employee
	attr_reader :name, :hospital, :id, :salary

	def initialize(name, hospital, salary)
		@name = name
		@hospital = hospital
		@salary = salary
		@id = SecureRandom.uuid
	end

	def promote(percent_increase)
		@salary *= (1 + percent_increase)
	end

	def demote(percent_decrease)
		@salary *= (1 - percent_decrease)
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
			return @patients.find {|p| p.id == options[:id]}
		end
		filter_patients = Array.new(@patients)
		if options[:name]
			filter_patients.select! {|p| p.name == options[:name]}
		end
		if  options[:hospital]
			filter_patients.select! {|p| p.hospital == options[:hospital]}
		end
		return filter_patients
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
			return patient.records
		end
	end
end

#Doctors are admins who can also add patient records
class Doctor < Admin
	def add_record(patient_id, text)
		patient = @patients.find {|p| p.id == patient_id}
		if patient
			patient.create_record(text, @id)
		end
	end
end


#Receptionists are admins who can also add patients
class Receptionist < Admin
	def create_patient(name)
		new_patient = Patient.new(name)
		@hospital.add_patient(new_patient)
		return new_patient
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
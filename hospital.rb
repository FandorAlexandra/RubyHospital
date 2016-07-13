require_relative 'patients'
require_relative 'employees'
require 'securerandom'

class Hospital
	attr_reader :name, :location, :id

	def initialize(name, location)
		@name = name
		@location = location
		@id = SecureRandom.uuid
		@patients = Array.new
		@employees = Hash.new
		@employees = {"doctors": [], "janitors": [], "receptionists": [], "general: " []}
	end

	def num_employees
		num = @employees['doctors'].length + @employees['janitors'].length + @employees['receptionists'].length
	end

	def num_patients
		num = @patients.length
	end

	def add_employee(employee)
		case employee.class.name
			when "Doctor"
				@employees["doctors"].push(employee)
			when "Janitor"
				 @employees['janitors'].push(employee)
			when "Receptionists"
				@employees['receptionists'].push(employee)
			else
				@employees['general'].push(employee)
		end
	end

	def add_patient(patient)
		@patients.push(patient)
	end

end
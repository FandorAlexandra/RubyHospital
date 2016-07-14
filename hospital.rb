require_relative 'patients'
require_relative 'employees'
require 'securerandom'

class Hospital
	attr_reader :name, :location, :id, :patients

	def initialize(name, location)
		@name = name
		@location = location
		@id = SecureRandom.uuid
		@patients = Array.new
		@employees = Hash.new {|emp, type| emp[type] = Array.new}
	end

	def num_employees
		num = 0
		@employees.each do |type, list|
			num += list.length
		end
		return num
	end

	def num_patients
		num = @patients.length
	end

	def num_doctors
		num = @employees["doctor"] ? @employees["doctor"].length : 0
	end

	def add_employee(employee)
		case employee.class.name
			when "Doctor"
				@employees["doctor"].push(employee)
			when "Janitor"
				 @employees["janitor"].push(employee)
			when "Receptionist"
				@employees["receptionist"].push(employee)
			else
				@employees["general"].push(employee)
		end
	end

	def get_employees(options = {})
		if options[:id]
			return @employees.values.find {|employee| employee.id == options[:id]}
		elsif options[:type]
			employees = options[:type] == "all" ? @employees.values : @employees[options[:type]]
		elsif options[:name]
			employees = Array.new
			@employees.values.select do |employee_type|
				employees += employee_type.select {|employee| employee.name == options[:name]}
			end
			return employees
		end
	end

	def add_patient(patient)
		@patients.push(patient)
	end

end
require_relative 'employees'
require_relative 'hospital'
require_relative 'patients'

class HumanResources
	attr_reader :hospitals

	def initialize
		@hospitals = Array.new
	end

	def create_employee(name, hospital_id, salary, type)
		hospital = @hospitals.find {|h| h.id == hospital_id}
		if hospital
			case type.downcase
				when "doctor"
					employee = Doctor.new(name, hospital, salary)
				when "janitor"
					employee = Janitor.new(name, hospital, salary)
				when "receptionists"
					employee = Receptionists.new(name, hospital, salary)
				else
					employee = Employee.new(name, hospital, salary)
			end
			hospital.add_employee(employee)
		end
	end

	def remove_employee(employee_id, hospital_id)
		hospital = @hospitals.find {|h| h.id == hospital_id}
		if hospital.get_employees({"id": employee_id})
			employee = @hospitals.find {|h| h.id == hospital_id}

	def find_hospital(options = {})
		if options[:id]
			return @hospitals.find {|p| p.id == patient_id}
		end
		if options[:name]
			filter_hospitals = filter_hospitals.select! {|h| h.name == options[:name]
		end
	end

	def add_hospital(hospital)
		@hospitals.push(hospital)
	end
end
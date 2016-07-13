require_relative 'employees'
require_relative 'hospital'
require_relative 'patients'
require_relative 'hospital-hr'
require "test/unit"
require 'colorize'


#Patients & Records
puts "TESTING PATIENTS AND RECORDS".green

puts "Creating new patient..."
patient_one = Patient.new("P_1")
puts "Name = #{patient_one.name} Records = #{patient_one.records} Id = #{patient_one.id}"

puts "Creating new record..."
record_one = Record.new("First test record", 12345)

puts "Adding record to patient..."
patient_one.add_record(record_one)

print "Getting record..."
record = patient_one.get_record(record_one.id)
puts "RECORD: #{record.text} DATE: #{record.date}"

puts "Adding another record to patient..."
record_two = Record.new("Second test record", 12345)
patient_one.add_record(record_two)

print "Deleting first record..."
patient_one.delete_record(record_one.id)
if patient_one.get_record(record_one.id)
	puts "ERROR : deleted record remains".red
else
	puts "Record deleted"
end

puts "Changing name..."
old_name = patient_one.name
patient_one.change_name("NewName")
puts "Name changed from #{old_name} to #{patient_one.name}"

puts "FINISHED TESTING PATIENTS AND RECORDS"


#Employees

puts "\n\nTESTING EMPLOYEES".green

h = Hospital.new("H1", "HospitalLand")

#ISSUE - have to add hospital to employee AND add employee to hospital
e = Employee.new("Ms.E", h, 10)
puts "Created new #{e.class.name} named #{e.name} who works at #{e.hospital.name} and makes $#{e.salary}"

r = Receptionist.new("Mr.R", h, 15)
puts "Created new #{r.class.name} named #{r.name} who works at #{r.hospital.name} and makes $#{r.salary}"

d1 = Doctor.new("Mr.D1", h, 25)
puts "Created new #{d1.class.name} named #{d1.name} who works at #{d1.hospital.name} and makes $#{d1.salary}"

d2 = Doctor.new("Mr.D2", h, 25)
puts "Created new #{d2.class.name} named #{d2.name} who works at #{d2.hospital.name} and makes $#{d2.salary}"

puts "#{h.name} now has #{h.num_employees} employees, #{h.num_doctors} of whom are doctors"


#Hospitals

puts "Adding employees to #{h.name}..."
h.add_employee(e);
h.add_employee(r);
h.add_employee(d1);
h.add_employee(d2);
puts "#{h.name} now has #{h.num_employees} employees, #{h.num_doctors} of whom are doctors"




#Human Resources


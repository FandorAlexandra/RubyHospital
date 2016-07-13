require_relative 'employees'
require_relative 'hospital'
require_relative 'patients'
require_relative 'hospital-hr'
require "test/unit"
require 'colorize'


#Patients & Records
puts "TESTING PATIENTS AND RECORDS"

puts "Creating new patient..."
patient_one = Patient.new("P_1")
puts "Name = #{patient_one.name} Records = #{patient_one.records} Id = #{patient_one.id}".blue

puts "Creating new record..."
record_one = Record.new("First test record", 12345)

puts "Adding record to patient..."
patient_one.add_record(record_one)

print "Getting record..."
record = patient_one.get_record(record_one.id)
puts "RECORD: #{record.text} DATE: #{record.date}".blue

puts "Adding another record to patient..."
record_two = Record.new("Second test record", 12345)
patient_one.add_record(record_two)

puts "PATIENT RECORDS: #{patient_one.records}".blue

puts "Deleting first record..."
patient_one.delete_record(record_one.id)
if patient_one.get_record(record_one.id)
	puts "ERROR : deleted record remains".red
end

puts "PATIENT RECORDS NOW: #{patient_one.records}".blue

puts "Changing name..."
old_name = patient_one.name
patient_one.change_name("NewName")
puts "Name changed from " + "#{old_name}".blue + " to " + "#{patient_one.name}".blue

puts "FINISHED TESTING PATIENTS AND RECORDS"

#Employees



#Hospitals



#Human Resources


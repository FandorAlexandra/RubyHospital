require_relative 'employees'
require_relative 'hospital'
require_relative 'patients'
require_relative 'hospital-hr'
require 'colorize'


#Patients & Records
puts "TESTING PATIENTS AND RECORDS".green

puts "Creating new patient..."
patient_one = Patient.new("P_1")
puts "Name = #{patient_one.name} Records = #{patient_one.records} Id = #{patient_one.id}"

puts "Creating new record..."
record_one = patient_one.create_record("First test record", 12345)

print "Getting record..."
record = patient_one.get_record(record_one.id)
puts "RECORD: #{record.text} DATE: #{record.date}"

puts "Adding another record to patient..."
record_two = patient_one.create_record("Second test record", 12345)
record = patient_one.get_record(record_two.id)
puts "RECORD: #{record.text} DATE: #{record.date}"

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

puts "FINISHED TESTING PATIENTS AND RECORDS".green



#Employees

puts "\nTESTING EMPLOYEES".green

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

puts "Promoting Mr.D2..."
d2.promote(0.2)
puts "Mr.D2 now makes #{d2.salary}"

puts "Adding patient_one to D2..."
d2.add_patient(patient_one)

puts "Creating another patient..."
patient_two = r.create_patient("patient_two")

puts "Adding another patient to D2..."
d2.add_patient(patient_two)

print "Confirming patients were added..."
print "found patient \'#{d2.find_patients(id: patient_one.id).name}\'"
puts " and found patient \'#{d2.find_patients(name: patient_two.name)[0].name}\'"

puts "Adding record to patient one..."
d2.add_record(patient_one.id, "This is another record")

puts "Getting records of patient one..."
records = d2.get_records(patient_one.id)
print "RECORDS: "
records.each {|record| print "#{record.text}..."}
puts "\n"

print "Removing patient_two..."
d2.remove_patient(patient_two.id)
if d2.find_patients(id: patient_two.id)
	puts "ERROR PATIENT NOT REMOVED".red
else
	puts "successfully removed"
end

puts "FINISHED TESTING EMPLOYEES".green



#Hospitals
puts "\nTESTING HOSPITAL".green
puts "Adding employees to #{h.name}..."
h.add_employee(e);
h.add_employee(r);
h.add_employee(d1);
h.add_employee(d2);
puts "#{h.name} now has #{h.num_employees} employees, #{h.num_doctors} of whom are doctors"

puts "H already has patient_two. Adding patient_one to hospital h..."
h.add_patient(patient_one)
puts "#{h.name} now has #{h.num_patients} patients"
print "Getting all doctor names"
doctors = h.get_employees(type: "doctor")
doctors.each {|doc| print "...#{doc.name}"}
print "\n"

doct_one = h.get_employees(name: "Mr.D1")[0]
puts "Finding doctor one...#{doct_one.name}"

puts "FINISHED TESTING HOSPITALS".green

#Human Resources
puts "\nTESTING HR DEPARTMENT".green
puts "Creating HR..."
hr = HumanResources.new
puts "Adding hospital H to HR..."
hr.add_hospital(h)

print "Confirming hospital added..."
puts "found hospital #{hr.find_hospital(id:h.id)}"

puts "Creating janitor employee at hospital h..."
hr.create_employee("Mr.J", h.id, 10, "janitor")

puts "Confirming employee added..."
janitors = h.get_employees(type: "janitor")
puts "Hospital h has #{janitors.length} janitor"
puts "FINISHED TESTING HR DEPARTMENT".green

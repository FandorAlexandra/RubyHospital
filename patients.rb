require 'securerandom'

class Patient
	attr_reader :name, :records, :id

	def initialize(name)
		@name = name
		@records = Array.new
		@id = SecureRandom.uuid
	end

	def add_record(record)
		@records.push(record)
	end

	def delete_record(record_id)
		@records.delete_if {|record| record.id == record_id}
	end

	def get_record(record_id)
		@records.find {|record| record.id == record_id}
	end

	def change_name(new_name)
		@name = new_name
	end
end

class Record
	attr_reader :id, :text, :date

	def initialize(text)
		@text = text
		@id = SecureRandom.uuid
		@date = DateTime.now
	end
end
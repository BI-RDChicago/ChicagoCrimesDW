class Location < ApplicationRecord
	self.table_name = "dim_locations"
	has_many :crimes
end

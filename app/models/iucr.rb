class Iucr < ApplicationRecord
	self.table_name = "dim_iucrs"
	has_many :crimes
end

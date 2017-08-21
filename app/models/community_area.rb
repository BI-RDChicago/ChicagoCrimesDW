class CommunityArea < ApplicationRecord
	self.table_name = "dim_community_areas"
	has_many :crimes
end

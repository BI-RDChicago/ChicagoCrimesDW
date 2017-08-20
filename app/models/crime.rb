class Crime < ApplicationRecord
	self.table_name = "fact_crimes"
  belongs_to :CommunityArea	, foreign_key:"dim_community_areas_id"
  belongs_to :dimtime		, foreign_key:"dim_time_id"
  belongs_to :iucr			, foreign_key:"dim_iucrs_id"
  belongs_to :location 		, foreign_key:"dim_locations_id"
end

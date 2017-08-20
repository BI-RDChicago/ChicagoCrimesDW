class Crime < ApplicationRecord
	self.table_name = "fact_crimes"
  belongs_to :CommunityArea	, foreign_key:"dim_community_areas_id"
  belongs_to :DimTime		, foreign_key:"dim_times_id"
  belongs_to :iucr			, foreign_key:"dim_iucrs_id"
  belongs_to :location 		, foreign_key:"dim_locations_id"

  def self.community_filter_scope(start, finish, arrest, comm_id, groupby)
  	if arrest == "all"
			scope = Crime.select("dim_community_areas.description", "sum(quantity) as qnt")
		else
			scope = Crime.select("dim_community_areas.description", "sum(arrest_qnt) as qnt")
		end

		scope = scope.joins(:CommunityArea).group("dim_community_areas.description").order("count(0) desc")

		if !comm_id.blank? 
			scope = scope.where(CommunityArea: comm_id)
		end

		scope = scope.joins(:DimTime)
		scope = scope.where("dim_times.date" => start..finish)

		@community_grouped = scope
  end
end

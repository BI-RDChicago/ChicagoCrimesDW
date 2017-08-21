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
		scope = scope.joins(:DimTime)

		unless comm_id == "0"
			scope = scope.where(CommunityArea: comm_id)
		end
		scope = scope.where("dim_times.date" => start..finish)

		@community_grouped = scope
  end

  def self.time_filter_scope(start, finish, arrest, comm_id, groupby)
  	if groupby == "yyyy"
			if arrest == "all"
				scope = Crime.select("to_char(date, 'yyyy') as start" , "sum(quantity) as qnt").group("to_char(date, 'yyyy'),to_char(date, 'yyyy')").order("sum(quantity) desc")
			else
				scope = Crime.select("to_char(date, 'yyyy') as start" , "sum(arrest_qnt) as qnt").group("to_char(date, 'yyyy'),to_char(date, 'yyyy')").order("sum(arrest_qnt) desc")
			end
		else
			if arrest == "all"
				scope = Crime.select("to_char(date, 'MM/yyyy') as start" , "sum(quantity) as qnt").group("to_char(date, 'MM/yyyy'),to_char(date, 'yyyy/MM')").order("sum(quantity) desc")
			else
				scope = Crime.select("to_char(date, 'MM/yyyy') as start" , "sum(arrest_qnt) as qnt").group("to_char(date, 'MM/yyyy'),to_char(date, 'yyyy/MM')").order("sum(arrest_qnt) desc")
			end
		end

		scope = scope.joins(:CommunityArea)
		scope = scope.joins(:DimTime)		

		unless comm_id == "0"
			scope = scope.where(CommunityArea: comm_id)
		end
		scope = scope.where("dim_times.date" => start..finish)

		@time_filtered = scope
  end

  def self.location_filter_scope(start, finish, arrest, comm_id, groupby)
  	if arrest == "all"
			scope = Crime.select("dim_locations.name", "sum(quantity) as qnt").order("sum(quantity) desc")
		else
			scope = Crime.select("dim_locations.name", "sum(arrest_qnt) as qnt").order("sum(arrest_qnt) desc")
		end

		scope = scope.joins(:location).group("dim_locations.name") 
		scope = scope.joins(:DimTime)

		if comm_id != "0"
			scope = scope.where(CommunityArea: comm_id)
		end
		scope = scope.where("dim_times.date" => start..finish)

		@location_filtered = scope
  end




end

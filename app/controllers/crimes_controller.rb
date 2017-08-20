class CrimesController < ApplicationController

	
	def index

		#@community_areas_map = CommunityArea.all.map { |e| [e.description,e.id]  }
		
		@community_grouped = Crime.select("dim_community_areas.description", "sum(quantity) as qnt")
									.joins(:communityarea).group("dim_community_areas.description")
									.order("sum(quantity) desc")

		@location_grouped = Crime.select("dim_locations.name", "sum(quantity) as qnt")
									.joins(:location).group("dim_locations.name")
									.order("sum(quantity) desc")

		@iucr_grouped = Crime.select("dim_iucrs.primary_description", "sum(quantity) as qnt")
									.joins(:iucr).group("dim_iucrs.primary_description")
									.order("sum(quantity) desc")

	end
end

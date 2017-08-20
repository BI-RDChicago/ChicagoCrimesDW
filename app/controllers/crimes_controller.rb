class CrimesController < ApplicationController

	
	def index

		#@community_areas_map = CommunityArea.all.map { |e| [e.description,e.id]  }
		
		@community_grouped = Crime.select("dim_community_areas.description", "sum(quantity) as qnt")
									.joins(:CommunityArea).group("dim_community_areas.description")
									.order("sum(quantity) desc")

		# @location_grouped = Crime.select("dim_locations.name", "sum(quantity) as qnt")
		# 							.joins(:location).group("dim_locations.name")
		# 							.order("sum(quantity) desc")

		# @iucr_grouped = Crime.select("dim_iucrs.primary_description", "sum(quantity) as qnt")
		# 							.joins(:iucr).group("dim_iucrs.primary_description")
		# 							.order("sum(quantity) desc")

	end

	def communityfilter

		@community_areas = CommunityArea.all.order("description")

	end

	def timefilter

		@community_areas = CommunityArea.all.order("description")

	end

	def locationfilter

		@community_areas = CommunityArea.all.order("description")

	end

	def communityfilterapply

		@start = Date.new(*params[:start].values.map(&:to_i))
		@finish = Date.new(*params[:finish].values.map(&:to_i))
		@arrest = params[:arrest]
		@id_source = params[:comm_id]
		@communityarea_desc = @id_source != "0" ? CommunityArea.find(@id_source).description : "All"


		scope = Crime.select("community_areas.description", "sum(quantity) as qnt").joins(:CommunityArea).group("community_areas.description").order("count(0) desc")

		scope = @id_source != "0" ? scope.where(CommunityArea: @id_source) : scope 
		scope = @arrest != "all" ? scope.where(arrest: @arrest) : scope 

		@community_grouped = scope

	end

	def timefilterapply

		@start = Date.new(*params[:start].values.map(&:to_i))
		@finish = Date.new(*params[:finish].values.map(&:to_i))
		@arrest = params[:arrest]
		@id_source = params[:comm_id]
		@groupby = params[:groupby]
		@communityarea_desc = @id_source != "0" ? CommunityArea.find(@id_source).description : "All"
		
		scope = @groupby == "yyyy" ? Crime.select("to_char(date, 'yyyy') as start" , "count(0) as qnt").group("to_char(date, 'yyyy'),to_char(date, 'yyyy')") 
								   : Crime.select("to_char(date, 'MM/yyyy') as start" , "count(0) as qnt").group("to_char(date, 'MM/yyyy'),to_char(date, 'yyyy/MM')")  
		
		scope = scope.joins(:CommunityArea).order("count(0) desc")

		scope = @id_source != "0" ? scope.where(CommunityArea: @id_source) : scope 
		scope = @arrest != "all" ? scope.where(arrest: @arrest) : scope 

		@time_filtered = scope
	end

	def locationfilterapply

		@start = Date.new(*params[:start].values.map(&:to_i))
		@finish = Date.new(*params[:finish].values.map(&:to_i))
		@arrest = params[:arrest]
		@id_source = params[:comm_id]
		@groupby = params[:groupby]
		@communityarea_desc = @id_source != "0" ? CommunityArea.find(@id_source).description : "All"
		
		scope = Crime.select("location_description as location" , "count(0) as qnt").group("location_description") 

		scope = scope.joins(:CommunityArea).order("count(0) desc")

		scope = @id_source != "0" ? scope.where(CommunityArea: @id_source) : scope 
		scope = @arrest != "all" ? scope.where(arrest: @arrest) : scope 

		@location_filtered = scope
	end
end

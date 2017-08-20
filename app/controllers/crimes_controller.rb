class CrimesController < ApplicationController

	
	def index
		
		@community_grouped = Crime.select("dim_community_areas.description", "sum(quantity) as qnt")
									.joins(:CommunityArea).group("dim_community_areas.description")
									.order("sum(quantity) desc")

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

		if @arrest == "all"
			scope = Crime.select("dim_community_areas.description", "sum(quantity) as qnt")
		else
			scope = Crime.select("dim_community_areas.description", "sum(arrest_qnt) as qnt")
		end

		scope = scope.joins(:CommunityArea).group("dim_community_areas.description").order("count(0) desc")

		if @id_source != "0"
			scope = scope.where(CommunityArea: @id_source)
		end

		@community_grouped = scope

	end

	def timefilterapply

		@start = Date.new(*params[:start].values.map(&:to_i))
		@finish = Date.new(*params[:finish].values.map(&:to_i))
		@arrest = params[:arrest]
		@id_source = params[:comm_id]
		@groupby = params[:groupby]
		@communityarea_desc = @id_source != "0" ? CommunityArea.find(@id_source).description : "All"
		
		if @groupby == "yyyy"
			if @arrest == "all"
				scope = Crime.select("to_char(date, 'yyyy') as start" , "sum(quantity) as qnt").group("to_char(date, 'yyyy'),to_char(date, 'yyyy')").order("sum(quantity) desc")
			else
				scope = Crime.select("to_char(date, 'yyyy') as start" , "sum(arrest_qnt) as qnt").group("to_char(date, 'yyyy'),to_char(date, 'yyyy')").order("sum(arrest_qnt) desc")
			end
		else
			if @arrest == "all"
				scope = Crime.select("to_char(date, 'MM/yyyy') as start" , "sum(quantity) as qnt").group("to_char(date, 'MM/yyyy'),to_char(date, 'yyyy/MM')").order("sum(quantity) desc")
			else
				scope = Crime.select("to_char(date, 'MM/yyyy') as start" , "sum(arrest_qnt) as qnt").group("to_char(date, 'MM/yyyy'),to_char(date, 'yyyy/MM')").order("sum(arrest_qnt) desc")
			end
		end

		scope = scope.joins(:CommunityArea)		
		scope = scope.joins(:DimTime)

		if @id_source != "0"
			scope = scope.where(CommunityArea: @id_source)
		end

		@time_filtered = scope
	end

	def locationfilterapply

		@start = Date.new(*params[:start].values.map(&:to_i))
		@finish = Date.new(*params[:finish].values.map(&:to_i))
		@arrest = params[:arrest]
		@id_source = params[:comm_id]
		@groupby = params[:groupby]
		@communityarea_desc = @id_source != "0" ? CommunityArea.find(@id_source).description : "All"
		

		if @arrest == "all"
			scope = Crime.select("dim_locations.name", "sum(quantity) as qnt").order("sum(quantity) desc")
		else
			scope = Crime.select("dim_locations.name", "sum(arrest_qnt) as qnt").order("sum(arrest_qnt) desc")
		end

		scope = scope.joins(:location).group("dim_locations.name") 

		if @id_source != "0"
			scope = scope.where(CommunityArea: @id_source)
		end

		@location_filtered = scope
	end
end

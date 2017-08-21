class CrimesController < ApplicationController

	
	def index
		
		@community_grouped = Crime.select("dim_community_areas.description", "sum(quantity) as qnt")
									.joins(:CommunityArea).group("dim_community_areas.description")
									.order("sum(quantity) desc")

	end	

	def filters(start, finish, arrest, comm_id, groupby)
		@start = Date.new(*start.values.map(&:to_i))
		@finish = Date.new(*finish.values.map(&:to_i))
		@arrest = arrest
		@comm_id = comm_id
		@groupby = groupby
		community_area_description(@comm_id)
	end

	def community_area_description(comm_id)		
		if @comm_id == "0"
			@community_area_desc = "All"
		else
			@community_area_desc = CommunityArea.find(comm_id).description
		end
	end

	def community_filter
		@community_areas = CommunityArea.all.order("description")
	end

	def time_filter
		@community_areas = CommunityArea.all.order("description")
	end

	def location_filter
		@community_areas = CommunityArea.all.order("description")
	end

	def community_filter_apply
		filters(params[:start], params[:finish], params[:arrest], params[:comm_id], params[:groupby])		

		@community_filtered = Crime.community_filter_scope(@start, @finish, @arrest, @comm_id, @groupby)

	end

	def time_filter_apply
		filters(params[:start], params[:finish], params[:arrest], params[:comm_id], params[:groupby])		
		
		@time_filtered = Crime.time_filter_scope(@start, @finish, @arrest, @comm_id, @groupby)
	end

	def location_filter_apply

		filters(params[:start], params[:finish], params[:arrest], params[:comm_id], params[:groupby])		

		@location_filtered = Crime.location_filter_scope(@start, @finish, @arrest, @comm_id, @groupby)
	end
end

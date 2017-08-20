Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  
  	root 'crimes#index'

 	get 'community_filter' => 'crimes#community_filter'
 	get 'time_filter' => 'crimes#time_filter'
 	get 'location_filter' => 'crimes#location_filter'

	post 'community_filter_apply' => 'crimes#community_filter_apply'
	post 'time_filter_apply' => 'crimes#time_filter_apply'
	post 'location_filter_apply' => 'crimes#location_filter_apply'
	
 	resources :crimes
end

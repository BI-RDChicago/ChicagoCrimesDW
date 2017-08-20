Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  
  	root 'crimes#index'
  	
 	get 'communityfilter' => 'crimes#communityfilter'
 	get 'timefilter' => 'crimes#timefilter'
 	get 'locationfilter' => 'crimes#locationfilter'

	post 'communityfilterapply' => 'crimes#communityfilterapply'
	post 'timefilterapply' => 'crimes#timefilterapply'
	post 'locationfilterapply' => 'crimes#locationfilterapply'
end

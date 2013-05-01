Reverter::Engine.routes.draw do
	post "versions/:id/revert" => "versions#revert", :as => "revert_version"
end

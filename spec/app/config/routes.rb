Rails.application.routes.draw do

  mount Reverter::Engine => "/reverter"
  post "posts" => "posts#create", :as => "posts"
  put "articles" => "posts#multiple", :as => "multiple_posts"
  post "articles" => "articles#create", :as => "articles"
  put "articles" => "articles#multiple", :as => "multiple_articles"  
end

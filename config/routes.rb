Rails.application.routes.draw do
  resources :progresses
  root to: 'user_sessions#index'
  resources :user_sessions, only: [:index, :create, :destroy]
  resources :top
  resources :checksheets do
    collection { get 'ict_1'}
    collection { get 'ict_2'}
    collection { get 'ict_3'}
    collection { get 'guidance_1'}
    collection { get 'guidance_2'}
    collection { get 'guidance_3'}
    collection { get 'health_1'}
    collection { get 'health_2'}
    collection { get 'health_3'}
  end
  resources :categories, shallow: true do
    resources :videos
    resources :questionnaires, only: [:index]
  end
  resources :comments
  resources :questionnaire_answers

  resources :last_questionnaire_answers, controller: :questionnaire_answers

  get 'text' => 'top#text'
  get 'questionnaire' => 'top#questionnaire'
  get 'last_questionnaire' => 'questionnaires#last_index'
  # get 'elearning_manual.pdf' => 'top#elearning_manual'

  get 'mypage' => 'users#mypage'

  get 'login' => 'user_sessions#create', :as => :login
  post 'logout' => 'user_sessions#destroy', :as => :logout

  post 'checksheet_answers/draft'

  get 'video' => 'videos#video'

  namespace :api do
    post 'questionnaire_answers/draft'
    post 'last_questionnaire_answers/draft'
  end

  post 'self_checks/save'

  namespace :admin do
    resources :categories, shallow: true do
      resources :questionnaires
      resources :videos
    end
    resources :category_types
    resources :categories
    resources :top
    resources :csv_export, only: [:index]
    get 'csv_export_progress_checksheet' => 'csv_export#progress_checksheet'
    get 'csv_export_questionnaire' => 'csv_export#questionnaire'
  end
end

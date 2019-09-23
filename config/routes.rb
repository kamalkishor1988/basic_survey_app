Rails.application.routes.draw do
  resources :answers
  resources :questions
  resources :surveys
  get 'homes/index'

  devise_for :users
  root 'surveys#index'
  get 'surveys/:id/view_responses', to: 'surveys#view_responses', as: :view_responses
  #APIs
  # api to get the list of existing survey
  get '/api/surveys', to: 'surveys#get_surveys_list'
  # api to add questions to the survey
  post '/api/surveys/:id/questions', to: 'surveys#add_questions'
  # api to get questions to the survey
  get '/api/surveys/:id/questions', to: 'surveys#get_questions'
  # api to add or delete questions to the survey
  delete 'api/surveys/:id/questions/:question_id', to: 'surveys#delete_questions'

  # api to take the survey
  post 'api/surveys/take_survey', to: 'surveys#take_survey'
end

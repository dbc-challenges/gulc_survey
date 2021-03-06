get '/surveys/new' do
  #CODE REVIEW: Create a current user helper  call it from a before filter

  @user = session[:user_id] if session[:user_id]
  erb :create_survey
end

get '/surveys/:id' do
  @user = session[:user_id] if session[:user_id]
  @survey = Survey.find(params[:id])
  erb :show_survey
end

post '/surveys' do
  @user = User.find(session[:user_id])
  @survey = Survey.create(user: @user, name: params[:name])
  @survey_id = @survey.id

  erb :_add_question
end

post '/surveys/:id/questions' do |id|
  @user = User.find(session[:user_id])
  @survey = Survey.find(id)
  @survey_id = id
  question = @survey.questions.create(prompt: params[:prompt])
  @question_id = question.id
  
  erb :_add_choice
end

post '/surveys/:survey_id/questions/:question_id/choices' do |survey_id, question_id|
  @user = User.find(session[:user_id])
  @survey_id = survey_id
  @question_id = question_id
  @question = Question.find(question_id)
  @question.choices.create(content: params[:choice])

  erb :_add_choice
end

post '/surveys/:id/another_q' do |id|
  @user = User.find(session[:user_id])
  @survey_id = id
  erb :_add_question
end



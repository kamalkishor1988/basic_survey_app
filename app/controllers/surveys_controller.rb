class SurveysController < ApplicationController
  skip_before_action :verify_authenticity_token, only: [
    :get_surveys_list, :add_questions, :delete_questions, :get_questions, :take_survey
  ]

  before_action :set_survey, only: [
    :show, :edit, :update, :destroy, :view_responses, :add_questions, :delete_questions, :get_questions
  ]

  before_action :authenticate_user!, except: [
    :get_surveys_list, :add_questions, :delete_questions, :get_questions, :take_survey
  ]

  before_action :authorize_admin, except: [
    :get_surveys_list, :add_questions, :delete_questions, :get_questions, :take_survey
  ]

  def index
    @surveys = Survey.all
  end

  def show
  end

  def new
    @survey = Survey.new
  end

  def edit
  end

  def create
    @survey = Survey.new(survey_params)

    respond_to do |format|
      if @survey.save
        format.html { redirect_to @survey, notice: 'Survey was successfully created.' }
        format.json { render :show, status: :created, location: @survey }
      else
        format.html { render :new }
        format.json { render json: @survey.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @survey.update(survey_params)
        format.html { redirect_to @survey, notice: 'Survey was successfully updated.' }
        format.json { render :show, status: :ok, location: @survey }
      else
        format.html { render :edit }
        format.json { render json: @survey.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @survey.destroy
    respond_to do |format|
      format.html { redirect_to surveys_url, notice: 'Survey was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def view_responses
    survey_questions = @survey.questions.includes(:answers)
    @survey_questions_content = survey_questions.map(&:content)
    @survey_answers_content = []
    survey_questions.each do |question|
      @survey_answers_content << question.answers.map(&:content)
    end
  end

  # APIs methods
  def get_surveys_list
    surveys = Survey.all
    render json: surveys
  end

  def add_questions
    survey_questions = @survey.questions.create!(content: params[:questions_attributes][:content])
    render json: survey_questions
  end

  def get_questions
    survey_questions = @survey.questions
    render json: survey_questions
  end

  def delete_questions
    question = @survey.questions.find(params[:question_id])
    question.destroy
    render json: { success: "Question deleted succesfully", status: 204 }
  end

  def take_survey
    question = Question.find(params[:questions_attributes][:id])
    question.answers.create!(content: params[:questions_attributes][:answers_attributes][:content])
    render json: { success: "Survey response added succesfully", status: 200 }
  end

  private
    def set_survey
      @survey = Survey.find(params[:id])
    end

    def survey_params
      params.require(:survey).permit(:title, questions_attributes: [ :id, :content, :_destroy, answers_attributes: [ :content, :_destroy ] ])
    end

    def authorize_admin
      redirect_to main_app.homes_index_path unless current_user.is_admin == true
    end
end

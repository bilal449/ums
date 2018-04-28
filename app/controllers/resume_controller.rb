class ResumeController < ApplicationController

  before_action :authenticate_user
  

  def new
  	if session[:user_id]
      @user = User.find(session[:user_id])
      
      if @user.resume
      	redirect_to :controller=>'home', :action=>'index'
      end

    end
  end

  def create
  	@resume = Resume.new(resume_params)
  	@resume.user_id = session[:user_id]

  	respond_to do |format|
      
      if @resume.save
        format.html { redirect_to :controller => 'home', :action => 'index' }

      else
        format.html { render :new }
        format.json { render json: @resume.errors, status: :unprocessable_entity }
      end
    end
  end

  private
  
  def authenticate_user
    if session[:user_id].nil?
         flash[:danger] = "Please log in to Continue."
         redirect_to :controller => 'home', :action => 'sign_in'
    else
      
    end
      
  end

  

  def resume_params
      params.require(:resume).permit(:student_name, :student_no, :programming_skills, :contact_information, :list_of_subjects, :hobbies_and_interests)
  end

end

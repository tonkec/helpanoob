class SkillsController < ApplicationController
  before_action :correct_user, only: [:destroy]
  skip_before_filter :verify_authenticity_token, :only => :create if Rails.env.test?

  def new
    @skill = Skill.new
  end

  def create
    @skill = current_user.skills.build(skill_params)
    @permitted_skills = ["ruby", "rails", "ruby on rails", "jquery", "javascript", "php", "sql", "css", "html"]
    
    @skill.name.downcase!

    respond_to do |format|
      
      if @skill.save
        format.html { redirect_to profile_path, notice: 'Skill was successfully created.' }
        format.js
      else
        format.html { render action: "new" }
        format.js {  }
      end
    
    end

  end


  def destroy
    @skill = Skill.find(params[:id])
    @skill.destroy
    redirect_to profile_path
  end

  private

  def skill_params
    params.require(:skill).permit(:name, :strength)
  end

  def correct_user
    @skill = current_user.skills.find_by_id(params[:id])
    redirect_to root_url if @skill.nil?
  end
end

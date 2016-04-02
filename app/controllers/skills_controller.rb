class SkillsController < ApplicationController
  
  def new
    @skill = Skill.new
  end

  def create
    @skill = current_user.skills.build(skill_params)
    @permitted_skills = ["ruby", "rails", "ruby on rails", "jquery", "javascript", "php", "sql", "css", "html"]
    @skill.name.downcase!
    if @permitted_skills.include? @skill.name
      if @skill.save
        redirect_to profile_path
        flash.now[:success] = "You have successfully added new skill!"
      else
        render 'new'
        flash.now[:danger] = "Please fix the errors." 
      end
    else 
      flash.now[:danger] = "Please choose proper skill." 
      render 'new'
    end 
  end

  private

  def skill_params
    params.require(:skill).permit(:name, :strength)
  end
end

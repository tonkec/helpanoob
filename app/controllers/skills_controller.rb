class SkillsController < ApplicationController
  
  def new
  end

  def create
    @skill = current_user.skills.build(skill_params)

    if @skill.save
      redirect_to profile_path
      flash.now[:success] = "You have successfully added new skill!"
    else
      render 'new'
    end 
  end

  private

  def skill_params
    params.require(:skill).permit(:name, :strength)
  end
end

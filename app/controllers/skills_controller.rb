class SkillsController < ApplicationController
  

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

  def edit
  end

  def update 
    @skill = current_user.skills.find(params[:id])
    respond_to do |format|
      if @skill.update_attributes(skill_params)
        format.html { redirect_to profile_path, notice: 'Comment was successfully created.' }
        format.json { render :show, status: :ok, location: @skill }
        format.js
      else
        format.html { render :new }
        format.json { render json: @skill.errors, status: :unprocessable_entity }
        format.js
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
end

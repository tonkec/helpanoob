class PostsController < ApplicationController
  before_action :set_post, only: [:show, :edit, :update, :destroy, :upvote, :downvote]
  before_action :authenticate_user!
  before_action :correct_user, only: [:edit]
  # GET /posts
  # GET /posts.json
  def index
    @q = Post.ransack(params[:q])
    @posts = @q.result(distinct: true).order('created_at desc').page(params[:page]).per(5)
    @post = Post.new



    Post.all.each do |x| 
        
    end
  end

  # GET /posts/1
  # GET /posts/1.json
  def show
    @post = Post.find(params[:id])
  end

  # GET /posts/new
  def new
    @post = Post.new
    @groups = Group.all
  end

  # GET /posts/1/edit
  def edit
  end

  # POST /posts
  # POST /posts.json
  def create
    @post = current_user.posts.build(post_params)
    respond_to do |format|
     if @post.update(post_params)
      format.html { redirect_to @post, notice: 'Post was successfully created.' }
      format.json { render :show, status: :ok, location: @post }
      format.js
    else
      format.html { render :new }
      format.json { render json: @post.errors, status: :unprocessable_entity }
      format.js
    end
  end
  end

  # PATCH/PUT /posts/1
  # PATCH/PUT /posts/1.json
  def update
    respond_to do |format|
      if @post.update(post_params)
        format.html { redirect_to @post, notice: 'Post was successfully updated.' }
        format.json { render :show, status: :ok, location: @post }
        format.js
      else
        format.html { render :edit }
        format.json { render json: @post.errors, status: :unprocessable_entity }
        format.js
      end
    end
  end

  # DELETE /posts/1
  # DELETE /posts/1.json
  def destroy
    @post.destroy
    respond_to do |format|
      format.html { redirect_to posts_url, notice: 'Post was successfully destroyed.' }
      format.json { head :no_content }
      format.js
    end
  end

  def upvote
    @post.upvote_from current_user
    redirect_to post_path(@post)
  end

  def downvote
    @post.downvote_from current_user
    redirect_to post_path(@post)
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_post
      @post = Post.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def post_params
      params.require(:post).permit(:description, :title, :user_id, :group_id, :image)
    end

    def correct_user
     @right_post = Post.find(params[:id])
     @user_id = @right_post.user_id
     redirect_to root_path unless current_user.id == @right_post.user_id
    end
end

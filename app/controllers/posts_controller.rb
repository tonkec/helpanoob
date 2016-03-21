# == Schema Information
#
# Table name: posts
#
#  id                      :integer          not null, primary key
#  description             :text
#  user_id                 :integer
#  created_at              :datetime         not null
#  updated_at              :datetime         not null
#  title                   :string
#  image                   :string
#  cached_votes_total      :integer          default(0)
#  cached_votes_score      :integer          default(0)
#  cached_votes_up         :integer          default(0)
#  cached_votes_down       :integer          default(0)
#  cached_weighted_score   :integer          default(0)
#  cached_weighted_total   :integer          default(0)
#  cached_weighted_average :float            default(0.0)
#  comments_count          :integer          default(0)
#

  class PostsController < ApplicationController
  before_action :set_post, only: [:show, :edit, :update, :destroy, :upvote, :downvote]
  before_action :authenticate_user!
  skip_before_action :verify_authenticity_token, only: [:update]
  before_action :correct_user, only: [:edit, :update, :destroy]


  # GET /posts
  # GET /posts.json
  def index
    if params[:tag]
      @tagged_posts = Post.tagged_with(params[:tag])
      @q = @tagged_posts.ransack(params[:q])
      @posts = @q.result(distinct: true).order('created_at desc').page(params[:page])
    else
      @q = Post.ransack(params[:q])
      @posts = @q.result(distinct: true).order('created_at desc').page(params[:page])
    end
  end

  def unanswered
    #if params[:tag]
      @unanswered_posts = Post.uncommented
    #end

  end

  # GET /posts/1
  # GET /posts/1.json
  def show
    @post = Post.find(params[:id])
    @comment = @post.comments
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
    redirect_to posts_path
    flash.now[:success] = "Post was successfully destroyed"
  end

  def upvote
    @post.liked_by current_user
    respond_to do |format|
      format.html { redirect_to @post }
      format.json { head :no_content }
      format.js { render :layout => false }
    end
  end

  def downvote
    @post.unliked_by current_user
     respond_to do |format|
      format.html { redirect_to @post }
      format.json { head :no_content }
      format.js { render :layout => false }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_post
      @post = Post.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def post_params
      params.require(:post).permit(:description, :title, :image, :tag_list)
    end

    def correct_user
     @right_post = Post.find(params[:id])
     @user_id = @right_post.user_id
     redirect_to root_path unless current_user.id == @right_post.user_id
    end
end

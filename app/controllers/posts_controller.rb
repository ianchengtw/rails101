class PostsController < ApplicationController
  before_action :authenticate_user!, except: [:show]
  before_action :find_group
  before_action :post_author_check, only: [:edit, :update, :destroy]

  def new
    @post = @group.posts.new
  end

  def create
    @post = @group.posts.build(post_params)
    @post.author = current_user

    if @post.save
      flash[:notice] = 'Added a post'
    else
      flash[:alert] = 'Added a post failed'
    end

    redirect_to group_path(@group)
  end

  def show
    @post = @group.posts.find(params[:id])
  end

  def edit
    @post = @group.posts.find(params[:id])

    # if !@post.editable_by?(current_user)
    #   flash[:alert] = 'You are not the owner of this group, cannot edit'
    #   redirect_to group_path(@group)
    # end
  end

  def update
    @post = @group.posts.find(params[:id])

    if @post.update(post_params)
      flash[:notice] = 'Updated a post'
    else
      flash[:alert] = 'Updated a post failed'
    end

    redirect_to group_path(@group)
  end

  def destroy
    @post = @group.posts.find(params[:id])
    @post.destroy
    flash[:notice] = 'Post deleted'
    redirect_to group_path(@group)
  end

  private
  def find_group
    @group = Group.find(params[:group_id])
  end

  def post_author_check
    @post = @group.posts.find(params[:id])
    if !@post.editable_by?(current_user)
      flash[:alert] = 'You are not the owner of this group, cannot edit'
      redirect_to group_path(@group)
    end
  end

  def post_params
    params.require(:post).permit(:content)
  end
end

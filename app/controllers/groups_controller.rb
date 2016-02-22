class GroupsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :edit, :update, :destroy]
  before_action :find_group, only: [:show, :edit, :update, :destroy, :join, :quit]
  before_action :group_owner_check, only: [:edit, :update, :destroy]

  def index
    @groups = Group.all
  end

  def new
    @group = Group.new
  end

  def create
    @group = Group.create(group_params)
    @group.owner = current_user

    if @group.save
      flash[:notice] = 'New Group Successed'
    else
      flash[:alert] = 'New Group failed'
    end

    redirect_to groups_path
  end

  def show
  end

  def edit
  end

  def update
    if @group.update(group_params)
      flash[:notice] = 'Update Group Successed'
    else
      flash[:alert] = 'Update Group failed'
    end

    redirect_to groups_path
  end

  def destroy
    @group.destroy
    flash[:notice] = 'Group Deleted'
    redirect_to groups_path
  end

  def join
    if current_user.is_member_of?(@group)
      flash[:warning] = 'You have already joined this group'
    else
      current_user.join!(@group)
      flash[:notice] = 'Join group successed'
    end

    redirect_to group_path(@group)
  end

  def quit
    if current_user.is_member_of?(@group)
      current_user.quit!(@group)
      flash[:notice] = 'Quit group successed'
    else
      flash[:warning] = 'You are not a member of this group'
    end

    redirect_to group_path(@group)
  end

  private
  def find_group
    @group = Group.find(params[:id])
  end

  def group_owner_check
    if !@group.editable_by?(current_user)
      flash[:alert] = 'You are not the owner of this group, cannot edit'
      redirect_to groups_path
    end
  end

  def group_params
    params.require(:group).permit(:title, :description)
  end

end

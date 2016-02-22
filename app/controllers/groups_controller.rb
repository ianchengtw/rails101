class GroupsController < ApplicationController
  def index
    @groups = Group.all
  end

  def new
    @group = Group.new
  end

  def create
    @group = Group.create(group_params)

    if @group.save
      flash[:notice] = 'New Group Successed'
    else
      flash[:alert] = 'New Group failed'
    end

    redirect_to groups_path
  end

  def show
    @group = Group.find(params[:id])
  end

  def edit
    @group = Group.find(params[:id])
  end

  def update
    @group = Group.find(params[:id])

    if @group.update(group_params)
      flash[:notice] = 'Update Group Successed'
    else
      flash[:alert] = 'Update Group failed'
    end

    redirect_to groups_path
  end

  def destroy
    @group = Group.find(params[:id])
    @group.destroy
    flash[:notice] = 'Delete Group Successed'
    redirect_to groups_path
  end

  private
  def group_params
    params.require(:group).permit(:title, :description)
  end

end

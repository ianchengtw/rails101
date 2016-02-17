class GroupsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :edit, :update, :destroy]

  def index
    @groups = Group.all
  end

  def new
    @group = Group.new
  end

  def show
    @group = Group.find(params[:id])
    @posts = @group.posts
  end

  def create
    @group = current_user.groups.create(group_params)

    if @group.save
      current_user.join!(@group)
      redirect_to groups_path
    else
      flash[:alert] = 'Create Group Error'
      render new
    end
  end

  def edit
    @group = current_user.groups.find(params[:id])
  end

  def update
    @group = current_user.groups.find(params[:id])

    if @group.update(group_params)
      redirect_to groups_path, notice: '修改討論版成功'
    else
      flash[:alert] = 'Update Group Error'
      render edit
    end
  end

  def destroy
    @group = current_user.groups.find(params[:id])
    @group.destroy
    redirect_to groups_path, notice: '刪除討論版成功'
  end

  def join
    @group = Group.find(params[:id])

    if current_user.is_member_of?(@group)
      flash[:warning] = '你已經是本討論版的成員了!'
    else
      current_user.join!(@group)
      flash[:notice] = '加入本討論版成功!'
    end

    redirect_to group_path(@group)
  end

  def quit
    @group = Group.find(params[:id])

    if current_user.is_member_of?(@group)
      current_user.quit!(@group)
      flash[:notice] = '已退出本討論版'
    else
      flash[:alert] = '非本討論版成員'
    end

    redirect_to group_path(@group)
  end

  private
  def group_params
    params.require(:group).permit(:title, :description)
  end
end

class Account::PostsController < ApplicationController
  def index
    @posts = Post.where(user_id: current_user.id)
  end
end

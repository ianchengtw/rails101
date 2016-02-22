class Account::GroupsController < ApplicationController
  def index
    @groups = current_user.participated_groups.order('posts_count DESC')
  end
end

class ListsController < ApplicationController
  def index
  end

  def show
    @list = current_user.list
  end

  def new
  end

  def edit
  end
end

class ListsController < ApplicationController
  before_action :authenticate_user! # users must be signed in before any lists_controller method
  
  def index
  end

  def show
    @list = List.find(params[:id])
    @items = @list.items.paginate(page: params[:page], per_page: 10)
    @item = Item.new
    
  end

  def new
    @list = List.new
  end
  
  def create
    @list = List.new(params.require(:list).permit(:title, :body))
      if @list.save
        flash[:notice] = "List was saved."
        redirect_to @list
      else
        flash[:error] = "There was an error saving the post. Please try again."
        render :new
      end
  end

  def edit
    @list = List.find(params[:id])
  end

  def destroy
    @list = List.find(params[:id])
    #authorize missing
    
    if @list.destroy
      flash[:notice] = "List was destroyed."
      redirect_to root_path
    else
      flash[:error] = "There was an error deleting the post. Please try again."
      render @list
    end
  end

  def update
    @list = List.find(params[:id])

    #authorize missing
  
    if @list.update_attributes(params.require(:list).permit(:title, :body))
      flash[:notice] = "List was updated."
      redirect_to [@list]
    else
      flash[:error] = "There was an error saving the post. Please try again."
      render :new
    end
  end

end
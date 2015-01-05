class ListsController < ApplicationController
  before_action :authenticate_user! # users must be signed in before any lists_controller method
  
  respond_to :html, :js, :json
  
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
    
    respond_with(@comment) do |format|
      format.html { redirect_to [@post.topic, @post] }
    end
  end

  def update
    @list = List.find(params[:id])

    #authorize missing
  
    @list.update_attributes(params.require(:list).permit(:title, :body))
    respond_with @list
  end

end
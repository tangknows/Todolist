class ItemsController < ApplicationController
  
  def show
    @list = List.find(params[:list_id])
    @item = Item.find(params[:id])
  end
  
  
  def create
    @list = List.find(params[:list_id])
    @item = @list.items.new(item_params)
    
      if @item.save
        flash[:notice] = "Item was saved."
        redirect_to [@list]
      else
        flash[:error] = "There was an error saving the post. Please try again."
        redirect_to [@list]
      end
    
  end
  
  
  def item_params
    params.require(:item).permit(:name)
  end
  
end

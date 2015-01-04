class ItemsController < ApplicationController
  respond_to :html, :js
  
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
  
  def destroy
    @list = List.find(params[:list_id])
    @item = Item.find(params[:id])
    name = @item.name
    
    if @item.destroy
      flash[:notice] = "Item was destroyed"
    else
      flash[:error] = "There was an error destroying this item"
    end
  
  respond_with(@item) do |format|
    format.html { redirect_to [@list] }
  end

end
  
  
  def item_params
    params.require(:item).permit(:name, :list_id)
  end
  
end

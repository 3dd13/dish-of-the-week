class RestaurantsController < ApplicationController

  respond_to :json

  def index
    @restaurants = params[:id] ? Restaurant.where('id in (?)', params[:id].split(",")) : Restaurant.all
  end

  def new
    @restaurant = Restaurant.new
  end

  def create
    @restaurant = Restaurant.new(restaurant_params)

    if @restaurant.save
      redirect_to curated_posts_new_url
    else
      head :unprocessable_entity
    end
  end  

  def update
    @restaurant = Restaurant.where('id = ?', params[:id]).take
    
    if @restaurant
      if @restaurant.update(post_params)
        head :ok
      else
        head :unprocessable_entity
      end
    else head :not_found
    end
  end

  def destroy
    render text: "Destroying restaurant #" + params[:id]
    @restaurant.destroy if @restaurant = Restaurant.where('id = ?', params[:id]).take

    head :no_content
  end 

  private

  def restaurant_params
    params.require(:restaurant).permit( :name, :price_range, :cuisine_type, :address, :tel, :latitude, :longitude, :url)
  end

end
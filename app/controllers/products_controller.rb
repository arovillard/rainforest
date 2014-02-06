class ProductsController < ApplicationController
  before_filter :ensure_logged_in, :except => [:show, :index, :search]
  before_filter :load_product, :only => [:show, :edit, :update, :destroy]
  before_filter :ensure_ownership, :only => [:edit, :update]


  def index
    @products = Product.all
  end

  def show
    if current_user
      @review = @product.reviews.build
    end
  end

  def new
    @product = Product.new
  end

  def create
    @product = Product.new(product_params)
    @product.owner = current_user
    if @product.save
      redirect_to products_path
    else
      render :new
    end
  end

  def edit

  end

  def update
    if @product.update_attributes(product_params)
      redirect_to products_path(@product)
    else
      render :edit
    end
  end

  def destroy
    @Product.destroy
    redirect_to products_path
  end
  def search
    @products = Product.where("name like ? OR description like ?", "%#{params[:search]}%", "%#{params[:search]}%")
    # @total = @posts.total
  end

  private

  def load_product
    @product = Product.find(params[:id])
  end

  def ensure_ownership
    unless current_user.id == @product.user_id
      flash[:alert] = "NOOO YOU DON'T OWN THIS"
      redirect_to product_path(@product)
    end
  end

  def product_params
    params.require(:product).permit(:name, :description, :price_in_cents, :picture_url, :user_id)
  end

end

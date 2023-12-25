class ProductsController < ApplicationController
  before_action :set_product, only: %i[ show edit update destroy ]
  before_action :authenticate_user!, except: %i[ index show ]

  def index
    @products = Product.all
  end

  def show
  end

  def new
    if current_user.try(:type)
      @product = Product.new
    else
      redirect_to root_path
    end
  end

  def edit
    if current_user.try(:type)
    else
      redirect_to root_path
    end

  end

  def create
    @product = Product.new(product_params)

    if @product.save
      redirect_to product_url(@product), notice: "Product was successfully created."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    if @product.update(product_params)
      redirect_to product_url(@product), notice: "Product was successfully updated."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @product.destroy
    redirect_to products_url, notice: "Product was successfully destroyed."
  end

  private
    def set_product
      @product = Product.find(params[:id])
    end

    def product_params
      params.require(:product).permit(:name, :description, :price, images: [])
    end
end

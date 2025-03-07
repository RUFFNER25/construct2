class ProductsController < ApplicationController
  before_action :set_product, only: %i[ show edit update destroy ]
  rescue_from ActiveRecord::RecordNotFound, with: :producto_no_encontrado

  # GET /products
  def index
    @products = Product.all
  end

  # GET /products/1
  def show
  end

  # GET /products/new
  def new
    @product = Product.new
  end

  # GET /products/1/edit
  def edit
  end

  # POST /products
  def create
    @product = Product.new(product_params)

    if @product.save
      redirect_to @product, notice: "Product was successfully created."
    else
      render :new, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /products/1
  def update
    if @product.update(product_params)
      redirect_to @product, notice: "Product was successfully updated."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  # DELETE /products/1
  def destroy
    @product.destroy!
    redirect_to products_path, status: :see_other, notice: "Product was successfully destroyed."
  end

  private

    # Busca el producto y maneja el error si no se encuentra
    def set_product
      @product = Product.find(params[:id])
    end

    # Método para manejar cuando un producto no existe
    def producto_no_encontrado
      flash[:alert] = "Product not registered"
      redirect_to products_path
    end

    # Solo permite parámetros confiables
    def product_params
      params.require(:product).permit(:name, :price, :description)
    end
end


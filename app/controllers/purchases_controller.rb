class PurchasesController < ApplicationController
  before_action :set_purchase, only: [:show, :update, :destroy]

  # GET /purchases
  def index
    @purchases = Purchase.all

    render json: @purchases
  end

  # GET /purchases/1
  def show
    render json: @purchase
  end

  # POST /purchases
  def create
    @purchase = Purchase.new(
      title: purchase_params[:title],
      category_id: purchase_params[:category_id],
      price: purchase_params[:price])

    if @purchase.save
      render json: @purchase, status: :created, location: @purchase
    else
      render json: @purchase.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /purchases/1
  def update
    if @purchase.update(
      title: purchase_params[:title],
      category_id: purchase_params[:category_id],
      price: purchase_params[:price])
      render json: @purchase
    else
      render json: @purchase.errors, status: :unprocessable_entity
    end
  end

  # DELETE /purchases/1
  def destroy
    @purchase.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_purchase
      #@purchase = Purchase.find(params[:attributes][])


      @purchase = Purchase.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def purchase_params
      params
        .require(:data)
          .require(:attributes)
            .permit(:title, :price, :category_id)
      #params.require(:purchase).permit(:category_id, :price)
    end
end

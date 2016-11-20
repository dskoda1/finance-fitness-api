class PurchaseNamesController < ApplicationController
  before_action :set_purchase_name, only: [:show, :update, :destroy]

  # GET /purchase_names
  def index
    @purchase_names = PurchaseName.all

    render json: @purchase_names
  end

  # GET /purchase_names/1
  def show
    render json: @purchase_name
  end

  # POST /purchase_names
  def create
    @purchase_name = PurchaseName.new(purchase_name_params)

    if @purchase_name.save
      render json: @purchase_name, status: :created, location: @purchase_name
    else
      render json: @purchase_name.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /purchase_names/1
  def update
    if @purchase_name.update(purchase_name_params)
      render json: @purchase_name
    else
      render json: @purchase_name.errors, status: :unprocessable_entity
    end
  end

  # DELETE /purchase_names/1
  def destroy
    @purchase_name.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_purchase_name
      @purchase_name = PurchaseName.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def purchase_name_params
      params
        .require(:data)
          .require(:attributes)
            .permit(:text, :user_id)
    end
end

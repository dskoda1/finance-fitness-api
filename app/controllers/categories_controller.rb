class CategoriesController < ApplicationController
  before_action :set_category, only: [:show, :update, :destroy]
  jsonapi { }


  # GET /categories
  def index
    #binding.pry
    #render_ams(CategoryResource.records)
    render json: Category.where(user_id: current_user.id)
  end

  # GET /categories/1
  def show
    category = @category
    if category.user_id.eql?(current_user.id)
      render json: @category, status: 200
    else
      render json: { error: 'Not Authorized' }, status: :unauthorized
    end
  end

  # POST /categories
  def create
    @category = Category.new(category_params)

    if @category.save
      render json: @category, status: :created, location: @category
    else
      render json: @category.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /categories/1
  def update
    if @category.update(category_params)
      render json: @category
    else
      render json: @category.errors, status: :unprocessable_entity
    end
  end

  # DELETE /categories/1
  def destroy
    @category.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_category
      @category = Category.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def category_params
      params.require(:category).permit(:name, :user_id)
    end
end

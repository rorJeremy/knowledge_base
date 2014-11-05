class CategoriesController < ApplicationController
  skip_before_action :verify_authenticity_token

  def index
    # @posts = Post.all
    @categories = Category.all.order("id DESC")
    # @posts.each do |post|
    #   raise post.category
    # end
    respond_to do |format|
      format.json {render :json => @categories}
    end
  end

  def show
    @category = Category.find(params[:id])

    respond_to do |format|
      format.json {render :json => @category}
    end
  end

  def new
    # default: render 'new' template
    @category = Category.new
  end

  def create
    @category = Category.new(category_params)

    respond_to do |format|
      if @category.save
        format.json { render json: @category, status: :created }
        format.xml { render xml: @category, status: :created }
      else
        format.json { render json: @category.errors, status: :unprocessable_entity }
        format.xml { render xml: @category.errors, status: :unprocessable_entity }
      end
    end

  end

  private
    def category_params
      params.required(:category).permit(:id, :name)
    end

end

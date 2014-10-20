class CategoriesController < ApplicationController
  def new
    # default: render 'new' template
    @category = Category.new
  end

  def create
    @category = Category.new(category_params)
    if @category.save
      flash[:notice] = "#{@category.name} was successfully created!"
      redirect_to new_post_path
    else
      flash[:error] = "Category failed to create."
      redirect_to new_post_path
    end
  end

  private
    def category_params
      params.required(:category).permit(:id, :name)
    end

end

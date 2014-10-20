class TagsController < ApplicationController
  def new
    # default: render 'new' template
    @tag = Tag.new
  end

  def create
    @tag = Tag.new(tag_params)
    if @tag.save
      flash[:notice] = "#{@tag.name} was successfully created!"
      redirect_to new_post_path
    else
      flash[:error] = "Tag failed to create."
      redirect_to new_post_path
    end
  end

  private
    def tag_params
      params.required(:tag).permit(:id, :name)
    end
end

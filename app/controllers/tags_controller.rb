class TagsController < ApplicationController
  skip_before_action :verify_authenticity_token

  def index
    # @posts = Post.all
    @tags = Tag.all.order("id DESC")
    # @posts.each do |post|
    #   raise post.category
    # end
    respond_to do |format|
      format.json {render :json => @tags}
    end
  end

  def show
    @tag = Tag.find(params[:id])

    respond_to do |format|
      format.json {render :json => @tag}
    end
  end


  def new
    # default: render 'new' template
    @tag = Tag.new
  end

  def create
    @tag = Tag.new(tag_params)

    respond_to do |format|
      if @tag.save
        format.json { render json: @tag, status: :created }
        format.xml { render xml: @tag, status: :created }
      else
        format.json { render json: @tag.errors, status: :unprocessable_entity }
        format.xml { render xml: @tag.errors, status: :unprocessable_entity }
      end
    end
  end


  private
    def tag_params
      params.required(:tag).permit(:id, :name)
    end
end

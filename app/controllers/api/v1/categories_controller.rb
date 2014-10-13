module Api
  module V1
    class CategoriesController < ApplicationController
      skip_before_filter :verify_authenticity_token
      respond_to :json

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


        # @post["tags"] = 3
        # @post.tags.each do |tag|
        #   @post["tags"] << tag
        # end
        respond_to do |format|
          format.json {render :json => @category}
        end
      end

      def new
        # default: render 'new' template
        respond_with(Category.new)
      end

      def create
        @category = Category.new(category_params)
        if @category.save
          respond_to do |format|
            format.json {render :json => @category}
          end
        end
      end

      private
        def category_params
          params.required(:category).permit(:id, :name)
        end
    end
  end
end


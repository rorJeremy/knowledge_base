module Api
  module V1
    class PostsController < ApplicationController
      skip_before_filter :verify_authenticity_token
      respond_to :json

      def index
        # @posts = Post.all
        @posts = Post.all.order("id DESC")
        # @posts.each do |post|
        #   raise post.category
        # end
        respond_to do |format|
          format.json {render :json => @posts.to_json(:include => {:tags => {:only => :name}, :category => {:only => :name}})}
        end
      end

      def show
        @post = Post.find(params[:id])


        # @post["tags"] = 3
        # @post.tags.each do |tag|
        #   @post["tags"] << tag
        # end
        respond_to do |format|
          format.json {render :json => @post.to_json(:include => {:tags => {:only => :name}})}
        end
      end

      def new
        # default: render 'new' template
        respond_with(Post.new)
      end

      def create
        @post = Post.create!(post_params)
        respond_to do |format|
          format.json {render :json => @post}
        end
      end

      def update
        @post = Post.find(params[:id])
        if @post.update(post_params)
          respond_to do |format|
            format.json {render :json => @post}
          end
        end
      end

      def destroy
        respond_with Post.destroy(params[:id])
      end

      private
        def post_params
          params.required(:post).permit(:title, :body)
        end
    end
  end
end
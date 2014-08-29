module Api
  module V1
    class PostsController < ApplicationController
      skip_before_filter :verify_authenticity_token
      respond_to :json

      def index
        # @posts = Post.all
        respond_with(Post.all.order("id DESC"))
      end

      def show
        respond_with(Post.find(params[:id]))
      end

      def create
        @post = Post.new(post_params)
        if @post.save
          respond_to do |format|
            format.json {render :json => @post}
          end
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
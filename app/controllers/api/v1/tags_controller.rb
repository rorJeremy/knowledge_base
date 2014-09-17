module Api
  module V1
    class TagsController < ApplicationController
      skip_before_filter :verify_authenticity_token
      respond_to :json

      def index
        @tags = Tag.all.order("id DESC")

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
    end
  end
end


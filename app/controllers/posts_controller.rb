require 'json'
require 'net/http'
require 'rubygems'
# require 'nokogiri'
require 'open-uri'

class PostsController < ApplicationController
  include PostsHelper
  skip_before_filter :verify_authenticity_token

  def index
    @response, @show_every_post = posts_from_parameters
    if @show_every_post == false
      @posts = @response.records.map_with_hit do |post, hit|
        highlight = hit.highlight
        if highlight
          # Rails.logger.info "highlight(title: #{highlight.title.inspect}, body: #{highlight.body.inspect})"
          post.title_highlighted = highlight.title[0] if highlight.title
          post.body_highlighted = highlight.body[0] if highlight.body
          post.category_highlighted = highlight.category_name[0] if highlight.category_name
          if highlight.tag_list
            post.tags_highlighted = []
            highlight.tag_list.each do |tag|
              post.tags_highlighted << tag
            end
          end
        end
        post
      end
    else
      @posts = @response
    end

    # Rails.logger.info "post titles " + ('~' * 100)
    # Rails.logger.info @posts.map { |p| p.title_highlighted.to_s }.join("\n")

    respond_to do |format|
      format.html # index.html.erb
      format.json
    end
  end

  def show
    @post = Post.includes(posts_tags: :tag).find(params[:id])

    respond_to do |format|
      format.html # index.html.erb
      format.json
    end
  end

  def new
    # default: render 'new' template
    @post = Post.new
  end

  def create
    # @post = Post.new(params[:post])
    @post = Post.new(post_params)

    respond_to do |format|
      if @post.save
        format.json { render action: "show", status: :created }
        format.xml { render xml: @post, status: :created }
      else
        format.json { render json: @post.errors, status: :unprocessable_entity }
        format.xml { render xml: @post.errors, status: :unprocessable_entity }
      end
    end

  end

  def edit
    @post = Post.find(params[:id])
  end

  def update
    @post = Post.find(params[:id])
    # raise "hello"

    respond_to do |format|
      if @post.update_attributes(post_params)
        format.json { head :no_content, status: :ok }
        format.xml { head :no_content, status: :ok }
      else
        format.json { render json: @post.errors, status: :unprocessable_entity }
        format.xml { render xml: @post.errors, status: :unprocessable_entity }
      end
    end

  end

  def destroy
    @post = Post.find_by_id(params[:id])
    respond_to do |format|
      if @post.destroy
        format.json { head :no_content, status: :ok }
        format.xml { head :no_content, status: :ok }
      else
        format.json { render json: @post.errors, status: :unprocessable_entity }
        format.xml { render xml: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  private

  def fetch_from_url(url)
    response = Net::HTTP.get_response(URI.parse(url))
    data = response.body
    JSON.parse(data)
  end

    def post_params
      params.required(:post).permit(:id, :title, :body, :category_id, :tag_ids => [])
    end
end
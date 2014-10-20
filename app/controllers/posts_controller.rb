require 'json'
require 'net/http'
require 'rubygems'
# require 'nokogiri'
require 'open-uri'

class PostsController < ApplicationController
  skip_before_filter :verify_authenticity_token

  def index
    # @posts = Post.all.order("id DESC")
    # @posts = fetch_from_url("http://localhost:3000/api/v1/posts.json")

    @posts = Post.includes(:tags, :category).all.order("id DESC")
    @posts.each do |post|
      post.title_tags = post.title
      post.tags.each do |tag|
        post.title_tags += ' ' + tag.name
      end
    end

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
    @post = Post.new(post_params)
    if @post.save
      flash[:notice] = "#{@post.title} was successfully created!"
      redirect_to post_path(@post)
    else
      flash[:error] = "Article failed to create."
      redirect_to posts_path
    end
  end

  def edit
    @post = Post.find(params[:id])
  end

  def update
    @post = Post.find(params[:id])
    if @post.update_attributes!(post_params)
      flash[:notice] = "#{@post.title} was successfully updated!"
      redirect_to post_path(@post)
    else
      flash[:error] = "#{@post.title} failed to update."
      redirect_to post_path(@post)
    end
  end

  def destroy
    Post.destroy(params[:id])
    flash[:notice] = "Article was deleted!"
    redirect_to posts_path
  end

  def fetch_from_url(url)
    response = Net::HTTP.get_response(URI.parse(url))
    data = response.body
    JSON.parse(data)
  end

  private
    def post_params
      params.required(:post).permit(:id, :title, :body, :category_id, :tag_ids => [])
    end
end
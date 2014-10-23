module PostsHelper

  def posts_from_parameters
    posts = []
    show_every_post = true
    if params[:q].to_s.length == 0
      posts = Post.includes(:tags, :category).all.order("id DESC")
      show_every_post = true
      return posts, show_every_post
    else
      posts = Post.search params[:q]
      show_every_post = false
      return posts, show_every_post
    end
  end

end

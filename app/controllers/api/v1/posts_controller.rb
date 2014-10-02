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
        @post = Post.includes(posts_tags: :tag).find(params[:id])
      end

      def new
        # default: render 'new' template
        respond_with(Post.new)
      end

      def create
        @post = Post.new(post_params)
        debugger
        if @post.save
          respond_to do |format|
            format.json {render :json => @post}
          end
        end
      end

      def update
        @post = Post.find(params[:id])
        debugger
        respond_to do |format|
          if @post.update(post_params)
            format.json {render :json => @post}
          else
            format.json {render json: {errors: @post.errors}, status: :unprocessable_entity}
          end
        end
      end

      def destroy
        respond_with Post.destroy(params[:id])
      end

      private
        def post_params
          params.required(:post).permit(:title, :body, :category_id,
            posts_tags_attributes: [:id, :_destroy, :tag_id, tag_attributes: [:name]])
        end
    end
  end
end

#edit


# {
#     "id"=>"30",
#     "title"=>"a testttt",
#     "body"=>"testinnn",
#     "created_at"=>"2014-09-29T21:01:49.000Z",
#     "updated_at"=>"2014-09-29T21:01:49.000Z",
#     "category_id"=>4,
#     "tags"=>[
#         {
#             "name"=>"credit card"
#         },
#         {
#             "name"=>"Boom2"
#         },
#         {
#             "id"=>4,
#             "name"=>"field day",
#             "created_at"=>"2014-09-03T19:41:42.000Z",
#             "updated_at"=>"2014-09-03T20:09:58.000Z",
#             "route"=>"tags",
#             "reqParams"=>nil,
#             "fromServer"=>true,
#             "parentResource"=>nil,
#             "restangularCollection"=>false,
#             "tag_id"=>4
#         }
#     ],
#     "format"=>"json",
#     "action"=>"update",
#     "controller"=>"api/v1/posts",
#     "post"=>{
#         "id"=>30,
#         "title"=>"a testttt",
#         "body"=>"testinnn",
#         "created_at"=>"2014-09-29T21:01:49.000Z",
#         "updated_at"=>"2014-09-29T21:01:49.000Z",
#         "category_id"=>4
#     }
# }

# {
#   "title"=>"Why is there a charge to “Safety Courses 18008302268” on my credit card statement?",
#   "body"=>"This is the charge for your course fee. “Safety Courses 18008302268” is what appears on your card statement.",
#   "category_id"=>3
# }

#create

# {
#     "post"=>{
#         "posts_tags_attributes"=>[
#             {
#                 "id"=>9,
#                 "name"=>"Boom2",
#                 "created_at"=>"2014-09-24T23:00:42.000Z",
#                 "updated_at"=>"2014-09-24T23:00:42.000Z",
#                 "route"=>"tags",
#                 "reqParams"=>nil,
#                 "fromServer"=>true,
#                 "parentResource"=>nil,
#                 "restangularCollection"=>false,
#                 "tag_id"=>9
#             }
#         ],
#         "category_id"=>1,
#         "title"=>"test22",
#         "body"=>"test222"
#     },
#     "format"=>"json",
#     "action"=>"create",
#     "controller"=>"api/v1/posts"
# }

# {
#   "title"=>"test",
#   "body"=>"test",
#   "category_id"=>4,
#   "posts_tags_attributes"=>[{"tag_id"=>6}]
# }


# {
#   post: {
#     title: "dhwa",
#     tags_attributes: [
#       { id: 1, name: "Whatever" },
#       { id: 1, name: "Whatever" },
#     ]
#   }
# }

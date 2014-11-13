json.array! @posts.each do |post|
  json.extract! post, :id, :title, :body, :category_id, :created_at, :updated_at, :title_highlighted, :body_highlighted, :category_highlighted, :tags_highlighted
  json.tags post.tags, :id, :name
  json.category post.category.name
end

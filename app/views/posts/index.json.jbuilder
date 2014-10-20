json.array! @posts.each do |post|
  json.extract! post, :id, :title, :body, :category_id, :created_at, :updated_at, :title_tags
  json.tags post.tags, :id, :name
  json.category post.category.name
end

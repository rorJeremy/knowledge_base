json.(@post, :id, :title, :body, :category_id)
json.tags @post.posts_tags do |assoc|
  json.association_id assoc.id
  json.id   assoc.tag.id
  json.name assoc.tag.name
end
json.category @post.category.name

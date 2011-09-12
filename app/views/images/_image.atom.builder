if !post.title.blank?
  entry.title(post.title, :type => 'html')
else
  entry.title(post.created_at, :type => 'html')
end

entry.content(
  image_tag(post_image_path(post, post.image.name), :alt => post.title),
  :type => 'html'
)

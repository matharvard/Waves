if !post.title.blank?
  entry.title(post.title, :type => 'html')
else
  entry.title(post.created_at, :type => 'html')
end

entry.content(post.body)

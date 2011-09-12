if !post.title.blank?
  entry.title(post.title, :type => 'html')
else
  entry.title(post.created_at)
end

entry.content(post.code, :type => 'html')

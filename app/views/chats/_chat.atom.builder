if !post.source.blank?
  entry.title(post.source, :type => 'html')
else
  entry.title(post.created_at, :type => 'html')
end

entry.content(post.body)

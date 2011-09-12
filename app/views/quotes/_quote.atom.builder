if !post.source.blank?
  entry.title(post.source, :type => 'html')
else
  entry.title(post.url, :type => 'html')
end

entry.content(post.body, :type => 'html')

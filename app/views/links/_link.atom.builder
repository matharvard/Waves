if !post.name.blank?
  entry.title(post.url, :type => 'html')
else
  entry.title(post.name, :type => 'html')
end

entry.content(post.description, :type => 'html')

atom_feed do |feed|
  feed.title "Waves"
  feed.updated_at @posts.first.created_at
  
  for post in @posts
    feed.entry(post, :url => post_url(post.id)) do |entry|
      atom_template_for(entry, post)
      
      entry.author do |author|
        author.name "Waves"
      end
    end
  end
end

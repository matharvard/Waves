atom_feed do |feed|
  feed.title "Mat Harvard"
  feed.updated_at @posts.first.created_at
  
  for post in @posts
    feed.entry(post, :url => post_url(post.id)) do |entry|
      atom_template_for(entry, post)
      
      entry.author do |author|
        author.name "MH"
      end
    end
  end
end

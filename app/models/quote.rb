class Quote < Post

  key :body, String
  key :source, String
  key :url, String

  validates_presence_of :body, :source

end

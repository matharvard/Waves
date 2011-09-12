class Article < Post

  key :title, String
  key :body, String

  validates_presence_of :body

end

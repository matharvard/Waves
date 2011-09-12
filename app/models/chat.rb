class Chat < Post

  key :body, String
  key :source, String

  validates_presence_of :body

end

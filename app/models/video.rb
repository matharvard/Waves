class Video < Post

  key :embed_code, String
  key :description, String

  validates_presence_of :embed_code

end

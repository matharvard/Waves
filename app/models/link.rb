class Link < Post

  key :url, String
  key :name, String
  key :description, String

  validates_presence_of :url

end

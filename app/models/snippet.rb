class Snippet < Post

  key :title, String
  key :code, String

  validates_presence_of :code

end

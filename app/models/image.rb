class Image < Post

  include MongoMapper::Document
  plugin Joint # NOTE: Next version of Joint should fix deprecation warnings

  attachment :image

  key :title, String
  key :description, String
  key :url, String

  validates_presence_of :image, :message => "must be present."

end

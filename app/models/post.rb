class Post

  include MongoMapper::Document

  timestamps!

  scope :recent, :order => "created_at DESC", :limit => 7

  def type
    self.class.to_s.downcase
  end

end

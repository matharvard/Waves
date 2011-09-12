require 'digest/sha1'

class User

  include MongoMapper::Document

  key :email, String
  key :encrypted_password, String, :limit => 128
  key :salt, String, :limit => 128
  key :remember_token, String, :limit => 128

  timestamps!

  attr_accessor :password, :password_confirmation

  validates_presence_of :email
  validates_uniqueness_of :email, :case_sensitive => false, :allow_blank => true
  validates_format_of :email, :with => %r{^[a-z0-9!#\$%&'*+\/=?^_`{|}~-]+(?:\.[a-z0-9!#\$%&'*+\/=?^_`{|}~-]+)*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?$}i, :allow_blank => true

  validates_presence_of :password, :if => !:password_optional?
  validates_confirmation_of :password

  before_save :initialize_salt, :encrypt_password
  before_create :generate_remember_token

  class << self
    
    def authenticate(email, password)
      return nil unless user = find_by_email(email)
      return user if user.authenticated?(password)
    end
    
  end

  def authenticated?(password)
    encrypted_password == encrypt(password)
  end

  def reset_remember_token!
    generate_remember_token
    save(:validate => false)
  end

  def update_password(new_password, new_password_confirmation)
    self.password = new_password
    self.password_confirmation = new_password_confirmation
    if valid?
      generate_remember_token
    end
    save
  end

protected

  def generate_hash(string)
    Digest::SHA1.hexdigest(string)
  end

  def encrypt(string)
    generate_hash("--#{salt}--#{string}--")
  end

  def initialize_salt
    if salt.blank?
      self.salt = generate_hash("--#{Time.now.utc}--#{password}--#{rand}--")
    end
  end

  def encrypt_password
    if password.present?
      self.encrypted_password = encrypt(password)
    end
  end

  def generate_remember_token
    self.remember_token = encrypt("--#{Time.now.utc}--#{encrypted_password}--#{id}--#{rand}--")
  end

  def password_optional?
    encrypted_password.present? && password.blank?
  end

end

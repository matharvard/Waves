# Connect to MongoDB
MongoMapper.connection = Mongo::Connection.new('localhost', 27017)
MongoMapper.database = "#waves-#{Rails.env}"

# Am I running Phusion Passenger?
if defined?(PhusionPassenger)
  PhusionPassenger.on_event(:starting_worker_process) do |forked|
    MongoMapper.connection.connect if forked
  end
end

# Create indexes
User.ensure_index(:email)
User.ensure_index(:remember_token)

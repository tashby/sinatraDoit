require 'sinatra'
require 'slim'
require 'data_mapper'

DataMapper.setup(:default, ENV['DATABASE_URL'] || "sqlite3://#{Dir.pwd}/development.db")
class task
  include DataMapper::Resource
  property :id, Serial
  property :name, String, :require => true
  property :completed_at, DateTime
end
DataMapper.finalize

get '/' do
  slim :index
end

get '/:task' do
  @task = params[:task].split('-').join(' ').capitalize
  slim :task
end

post '/' do
  @task = params[:task]
  slim :task
end

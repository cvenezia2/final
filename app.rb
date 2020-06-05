# Set up for the application and database. DO NOT CHANGE. #############################
require "sinatra"                                                                     #
require "sinatra/reloader" if development?                                            #
require "sequel"                                                                      #
require "logger"                                                                      #
require "twilio-ruby"                                                                 #
require "geocoder"                                                                    #
require "bcrypt"                                                                      #
connection_string = ENV['DATABASE_URL'] || "sqlite://#{Dir.pwd}/development.sqlite3"  #
DB ||= Sequel.connect(connection_string)                                              #
DB.loggers << Logger.new($stdout) unless DB.loggers.size > 0                          #
def view(template); erb template.to_sym; end                                          #
use Rack::Session::Cookie, key: 'rack.session', path: '/', secret: 'secret'           #
before { puts; puts "--------------- NEW REQUEST ---------------"; puts }             #
after { puts; }                                                                       #
#######################################################################################

libraries_table = DB.from(:libraries)
checkouts_table = DB.from(:checkouts)

get "/" do 
    @libraries = libraries_table.all
    puts @libraries.inspect
    view "libraries"
end

get "/libraries/:id" do
    @library = libraries_table.where(:id => params["id"]).to_a[0]
    puts @library.inspect
    view "library"
end

get "/libraries/:id/checkouts/new" do
    @library = libraries_table.where(:id => params['id']).to_a[0]
    view "new_checkout"
end
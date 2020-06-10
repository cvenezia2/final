# Set up for the application and database. DO NOT CHANGE. #############################
require "sequel"                                                                      #
connection_string = ENV['DATABASE_URL'] || "sqlite://#{Dir.pwd}/development.sqlite3"  #
DB = Sequel.connect(connection_string)                                                #
#######################################################################################

# Database schema - this should reflect your domain model
DB.create_table! :libraries do
  primary_key :id
  String :name
  String :description, text: true
  String :location
end
DB.create_table! :reviews do
  primary_key :id
  foreign_key :library_id
  Boolean :review
  String :name
  String :email
  String :booktitle
  String :comments, text: true
end

# Insert initial (seed) data
libraries_table = DB.from(:libraries)

libraries_table.insert(name: "Ocee Library", 
                    description: "Fulton County Library in Johns Creek",
                    location: "5090 Abbotts Bridge Rd")

libraries_table.insert(name: "Spruill Oaks", 
                    description: "Fulton County Library in Alpharetta",
                    location: "9560 Spruill Rd")

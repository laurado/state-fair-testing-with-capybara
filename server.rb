require "sinatra"
require "pry"
require "csv"

set :bind, "0.0.0.0"
set :views, File.join(File.dirname(__FILE__), "views")

get "/" do
  redirect to("/foods")
end

get "/foods" do
  @foods = []
  CSV.foreach(csv_file, headers: true) do |row|
    @foods << row.to_h
  end
  erb :"foods/index"
end

get "/foods/new" do
  erb :"foods/new"
end

post "/foods/new" do
  item = params["item"]
  vendor = params["vendor"]

  @error = nil

  if [item, vendor].include?("")
    @error = "Please fill in all fields"
    erb :"foods/new"
  else
    CSV.open(csv_file, "a", headers: true) do |csv|
      csv << [item, vendor]
    end
    redirect to("/foods")
  end
end

# Helper Methods

def csv_file
  if ENV["RACK_ENV"] == "test"
    "data/food_test.csv"
  else
    "data/food.csv"
  end
end

def reset_csv
  CSV.open(csv_file, "w", headers: true) do |csv|
    csv << ["item", "vendor"]
  end
end

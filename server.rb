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

require 'mongo'
require 'csv'
require 'base64'
require 'json'

all_gems = CSV.read("data_20160617_v1_realistic_output2_random.csv")

client = Mongo::Client.new(ENV['mongodb_uri'], :max_pool_size => 10)
gems = client[:gems]

all_gems.each do |g|
  gems.find({'name' => g[0]}).find_one_and_update("$set" => {"maintenance_score" => g[2]})
  puts g[0], g[2]
end
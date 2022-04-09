require "kemal"
require "uuid"
require "./cruzeiro"

# Generate a globally unique address for this node
NODE_UUID = UUID.random.to_s

# Create our Blockchain
blockchain = Cruzeiro::Blockchain.new

before_all do |env|
  puts "Setting response content type"
  env.response.content_type = "application/json"
end

get "/" do
  {info: "Cruzeiro Cryptocurrency - Node #{NODE_UUID}"}.to_json
end

get "/chain" do
  {chain: blockchain.chain}.to_json
end

get "/mine" do
  blockchain.mine
  {success: "Block with index=#{blockchain.chain.last.index} is mined."}.to_json
end

get "/pending" do
  {transactions: blockchain.uncommitted_transactions}.to_json
end

post "/transactions/new" do |env|
  body = env.request.body.not_nil!
  blockchain << Cruzeiro::Block::Transaction.from_json(body)

  {success: "Transaction #{blockchain.uncommitted_transactions.last} has been added to the node"}.to_json
end

Kemal.run

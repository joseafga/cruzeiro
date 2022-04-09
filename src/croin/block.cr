require "json"
require "./pow"

module Croin
  class Block
    include ProofOfWork
    include JSON::Serializable

    property hash : String
    getter index : UInt64
    getter nonce : UInt32

    # For previous hash use previous index
    @[JSON::Field(ignore: true)]
    property previous_block : Block | Nil

    def initialize(@index : UInt64, @transactions : Array(Transaction), @previous_block = nil)
      @timestamp = Time.utc
      @nonce, @hash = proof_of_work
    end

    # Genesis Block
    def self.first
      Block.new(0, [] of Transaction)
    end

    def self.next(transactions : Array(Transaction), previous_block)
      Block.new(
        index: previous_block.index + 1,
        transactions: transactions,
        previous_block: previous_block
      )
    end
  end
end

require "./pow"

module Croin
  class Block
    include ProofOfWork

    property hash : String
    property previous_block : Block | Nil
    getter index : UInt64
    getter nonce : UInt32

    def initialize(@index : UInt64, @transactions : Array(Transaction), @previous_block = nil)
      @timestamp = Time.utc
      @nonce, @hash = proof_of_work
    end

    def self.first
      Block.new(0, [] of Transaction)
    end

    def self.next(transactions : Array(Transaction), previous_block)
      Block.new(
        index: previous_block.index + 1,
        transactions: transactions,
        previous_hash: previous_block.hash
      )
    end
  end
end

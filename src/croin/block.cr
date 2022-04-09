module Croin
  class Block
    include ProofOfWork

    property hash : String
    property previous_block : Block | Nil
    getter index : UInt64
    getter nonce : UInt32

    def initialize(@index : UInt64, @data : String, @previous_block = nil)
      @data.not_empty!
      @timestamp = Time.utc
      @nonce, @hash = proof_of_work
    end

    def self.first
      Block.new(0, "Neon Genesis Block")
    end

    def self.next(data : String, previous_block)
      data.not_empty!

      Block.new(
        index: previous_block.index + 1,
        data: data,
        previous_hash: previous_block.hash
      )
    end
  end
end

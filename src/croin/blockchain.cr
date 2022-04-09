module Croin
  class Blockchain
    getter chain
    getter uncommitted_transactions

    def initialize
      @chain = [Block.first]
      @uncommitted_transactions = [] of Block::Transaction
    end

    def <<(transaction)
      @uncommitted_transactions << transaction
    end
  end
end

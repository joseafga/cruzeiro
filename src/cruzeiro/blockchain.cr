module Cruzeiro
  class Blockchain
    getter chain
    getter uncommitted_transactions

    BLOCK_SIZE = 25

    def initialize
      @chain = [Block.first]
      @uncommitted_transactions = [] of Block::Transaction
    end

    def <<(transaction)
      @uncommitted_transactions << transaction
    end

    def mine
      raise "No transactions to be mined" if @uncommitted_transactions.empty?

      @chain << Block.next(
        transactions: @uncommitted_transactions.shift(BLOCK_SIZE),
        previous_block: @chain.last
      )
    end
  end
end

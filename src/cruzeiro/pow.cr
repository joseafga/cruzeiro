require "digest/sha256"

module Cruzeiro
  module ProofOfWork
    private def proof_of_work(difficulty = "00")
      nonce = 0_u32

      loop do
        hash = calc_hash(nonce)

        return {nonce, hash} if hash[..1] == difficulty
        nonce += 1
      end
    end

    private def calc_hash(nonce : UInt32 = 0)
      Digest::SHA256.hexdigest("#{nonce}#{@index}#{@timestamp}#{@transactions}#{@previous_block.hash}")
    end
  end
end

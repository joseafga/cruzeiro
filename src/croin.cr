require "digest/sha256"
require "./ext/string"

# TODO: Write documentation for `Croin`
module Croin
  VERSION = "0.1.0"

  class Block
    property hash : String = ""
    getter index
    getter previous_hash

    def initialize(@index : Int64, @data : String, @previous_hash : String)
      @data.not_empty!
      @timestamp = Time.utc
      @hash = calc_hash
    end

    def self.first
      Block.new(0, "Neon Genesis Block", "0")
    end

    def self.next(data : String, previous_block)
      data.not_empty!

      Block.new(
        index: previous_block.index + 1,
        data: data,
        previous_hash: previous_block.hash
      )
    end

    private def calc_hash
      Digest::SHA256.hexdigest("#{@index}#{@timestamp}#{@data}#{@previous_hash}")
    end
  end
end

require "digest"

module Cracker::Hash
	class Hash
		def initialize(@is_hash : Bool, @input : String, @table_path : String, @method : String)
		end

		def crack
			if !@is_hash
				digest = self.get_digest
				digest << @input
				@input = digest.final.to_s
			end

			# TODO Support for different table formats (password, password:hash)
			# For now assume format of 1 password per line with no hash
			File.each_line(@table_path) do |line|
				digest = self.get_digest
				digest << line
				line_hash = digest.final.to_s
					
				if line_hash == @input
					return "Found password: #{line}"
				end
			end
		end

		private def get_digest 
			case @method
			when "MD5" then return Digest::MD5.new
			when "SHA1" then return Digest::SHA1.new
			when "SHA256" then return Digest::SHA256.new
			when "SHA512" then return Digest::SHA512.new
			else return Digest::MD5.new
			end
		end
	end

end

asd = Cracker::Hash::Hash.new(false, "asd", "asd", "asd")
asd.crack

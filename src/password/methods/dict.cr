require "file"
require "./cracking_method.cr"

module Cracker::Methods
	class Dict < CrackingMethod
		def initialize(@length : Int16, @dict_path : String)
		end
		
		def crack : Array(String)
			if !File.exists?(@dict_path)
				return [] of String
			end

			# TODO yields, lazy loading
			File.read_lines(@dict_path)
		end
	end
end

module Cracker::Methods
	abstract class CrackingMethod
		def initialize(@length : Int16)
		end

		abstract def crack : Array(String)
	end
end

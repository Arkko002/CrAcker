require "../methods/cracking_method.cr"

module Cracker::Target
	abstract class CrackingTarget
		def initalize(@method : CrackingMethod)
		end

		abstract def start_cracking
	end
end

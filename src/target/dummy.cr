require "./cracking_target.cr"
require "../methods/cracking_method.cr"

module Cracket::Target
	# Outputs all the results directly to console
	# For testing purpose only
	class Dummy < Cracker::Target::CrackingTarget
		def initialize(@method : CrackingMethod)
		end

		def start_cracking
			passwords = @method.crack

			passwords.each do |password|
				p password
			end
		end
	end
end

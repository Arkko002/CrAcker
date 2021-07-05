require "./cracking_target.cr"
require "../methods/**"

module Cracker::Target
	# Outputs all the results directly to console
	# For testing purpose only
	class Dummy < Cracker::Target::CrackingTarget
		def initialize(@method : Cracker::Methods::CrackingMethod)
		end

		def start_cracking
			passwords = @method.crack

			pass = "asd12"


			passwords.each do |password|
				p password
				if pass == password
					p "Found pass: #{password}"
					return
				end
			end
		end
	end
end

method = Cracker::Methods::Brute.new(5, false, true, false, true)
dummy = Cracker::Target::Dummy.new method
dummy.start_cracking

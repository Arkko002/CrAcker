require "./brute_helpers.cr"
require "./cracking_method.cr"

module Cracker::Methods
	class Brute < CrackingMethod
		def initialize(@length : Int16, @upper : Bool, @lower : Bool, @symbols : Bool, @numbers : Bool)
		end

		def crack : Array(String)
			password_source = ""
			if @lower
				password_source += BruteHelpers.lowercase_letters
			end

			if @upper
				password_source += BruteHelpers.uppercase_letters
			end

			if @numbers
				password_source += BruteHelpers.numbers
			end

			if @symbols
				password_source += BruteHelpers.symbols
			end

			current_length = 1
			possible_passwords = Array(Array(Char)).new
			while current_length <= @length
				possible_passwords = possible_passwords + password_source.chars.permutations(current_length)
				current_length += 1
			end

			passwords = [] of String

			# TODO better char array to str
			possible_passwords.each do |password_chars|
				password = ""
				password_chars.each do |char|
					password += char
				end

				# TODO yield block instead, problem with inheritence
				passwords << password
			end

			passwords
		end
	end
end

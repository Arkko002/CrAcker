require "commander"
require "socket"
require "./methods/**"
require "./target/**"

module Cracker::CLI
	extend self

	def config
		cli = Commander::Command.new do |cmd|
			cmd.use = "crack"
			cmd.long = "crack a password or hash"
			
			cmd.commands.add do |cmd|
				cmd.use = "password"
				cmd.long = "crack the password on provided service"

				cmd.flags.add do |flag|
					flag.name = "method"
					flag.short = "-m"
					flag.long = "--method"
					flag.default = "b"
					flag.description = "method used to crack the password: (b)rute, (d)ictionary"
				end

				cmd.run do |options, arguments|
					case options.string["method"]
					when "b" then @@method = Cracker::Methods::Brute.new 6
					when "d" then @@method = Cracker::Methods::Dict.new 6, "dict.txt"
					else
						p "Provided cracking methods is incorrect"
						next
					end
				end

				cmd.commands.add do |cmd|
					cmd.use = "ssh"
					cmd.short = "crack ssh service password"
					cmd.long = cmd.short

					cmd.flags.add do |flag|
						flag.name = "username"
						flag.short = "-u"
						flag.long = "--user"
						flag.default = ""
						flag.description = "name of the user"
					end

					cmd.flags.add do |flag|
						flag.name = "address"
						flag.short = "-i"
						flag.long = "--ip"
						flag.default = ""
						flag.description = "IP address of the host"
					end

					cmd.flags.add do |flag|
						flag.name = "port"
						flag.short = "-p"
						flag.long = "--port"
						flag.default = 22
						flag.description = "port of the ssh service"
					end

					cmd.run do |options, arguments|	
						address = Socket::IPAddress.new(options.string["address"], options.int["port"].as(Int32))
						target = Cracker::Target::SSH.new(address, options.string["username"], @@method.as(Cracker::Methods::CrackingMethod))

						result = target.start_cracking
						if result.nil?
							p "No password found"
						else
							p "The password is #{result}"
						end
					end
				end
			end

			cmd.commands.add do |cmd|
				# TODO Add password => hash => rainbow cracking
				cmd.use = "hash"
				cmd.long = "crack the provided hash"

				cmd.flags.add do |flag|
					flag.name = "input"
					flag.short = "-i"
					flag.long = "--input"
					flag.default = ""
					flag.description = "hash to be cracked or a file containing it"
				end

				cmd.flags.add do |flag|
					flag.name = "table"
					flag.short = "-t"
					flag.long = "--table"
					flag.default = ""
					flag.description = "rainbow table to use"
				end
				
				cmd.run do |options, arguments|
					# TODO Validate options and arguments
					# TODO Run method
				end
			end
		end
	end

	def run(argv)
		Commander.run(config, argv)
	end
end

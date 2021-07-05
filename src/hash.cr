
require "commander"

module Cracker::CLI
	extend self

	def config
		cli = Commander::Command.new do |cmd|
			cmd.use = "hash"
			cmd.long = "crack the provided hash"

			cmd.flags.add do |flag|
				flag.name = "hash"
				flag.short = "-h"
				flag.long = "--hash"
				flag.default = true
				flag.description = "input is already digested"
			end

			cmd.flags.add do |flag|
				flag.name = "method"
				flag.short = "-m"
				flag.long = "--method"
				flag.default = "SHA1"
				flag.description = "hash algorithm to be used for cleartext inputs (SHA1, SHA256, SHA512, MD5)"
			end

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

	def run(argv)
		Commander.run(config, argv)
	end
end

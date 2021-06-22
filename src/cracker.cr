require "socket"
require "./ssh.cr"

# TODO: Write documentation for `Cracker`
module Cracker
  VERSION = "0.1.0"

  class PasswordCracker
	  def initialize(@length : Int16, lower_case? : Bool, upper_case? : Bool, numbers? : Bool, symbols? : Bool)
	  end

	  def brute_ssh(address : String, port : Int16, username : String)
		  ip_adr = Socket::IPAddress.new address, port
		  ssh_cracker = Cracker::SSH.SSHCracker.new ip_adr, username
		  result = ssh_cracker.brute @length, @lower_case, @upper_case, @numbers, @symbols

		  if result.is_nil?
	  end

	  def dictionary_ssh(address : String, port : Int16, username : String, dict_path : String)
	  end
  end

  class HashCracker
	  def rainbow(hash, rainbow_table_path)
	  end
  end

end

Cracker::PasswordCracker.new.brute_ssh("123", 123)

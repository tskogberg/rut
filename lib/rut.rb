require 'snmp'
require 'rut/version'

module Rut
  class App
    include Methadone::Main
    include Methadone::CLILogging

    attr_accessor :router_ip

    main do |router_ip|
      unless router_ip =~ /\b(?:\d{1,3}\.){3}\d{1,3}\b/
        raise "#{router_ip} is not an IP-address"
      end

      @router_ip = router_ip

      SNMP::Manager.open(
        host: @router_ip, retries: 0,
        mib_modules: ["DISMAN-EVENT-MIB", "SNMPv2-MIB"]
      ) do |manager|
        run_and_handle_exceptions do
          response = manager.get_value(["sysUpTimeInstance" , "sysName.0"])
          days = response[0]
          router_name = response[1].capitalize
          puts "#{router_name} has been up #{days}"
        end
      end
    end

    # supplemental methods here
    def self.run_and_handle_exceptions
      yield

      rescue SNMP::RequestTimeout
        exception_output("Host #{@router_ip} not responding", 1)
      rescue SocketError
        exception_output("#{@router_ip} is an invalid ip address", 2)
      rescue Exception
        exception_output($!.inspect, 99)
    end

    def self.exception_output(output, code)
      puts output
      exit(code)
    end

    # Declare command-line interface here
    description "Shows uptime on your router"

    # Require an argument
    arg :router_ip, "IP-address to the router"

    version Rut::VERSION
    use_log_level_option

    go!
  end
end

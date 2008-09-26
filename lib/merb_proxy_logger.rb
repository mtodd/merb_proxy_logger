raise LoadError.new("Missing dependency Merb::Plugins") unless defined?(Merb::Plugins)

$:.unshift(File.expand_path(File.dirname(__FILE__)))

class MerbProxyLogger
  
  VERSION = [0,1,0]
  
  attr_accessor :logger
  
  def initialize(*args)
    @logger = self.class.initializer.call(self.class.logger, args)
  end
  
  def method_missing(name, *args)
    self.logger.send(name, *args)
  end
  
  class << self
    attr_accessor :logger, :initializer
    
    # Sets the logger. Requires a logger class and a block which accepts the
    # same class and an array of options:
    # * file
    # * level
    # * delimiter
    # * auto_flush
    # 
    # Examples
    # 
    #   MerbProxyLogger.setup Logger do |logger, (file, level, delimiter, auto_flush)|
    #     logger.new(file, level, delimiter, auto_flush)
    #   end
    # 
    # The logger must respond to certain methods that Merb's libraries expect:
    # * debug, debug!
    # * info, info!
    # * warn, warn!
    # * error, error!
    # * fatal, fatal!
    # * <<, push
    # * flush
    # 
    # For a reference what these methods do, check out the original
    # Merb::Logger:
    # http://github.com/wycats/merb-core/tree/master/lib/merb-core/logger.rb
    # 
    # Logger, for example, needs the bang versions aliased to the non-bang ones
    # and flush can be defined to return nothing. +push+ and +<<+ need to call
    # +info+ (or otherwise). This is done for the Logger class in
    # lib/merb_proxy_logger/loggers/logger.rb.
    # 
    def setup(logger, &initializer)
      self.logger = logger
      self.initializer = initializer
    end
  end
  
  # Autoloaded modules
  autoload :Loggers, 'merb_proxy_logger/loggers'
  autoload :Kernel, 'merb_proxy_logger/kernel'
  
end

# Sets the Proxy's logger to the default Merb::Logger
MerbProxyLogger.setup Merb.send(:remove_const, :Logger) do |logger, (file, level, delimiter, auto_flush)|
  # Merb::Logger.new(Merb.file, Merb::Config[:level], Merb::Config[:delimiter], Merb::Config[:auto_flush])
  logger.new(file, level, delimiter, auto_flush)
end

# Sets the Merb::Logger to the LoggerProxy
Merb::Logger = MerbProxyLogger

# Include MerbProxyLogger's extensions
Kernel.send(:include, MerbProxyLogger::Kernel)
MerbProxyLogger::Loggers.load(:Logger)

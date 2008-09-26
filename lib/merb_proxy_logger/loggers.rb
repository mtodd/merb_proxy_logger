module MerbProxyLogger
  
  # = Loggers
  # 
  # Autoload loggers with modifications to meet the specifications (described
  # in MerbProxyLogger class docs).
  # 
  module Loggers
    
    class << self
      
      # Simply queries for the autoloaded class to get it to load.
      # 
      def load(klass)
        MerbProxyLogger::Loggers.const_get(klass)
      end
      
    end
    
    autoload :Logger, 'lib/merb_proxy_logger/loggers/logger'
    
  end
  
end

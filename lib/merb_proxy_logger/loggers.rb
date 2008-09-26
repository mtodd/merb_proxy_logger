module MerbProxyLogger
  
  # = Loggers
  # 
  # Autoload loggers with modifications to meet the specifications (described
  # in MerbProxyLogger class docs).
  # 
  module Loggers
    
    autoload :Logger, 'lib/merb_proxy_logger/loggers/logger'
    
  end
  
end

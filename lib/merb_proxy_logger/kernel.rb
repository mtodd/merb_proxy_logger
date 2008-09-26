module Kernel
  
  # An alias for the MerbProxyLogger class method +setup+.
  # 
  def use_logger(logger, &initializer)
    MerbProxyLogger.setup(logger, &initializer)
  end
  
end

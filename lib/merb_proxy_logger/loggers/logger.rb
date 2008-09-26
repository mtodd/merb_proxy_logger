require 'logger'

class Logger
  
  def flush(*args)
    return
  end
  
  def <<(string = nil)
    self.info(string)
  end
  alias :push :<<
  
  %w(debug info warn error fatal).each do |level|
    eval <<-"end;"
      def #{level}!(*args)
        send(:#{level}, *args)
      end
    end;
  end
  
end

MerbProxyLogger::Loggers::Logger = Logger

Gem::Specification.new do |s|
  s.name     = "merb_proxy_logger"
  s.version  = "0.1.0"
  s.date     = "2008-09-25"
  s.summary  = "ProxyLogger Merb Plugin"
  s.email    = "mtodd@highgroove.com"
  s.homepage = "http://github.com/mtodd/merb_proxy_logger"
  s.description = "Injects a proxy allowing the use of custom logging libraries and settings."
  s.has_rdoc = true
  s.authors  = ["Matt Todd"]
  s.files    = [
    "README.textile",
    "Rakefile",
    "merb_proxy_logger.gemspec",
    "lib/merb_proxy_logger/kernel.rb",
    "lib/merb_proxy_logger/loggers/logger.rb",
    "lib/merb_proxy_logger/loggers.rb",
    "lib/merb_proxy_logger.rb"
  ]
  s.rdoc_options = ["--main", "README"]
  s.add_dependency("merb-core", [">= 0.9.7"])
end

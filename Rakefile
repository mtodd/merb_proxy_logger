require 'rubygems'
require 'rake'
require 'rake/packagetask'
require 'rake/gempackagetask'
require 'rake/rdoctask'
require 'spec/rake/spectask'
require 'fileutils'
include FileUtils

Spec::Rake::SpecTask.new do |t|
  t.spec_opts = ["--color"]
  t.spec_files = FileList['spec/**/*_spec.rb']
end

require 'rubygems/specification'
spec_def = File.read('merb_proxy_logger.gemspec')
spec = nil
Thread.new { spec = eval("$SAFE = 3\n#{spec_def}") }.join

Rake::GemPackageTask.new(spec) do |p|
  p.need_zip = true
  p.need_tar = true
end

desc "Package and Install"
task :install do
  name = "#{spec.name}-#{spec.version.to_s}.gem"
  sh %{rake package}
  sh %{sudo gem install pkg/#{name}}
end

desc "Uninstall the gem"
task :uninstall => [:clean] do
  sh %{sudo gem uninstall #{spec.name}}
end

desc "Generate RDoc documentation"
Rake::RDocTask.new(:rdoc) do |rdoc|
  rdoc.options << '--line-numbers' << '--inline-source' <<
    # '--main' << 'README' <<
    '--title' << 'RDocs' <<
    '--charset' << 'utf-8'
  rdoc.rdoc_dir = "doc"
  # rdoc.rdoc_files.include 'README'
  rdoc.rdoc_files.include("lib/#{spec.name}.rb")
end

task :default => Rake::Task['spec']

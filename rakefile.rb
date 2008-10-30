# Ruby Css Library lets you handle CSS the easy way.
# Copyright (C) 2008 Johannes Jörg Schmidt, TF
#
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program.  If not, see <http://www.gnu.org/licenses/>.

require 'rake'
require 'rake/testtask'
require 'rake/rdoctask'
require 'rake/gempackagetask'

require 'lib/css'

desc 'Default: run unit tests.'
task :default => :test

desc 'Run the unit tests.'
Rake::TestTask.new do |t|
  t.libs << 'lib'
  t.pattern = 'test/**/*_test.rb'
  t.verbose = false
end

desc 'Generate documentation.'
Rake::RDocTask.new do |rdoc|
  rdoc.rdoc_dir = 'doc'
  rdoc.title    = 'Ruby CSS Library'
  rdoc.options << '--all' << '--inline-source' << '--line-numbers'
  rdoc.options << '--charset' << 'utf-8'
  rdoc.rdoc_files.include('README')
  rdoc.rdoc_files.include('CHANGELOG')
  rdoc.rdoc_files.include('LICENSE')
  rdoc.rdoc_files.include(File.basename(__FILE__))
  rdoc.rdoc_files.include('lib/**/*.rb')
end

spec = Gem::Specification.new do |s| 
  s.name = 'tfcss'
  s.version = '0.1.0'
  s.author = 'Johannes Jörg Schmidt, TF'
  s.homepage = 'http://die-tf.de'
  s.platform = Gem::Platform::RUBY
  s.summary = 'A Ruby library to deal with CSS.'
  s.files = FileList['lib/*.rb', 'lib/**/*.rb', 'test/**/*'].to_a
  s.test_files = Dir.glob('test/test_*.rb') 
  s.has_rdoc = true
  s.extra_rdoc_files = ['README', 'CHANGELOG', 'LICENSE']
  s.rdoc_options << '--all' << '--inline-source' << '--line-numbers'
end

desc 'Build the Ruby CSS Parser gem.'
Rake::GemPackageTask.new(spec) do |pkg| 
  pkg.need_zip = true
  pkg.need_tar = true 
end 



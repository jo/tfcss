$LOAD_PATH.unshift(File.expand_path(File.dirname(__FILE__), '../'))
$LOAD_PATH.unshift(File.expand_path(File.dirname(__FILE__), '../lib/'))
require 'test/unit'
require File.join(File.dirname(__FILE__), '../', 'lib', 'css')
include Css

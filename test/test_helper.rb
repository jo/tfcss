$LOAD_PATH.unshift(File.expand_path(File.dirname(__FILE__), '../'))
$LOAD_PATH.unshift(File.expand_path(File.dirname(__FILE__), '../lib/'))
require 'test/unit'
require 'lib/css'
include Css

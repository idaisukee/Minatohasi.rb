require 'bundler/setup'
Bundler.require
base_dir = File.expand_path(File.join(File.dirname(__FILE__), ".."))
lib_dir  = File.join(base_dir, "lib")
test_dir = File.join(base_dir, "test")

require(File.join(lib_dir, 'Minatohasi.rb'))
class SampleTest < Test::Unit::TestCase
  def test_sample1
		assert_equal(Minatohasi::serial(0, 0), 0)
  end
end

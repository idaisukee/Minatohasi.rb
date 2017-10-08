require 'bundler/setup'
require 'date'
Bundler.require
base_dir = File.expand_path(File.join(File.dirname(__FILE__), ".."))
lib_dir  = File.join(base_dir, "lib")
test_dir = File.join(base_dir, "test")

require(File.join(lib_dir, 'Minatohasi.rb'))
class SampleTest < Test::Unit::TestCase
  def test_serial
		assert_equal(Minatohasi::serial(0, 0), 0)
		assert_equal(Minatohasi::serial(0, 1), 1)
		assert_equal(Minatohasi::serial(1, 0), 365)
  end

	def test_from_ordinal
		epoch = Minatohasi::EPOCH
		assert_equal(Minatohasi::from_ordinal(epoch.year, epoch.yday), 0)
		(-365...365).each do |i|
			assert_equal(Minatohasi::from_ordinal(epoch.year, epoch.yday + i), i)
		end
		assert_equal(Minatohasi::from_ordinal(epoch.year + 1, epoch.yday), 365)
		assert_equal(Minatohasi::from_ordinal(epoch.year + 2, epoch.yday), 365 * 2)
		assert_equal(Minatohasi::from_ordinal(epoch.year + 3, epoch.yday), 365 * 3)
		assert_equal(Minatohasi::from_ordinal(epoch.year + 4, epoch.yday), 365 * 3 + 366)
	end

	def test_from_date_time
		epoch = Minatohasi::EPOCH
		assert_equal(Minatohasi::from_date_time(epoch), 0)
		assert_equal(Minatohasi::from_date_time(epoch - 1), -1)
		assert_equal(Minatohasi::from_date_time(epoch - 100), -100)
		assert_equal(Minatohasi::from_date_time(epoch - 200), -200)
		assert_equal(Minatohasi::from_date_time(epoch - 250), -250)
		assert_equal(Minatohasi::from_date_time(epoch - 260), -260)
		assert_equal(Minatohasi::from_date_time(epoch - 265), -265)
		assert_equal(Minatohasi::from_date_time(epoch - 266), -266)
		assert_equal(Minatohasi::from_date_time(epoch - 270), -270)
		assert_equal(Minatohasi::from_date_time(epoch - 290), -290)
		assert_equal(Minatohasi::from_date_time(epoch - 299), -299)
		assert_equal(Minatohasi::from_date_time(epoch - 300), -300)
		assert_equal(Minatohasi::from_date_time(epoch - 364), -364)
		assert_equal(Minatohasi::from_date_time(epoch - 365), -365)
				assert_equal(Minatohasi::from_date_time(epoch - 100_000), -100_000)
		(-10_0..10_000).each do |i|
			assert_equal(Minatohasi::from_date_time(epoch + i), i)
		end
	end
end

require 'bundler/setup'
require 'date'
Bundler.require
base_dir = File.expand_path(File.join(File.dirname(__FILE__), ".."))
lib_dir  = File.join(base_dir, "lib")
test_dir = File.join(base_dir, "test")

require(File.join(lib_dir, 'Minatohasi.rb'))
class SampleTest < Test::Unit::TestCase

	def test_italy
		assert_equal(DateTime::jd(DateTime::ITALY), DateTime.new(1582, 10, 15))
	end
	
	def test_isimatu
		assert_equal(Minatohasi::isimatu(0, 0, 0), 0)
		assert_equal(Minatohasi::isimatu(12, 0, 0), Rational(12, 24))
		assert_equal(Minatohasi::isimatu(12, 30, 0), Rational(12, 24) + Rational(30, 24 * 60))
	end

	def test_tomowekaha
		assert_equal(Minatohasi::tomowekaha(0, 0), 0)
		assert_equal(Minatohasi::tomowekaha(0, 1), 1)
		assert_equal(Minatohasi::tomowekaha(0, 1.5), 1.5)
		assert_equal(Minatohasi::tomowekaha(0, 365), 365)
		assert_equal(Minatohasi::tomowekaha(0, -1), -1)
		assert_equal(Minatohasi::tomowekaha(0, -267), -267)
		assert_equal(Minatohasi::tomowekaha(0, -268), -268)
		assert_equal(Minatohasi::tomowekaha(0, -365), -365)
		assert_equal(Minatohasi::tomowekaha(0, -100_000), -100_000)
		assert_equal(Minatohasi::tomowekaha(-1, 0), -366)
		assert_equal(Minatohasi::tomowekaha(-1, 1), -365)
		assert_equal(Minatohasi::tomowekaha(-1, 366), 0)
		assert_equal(Minatohasi::tomowekaha(-4, 0), - Minatohasi::Y4D)
		assert_equal(Minatohasi::tomowekaha(-5, 0), - Minatohasi::Y4D - Minatohasi::Y1D - 1)
		assert_equal(Minatohasi::tomowekaha(1, 0), 365)
		assert_equal(Minatohasi::tomowekaha(2, 0), 365 * 2)
		assert_equal(Minatohasi::tomowekaha(2, 0), 365 * 2)
		assert_equal(Minatohasi::tomowekaha(3, 0), 365 * 3)
		assert_equal(Minatohasi::tomowekaha(4, 0), Minatohasi::Y4D)
		assert_equal(Minatohasi::tomowekaha(100, 0), Minatohasi::Y100D)
	end

	def test_rd
		assert_equal(Minatohasi::rd(2018 -1, 1 - 1, 0, 0, 0).to_f, 82280)
		assert_equal(Minatohasi::rd(2017 - 1, DateTime.new(2017, 3, 27).yday - 1, 0, 0, 0).to_f, 82000)
		assert_equal(Minatohasi::rd(2018 - 1, DateTime.new(2018, 4, 28).yday - 1, 0, 0, 0).to_f, 82397)
		assert_equal(Minatohasi::rd(2018 - 1, DateTime.new(2018, 4, 28).yday - 1, 12, 0, 0).to_f, 82397.5)
		assert_equal(Minatohasi::rd(1792 - 1, DateTime.new(1792, 9, 22).yday - 1, 0, 0, 0).to_f, 0)
		assert_equal(Minatohasi::rd(1792 - 1, DateTime.new(1792, 9, 22).yday - 1, 12, 0, 0).to_f, 0.5)
		assert_equal(Minatohasi::rd(1792 - 1, DateTime.new(1792, 9, 22).yday - 1, 18, 0, 0).to_f, 0.75)
		assert_equal(Minatohasi::rd(1792 - 1, DateTime.new(1792, 9, 23).yday - 1, 0, 0, 0).to_f, 1)
		assert_equal(Minatohasi::rd(1792 - 1, DateTime.new(1792, 9, 23).yday - 1, 12, 0, 0).to_f, 1.5)
		assert_equal(Minatohasi::rd(1793 - 1, DateTime.new(1793, 9, 22).yday - 1, 0, 0, 0).to_f, 365)
		assert_equal(Minatohasi::rd(1792 - 1, DateTime.new(1792, 9, 21).yday - 1, 0, 0, 0).to_f, -1)
		assert_equal(Minatohasi::rd(1791 - 1, DateTime.new(1791, 9, 22).yday - 1, 0, 0, 0).to_f, -366)
	end

	def test_rd_ymd
		assert_equal(Minatohasi::rd_ymd(2018 -1, 1 - 1, 1 - 1, 0, 0, 0).to_f, 82280)
		
	end
end

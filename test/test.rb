require 'bundler/setup'
require 'date'
Bundler.require
base_dir = File.expand_path(File.join(File.dirname(__FILE__), ".."))
lib_dir  = File.join(base_dir, "lib")
test_dir = File.join(base_dir, "test")

require(File.join(lib_dir, 'Minatohasi.rb'))
class SampleTest < Test::Unit::TestCase

	def test_isimatu
		assert_equal(Minatohasi::isimatu(0, 0, 0, Minatohasi::PT), 0)
		assert_equal(Minatohasi::isimatu(0, 0, 0, 0), Minatohasi::PT)
		assert_equal(Minatohasi::isimatu(0, 0, 0, Minatohasi::JST), Minatohasi::PT - Minatohasi::JST)
		assert_equal(Minatohasi::isimatu(0, 0, 0, Rational(2, 24)), Minatohasi::PT - Rational(2, 24))
		assert_equal(Minatohasi::isimatu(0, 0, 0, Rational(-2, 24)), Minatohasi::PT + Rational(2, 24))
		assert_equal(Minatohasi::isimatu(12, 0, 0, Minatohasi::PT), Rational(12, 24))
		assert_equal(Minatohasi::isimatu(12, 30, 0, Minatohasi::PT), Rational(12, 24) + Rational(30, 24 * 60))
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
		assert_equal(Minatohasi::rd(DateTime.new(2017, 10, 29, 8, 00, 0, Minatohasi::JST)).to_f, 82216)
		assert_equal(Minatohasi::rd(Minatohasi::EPOCH), 0)
		epoch = Minatohasi::EPOCH
		(0..10_000).each do |i|
			assert_equal(Minatohasi::rd(epoch + i), i)
		end
		(0..100_000).each do |i|
			assert_equal(Minatohasi::rd(epoch + i), i)
		end

		(-10_000..0).each do |i|
			assert_equal(Minatohasi::rd(epoch + i), i)
		end

		(-20_000..0).each do |i|
			assert_equal(Minatohasi::rd(epoch + i), i)
		end

		(-30_000..0).each do |i|
			assert_equal(Minatohasi::rd(epoch + i), i)
		end

		(-40_000..0).each do |i|
			assert_equal(Minatohasi::rd(epoch + i), i)
		end

		(-50_000..0).each do |i|
			assert_equal(Minatohasi::rd(epoch + i), i)
		end

		(-60_000..0).each do |i|
			assert_equal(Minatohasi::rd(epoch + i), i)
		end

		(-70_000..0).each do |i|
			assert_equal(Minatohasi::rd(epoch + i), i)
		end

		(-80_000..0).each do |i|
			assert_equal(Minatohasi::rd(epoch + i), i)
		end

		(-90_000..0).each do |i|
			p epoch + i
			assert_equal(Minatohasi::rd(epoch + i), i)
		end

		assert_equal(Minatohasi::rd(epoch), 0)
		assert_equal(Minatohasi::rd(epoch - 1), -1)
		assert_equal(Minatohasi::rd(epoch - 100), -100)
		assert_equal(Minatohasi::rd(epoch - 200), -200)
		assert_equal(Minatohasi::rd(epoch - 250), -250)
		assert_equal(Minatohasi::rd(epoch - 260), -260)
		assert_equal(Minatohasi::rd(epoch - 265), -265)
		assert_equal(Minatohasi::rd(epoch - 266), -266)
		assert_equal(Minatohasi::rd(epoch - 270), -270)
		assert_equal(Minatohasi::rd(epoch - 290), -290)
		assert_equal(Minatohasi::rd(epoch - 299), -299)
		assert_equal(Minatohasi::rd(epoch - 300), -300)
		assert_equal(Minatohasi::rd(epoch - 364), -364)
		assert_equal(Minatohasi::rd(epoch - 365), -365)
		assert_equal(Minatohasi::rd(epoch - 366), -366)
		assert_equal(Minatohasi::rd(epoch - 100_000), -100_000)

	end
end

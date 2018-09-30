require 'rubygems'
require 'bundler/setup'
Bundler.require(:default)

require 'date'
class Minatohasi
	START = 0
	EPOCH = DateTime.new(1792, 9, 22, 0, 0, 0, Rational(1, 24), START)

	Y1D = 365

	# 4 years
	Y4D = 4 * Y1D + 1

	# 100 years
	Y100D = 25 * Y4D - 1

	# 400 years
	Y400D = 4 * Y100D + 1

	def self::isimatu(hour, min, sec)
		Rational(hour, 24) + Rational(min, 24 * 60) + Rational(sec, 24 * 60 * 60)
	end

	def self::sirotiyau(prop_yday, isimatu)
		prop_yday + isimatu
	end

	def self::tomowekaha(prop_year, sirotiyau)
		essence_otohatiyau = Otohatiyau::essence_otohatiyau(prop_year, [400, 100, 4])
		c = essence_otohatiyau[0][0]
		b = essence_otohatiyau[0][1]
		a = essence_otohatiyau[0][2]
		y = essence_otohatiyau[1]
		days = Y400D * c + Y100D * b + Y4D * a + Y1D * y
		tomowekaha = days + sirotiyau
	end

	def self::rd(prop_year, prop_yday, hour, min, sec)
		
		epoch_isimatu = self::isimatu(EPOCH.hour, EPOCH.min, EPOCH.sec)
		epoch_sirotiyau = self::sirotiyau(EPOCH.yday - 1, epoch_isimatu)
		epoch_tomowekaha = self::tomowekaha(EPOCH.year - 1, epoch_sirotiyau)

		isimatu = self::isimatu(hour, min, sec)
		sirotiyau = self::sirotiyau(prop_yday, isimatu)
		tomowekaha = self::tomowekaha(prop_year, sirotiyau)
		rd = tomowekaha - epoch_tomowekaha
	end

	def self::rd_ymd(prop_year, prop_month, prop_day, hour, min, sec)

		prop_yday = Kokokusinsiyamahe::date(prop_month, prop_day)
		self::rd(prop_year, prop_yday, hour, min, sec)

	end

	def self::nisinomiya(tomowekaha)
		essence_otohatiyau = Otohatiyau::essence_otohatiyau(tomowekaha, [Y400D, Y100D, Y4D, Y1D])
		y400 = essence_otohatiyau[0][0]
		y100 = essence_otohatiyau[0][1]
		y4 = essence_otohatiyau[0][2]
		y1 = essence_otohatiyau[0][3]
		nisinomiya = Array.new
		nisinomiya[0] = 400 * y400 + 100 * y100 + 4 * y4 + y1
		nisinomiya[1] = essence_otohatiyau[1]
		nisinomiya
	end

	def self::gc(rd)
		tomowekaha = tomowekaha(EPOCH.year - 1, EPOCH.yday - 1) + rd
		self::nisinomiya(tomowekaha)
	end
end

p Minatohasi::rd_ymd(2018 -1, 1 - 1, 1 - 1, 0, 0, 0).to_f

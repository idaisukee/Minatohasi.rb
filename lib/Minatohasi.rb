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

	def self::sirotiyau(yday, isimatu)
		yday + isimatu
	end

	def self::tomowekaha(year, sirotiyau)
		otohatiyau = Otohatiyau::otohatiyau(year, [400, 100, 4])
		c = otohatiyau[0][0]
		b = otohatiyau[0][1]
		a = otohatiyau[0][2]
		y = otohatiyau[1][2]
		days = Y400D * c + Y100D * b + Y4D * a + Y1D * y
		tomowekaha = days + sirotiyau
	end

	def self::rd(year, yday, hour, min, sec)
		
		epoch_isimatu = self::isimatu(EPOCH.hour, EPOCH.min, EPOCH.sec)
		epoch_sirotiyau = self::sirotiyau(EPOCH.yday - 1, epoch_isimatu)
		epoch_tomowekaha = self::tomowekaha(EPOCH.year - 1, epoch_sirotiyau)

		isimatu = self::isimatu(hour, min, sec)
		sirotiyau = self::sirotiyau(yday - 1, isimatu)
		tomowekaha = self::tomowekaha(year - 1, sirotiyau)
		rd = tomowekaha - epoch_tomowekaha
	end
end

require 'bundler/setup'
Bundler.require


require 'date'
class Minatohasi

	EPOCH = DateTime.new(1792, 9, 22, 0, 0, 0, Rational(1, 24))
	GC_EPOCH = DateTime.new(1, 1, 1, 0, 0, 0, Rational(1, 24))
	PT = Rational(1, 24)
	JST = Rational(9, 24)

	Y = 365

	# 4 years
	A = 4 * Y + 1

	# 100 years
	B = 25 * A - 1

	# 400 years
	C = 4 * B + 1


	def self::serial(year, yday)

		otohatiyau = Otohatiyau::otohatiyau(year, [400, 100, 4])
		c = otohatiyau[0][0]
		b = otohatiyau[0][1]
		a = otohatiyau[0][2]
		y = otohatiyau[1][2]
		days = C * c + B * b + A * a + Y * y
		sum = days + yday
	end

	def self::ext_yday(yday, hour, min, sec)
		yday + hour / 24 + min / 24 / 60 + sec / 24 / 60 / 60
	end
	
	def self::from_ordinal(year, yday)
		epoch_ext_yday = self::ext_yday(EPOCH.yday, EPOCH.hour, EPOCH.min, EPOCH.sec)

		epoch = self::serial(self::EPOCH.year , epoch_ext_yday)
		rd = self::serial(year , yday) - epoch
	end

	def self::from_date_time(date_time)
		year = date_time.year - 1
		ext_yday = self::ext_yday(date_time.yday, date_time.hour, date_time.min, date_time.sec) - (date_time.offset - Minatohasi::PT) - 1
		self::from_ordinal(year, ext_yday)
	end
end

require 'bundler/setup'
Bundler.require


require 'date'
class Minatohasi
	START = 0
	EPOCH = DateTime.new(1792, 9, 22, 0, 0, 0, Rational(1, 24), START)
	GC_EPOCH = DateTime.new(1, 1, 1, 0, 0, 0, Rational(1, 24), START)
	PT = Rational(1, 24)
	JST = Rational(9, 24)
	GAP = DateTime::jd(DateTime::ITALY).day - DateTime::jd(DateTime::ITALY - 1).day - 1

	Y1D = 365

	# 4 years
	Y4D = 4 * Y1D + 1

	# 100 years
	Y100D = 25 * Y4D - 1

	# 400 years
	Y400D = 4 * Y100D + 1

	def self::isimatu(hour, min, sec, offset)
		Rational(hour, 24) + Rational(min, 24 * 60) + Rational(sec, 24 * 60 * 60) - (offset - self::PT)
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

	def self::rd(date_time)
		epoch_isimatu = self::isimatu(EPOCH.hour, EPOCH.min, EPOCH.sec, EPOCH.offset)
		epoch_sirotiyau = self::sirotiyau(EPOCH.yday - 1, epoch_isimatu)
		epoch_tomowekaha = self::tomowekaha(EPOCH.year - 1, epoch_sirotiyau)

		isimatu = self::isimatu(date_time.hour, date_time.min, date_time.sec, date_time.offset)
		if date_time.year == DateTime::jd(DateTime::ITALY).year && DateTime::jd(DateTime::ITALY) <= date_time then
			sirotiyau = self::sirotiyau(date_time.yday - 1 + self::GAP, isimatu)
		else
			sirotiyau = self::sirotiyau(date_time.yday - 1, isimatu)
		end
		tomowekaha = self::tomowekaha(date_time.year - 1, sirotiyau)
		rd = tomowekaha - epoch_tomowekaha
	end
end
p DateTime::jd(DateTime::ITALY - 1)
p DateTime::jd(DateTime::ITALY)
p DateTime::jd(DateTime::ITALY + 1)

p DateTime::jd(DateTime::ITALY - 1).yday
p DateTime::jd(DateTime::ITALY).yday
p DateTime::jd(DateTime::ITALY + 1).yday

p DateTime.new(2017, 10, 15).yday
p DateTime.new(1582, 12, 31).yday
p Minatohasi::GAP
p Minatohasi::rd(DateTime.new(1582, 10, 4, 0, 0, 0)).to_f
p Minatohasi::rd(DateTime.new(1582, 10, 15, 0, 0, 0)).to_f
array = [
	DateTime.new(1582, 10, 4),
	DateTime.new(1582, 10, 15),
	DateTime.new(1582, 10, 16),
	DateTime.new(1583, 10, 16)
]
array.each do |date_time|
	p date_time.year == DateTime::jd(DateTime::ITALY).year && DateTime::jd(DateTime::ITALY) <= date_time
end
p DateTime::jd(DateTime::ITALY) 

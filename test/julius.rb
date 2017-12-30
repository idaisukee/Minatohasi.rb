require 'date'
y = DateTime::jd(DateTime::ITALY).year - 1
start = DateTime.new(y, 1, 1, 0, 0, 0, 0)
(0..365).each do |i|
	p start + i
end

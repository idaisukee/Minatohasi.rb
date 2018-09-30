require 'bundler/setup'
require 'date'

base_dir = File.expand_path(File.join(File.dirname(__FILE__), ".."))
lib_dir  = File.join(base_dir, "lib")

require(File.join(lib_dir, 'Minatohasi.rb'))

now = DateTime.now.new_offset(Rational(1, 24))

rd = Minatohasi::rd(now.year - 1, now.yday - 1, now.hour, now.min, now.sec)
print str = sprintf('%#.10g', rd)

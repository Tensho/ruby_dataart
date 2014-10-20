# Run distributed storage service at first.
require 'drb'

DRb.start_service
proxy_storage = DRbObject.new(nil, 'druby://localhost:9000')

proxy_storage.add('abcd,abce,abcf,def,defa')
puts proxy_storage.to_h
puts "Find words started from 'abc': #{proxy_storage.find('abc')}"
puts "Find words started from 'giv': #{proxy_storage.find('giv')}"
puts "Find words started from 'z': #{proxy_storage.find('z')}"

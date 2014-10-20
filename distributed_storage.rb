require_relative 'storage'
require 'drb'

storage_service = Storage.new.load_from_file('words-in')
DRb.start_service("druby://localhost:9000", storage_service)
DRb.thread.join

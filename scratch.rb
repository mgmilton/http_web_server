require 'faraday'
response = Faraday.get "http://127.0.0.1:9292/"
require 'pry' ; binding.pry

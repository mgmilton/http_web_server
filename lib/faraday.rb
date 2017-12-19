require 'faraday'

response = Faraday.get("http://localhost:9292/hello")

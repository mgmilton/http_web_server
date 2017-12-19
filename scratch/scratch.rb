

def diagnostics(request_lines)
  verb_path_and_protocol = request_lines[0].split
  host = request_lines[1].split[1]
  port = request_lines[1].split(":")[2]
  accept = request_lines[6].split[1]
  [
    "<pre>",
    "Verb: #{verb_path_and_protocol[0]}",
    "Path: #{verb_path_and_protocol[1]}",
    "Protocol: #{verb_path_and_protocol[2]}",
    "Host: #{host}",
    "Port: #{port}",
    "Orign: #{host}",
    "Accept: #{accept}",
    "</pre>"
  ].join("\n")
end

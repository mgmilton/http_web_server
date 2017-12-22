a = ["date", "Fri, 22 Dec 2017 03:31:37 -0700", "server", "ruby", "content-type", "text/html; charset=iso-8859-1", "content-length", "136"]

s = a.each_with_index do |value, index|
  a[index] = "#{a[index]}: #{a[index+1]}"
  a.delete(a[index+1])
end.delete_at(-1)

p s
p ["date: Fri, 22 Dec 2017 03:31:37 -0700", "server: ruby", "content-type: text/html; charset=iso-8859-1"]

data = File.open('webfile.html').read()
include = File.read('srcs/webfile_include.js')

s = data.index("try {")
e = data.rindex('</script>')
data = data[s..(e-1)]

data = "$(function(){ \n\n #{include} \n\n #{data} \n\n });"
print data


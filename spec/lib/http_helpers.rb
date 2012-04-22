require 'open-uri'

# simple wrapper around open-uri's open() that will
# fetch an HTTP or HTTPS resource including follow redirects.
# Returns a hash with 2 members:
#
#  response[:meta] = the original open-uri response object. Use this to 
#                    access metadata such as status code.  See
#                    http://ruby-doc.org/stdlib-1.9.2/libdoc/open-uri/rdoc/OpenURI/Meta.html
#                    for a list of attributes and methods available.                 
#  response[:body] = the response content as string
#
def get(url)
  r = {}
  resp = open(url)
  r[:meta] = resp
  r[:body] = resp.read
  return r
end
spec = Gem::Specification.new do |s|
  s.name = 'postcodes'
  s.version = '0.1.0'
  s.license = 'Public Domain'
  s.summary = 'A wrapper for the OpenPostcodes.com API'
  s.description = 'Open Postcodes provides a postcode lookup API for UK addresses. More information https://openpostcodes.com'
  s.authors = ['Open Postcodes']
  s.email = ['support@openpostcodes.com']
  s.homepage = 'https://openpostcodes.com'

  s.add_dependency('rest-client', '~> 1.6')
  s.add_dependency('multi_json', '~> 1.7.9')

  s.files = ['Gemfile',
		     'README.md',
			 'lib/postcodes.rb',
			 'lib/postcodes/errors.rb',
			 'lib/postcodes/postcode.rb',
			 'lib/postcodes/util.rb']
  s.require_paths = ['lib']
end
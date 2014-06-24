# Open Postcodes API Ruby Wrapper

Retrieve a list of addresses for any postcode in the United Kingdom using the Open Postcodes API.

## Getting Started

__Installation__

```bash
gem install postcodes
```

__Get an API Key__

Get a key at [Open Postcodes](https://openpostcodes.com), then try out our service with our testing postcodes e.g. 'XA1 0XX'

__Implement it__

You can complete a full address lookup with just a couple of lines of Ruby.

```ruby
require 'postcodes'

Postcodes.api_key = "your_key_here"

postcode = Postcodes::Postcode.lookup "XA1 0XX"

#	postcode.addresses =>
#
# [
#		{
#			:postcode=>"XA1 0XX",
# 		:post_town=>"LONDON",
# 		:line_1=>"The Pavilion",
# 		:line_2=>"Oaks Avenue",
# 		:line_3=>""
#		}, 
#		... and so on
```

## Registering

Open Postcodes provides street level address data for website, mobile and desktop applications at a competitive price.

We charge _1p_ per public lookup; take a look at our [pricing](https://openpostcodes.com/pricing)

## Documentation

More in-depth documentation can be found [here](https://openpostcodes.com/documentation#examples-ruby)

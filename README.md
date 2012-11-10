# BookFinderApi

TODO: Write a gem description

## Installation

Add this line to your application's Gemfile:

    gem 'book_finder_api'

And then execute:

    $ bundle 

Or install it yourself as:

    $ gem install book_finder_api

## Usage

	method : flipkart
	parameter : ISBN
		ISBN number of the Book you want to get. It should be 10 digits.
	returns : Hash 
		It returns the Hash of the Book Details with Field and value basis.	
	Syntax :
		Hash BookFinder.flipkart(ISBN)
	Example :
		book_details = BookFinder.flipkart(9788120305960)
	
## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request

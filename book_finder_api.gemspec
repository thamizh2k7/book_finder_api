# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'book_finder_api/version'

Gem::Specification.new do |gem|
  gem.name          = "book_finder_api"
  gem.version       = BookFinderApi::VERSION
  gem.authors       = ["thamizh2k7"]
  gem.email         = ["thamizh@devbrother.com"]
  gem.description   = %q{Finds the book details from the flipkart}
  gem.summary       = %q{This is for the Flipkart scrapping api}
  gem.homepage      = "https://rubygems.org/gems/book_finder_api"

  gem.files         = `git ls-files`.split($/)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ["lib"]
  gem.add_runtime_dependency "nokogiri"
  gem.add_runtime_dependency "mechanize"
end

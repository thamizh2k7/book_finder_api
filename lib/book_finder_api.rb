require "book_finder_api/version"

class BookFinder
		#	method : flipkart
		#	parameter : ISBN
		#		ISBN number of the Book you want to get. It should be 10 digits.
		#	returns : Hash 
		#		It returns the Hash of the Book Details with Field and value basis.	
		#	Syntax :
		#		Hash BookFinder.flipkart(ISBN)
		#	Example :
		#		book_details = BookFinder.flipkart(9788120305960)
	def self.flipkart(isbn)
		search_url="http://www.flipkart.com/search/a/all?query=#{isbn}"
		result=Hash.new
		agent =Mechanize.new
		page = agent.get(search_url)
		page.search(".fk-specs-type2 tr").each do |tr|
			fk_key=tr.search(".specs-key").text()
			fk_val=tr.search(".specs-value").text()
			unless fk_val==""
				result[fk_key]=fk_val
			end
		end
		result
	end
end


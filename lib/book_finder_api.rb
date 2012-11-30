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
		college = page.search(".fk-lbreadbcrumb a")[4]
		if college
			result['college']=college.search("span").text()
		end
		stream = page.search(".fk-lbreadbcrumb a")[5]
		if stream
			result['stream']= stream.search("span").text()
		end
		page.search("#main-image-id").each do |img_id|
			img_tag=img_id.search("img")
			img_url=img_tag.attribute("src")
			result["img_url"]=img_url.to_s
		end
		price=page.search("#fk-mprod-list-id").text()
		if price ==""	
			price = page.search("#fk-mprod-our-id").text()
		end
		price.delete!("Rs. ")
		result["price"]=price
		result["availability"]=page.search("#fk-stock-info-id").text()
		result["description"]=page.search("#description").text().force_encoding("UTF-8")
		result
	end
end


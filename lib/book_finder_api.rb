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
		#setting the url
		search_url="http://www.flipkart.com/search/a/all?query=#{isbn}"

		#initiating the Mechanize
		result=Hash.new
		agent =Mechanize.new

		#for following redirect
		agent.redirect_ok

		#getting the page
		page = agent.get(search_url)

		#getting the titles and author
 		title_div=page.search(".mprod-summary-title")
 		puts "BOOK:#{title_div.search('h1').text()}"
 		result["Book"]=title_div.search("h1").text()
 		book_authors=[]
 		authors=title_div.search("h2")
 		authors.each do |author|
 			book_authors << author.text()
 		end
 		result["Author"]=book_authors.join(",")
 		if result["Author"] ==""
 			title_div.search(".secondary-info a").each do |author|
 				book_authors << author.inner_html
 			end
 			result["Author"]=book_authors.join(",")
 		end
		#storing the resluts
		page.search(".fk-specs-type2 tr").each do |tr|
			fk_key=tr.search(".specs-key").text()
			fk_val=tr.search(".specs-value").text()
			unless fk_val==""
				result[fk_key]=fk_val
			end
		end

		#storing the colleges from breadcrumb
		breadcrumb = page.search(".fk-lbreadbcrumb a")
		generals = ['Other General','Others Engineering']
		
		
		if breadcrumb.count >0
			result['college']=breadcrumb[4].search("span").text() if breadcrumb[4]
			result['stream']= breadcrumb[5].search("span").text() if breadcrumb[5]
			if generals.include? (result['college'])
				result['college']=breadcrumb[5].search("span").text()
				result['stream']= breadcrumb[6].search("span").text() if(breadcrumb[6])
			end
		end

		#storing the image
		img_tag=page.search("#mprodimg-id")
		puts "IMAGE:#{img_tag}"
		unless img_tag.empty?
			img = img_tag.search("img")
			begin
			img_url = img.attribute("data-src") 
			result["img_url"]=img_url.to_s
			rescue
				result["img_url"]=""
			end
			puts "#{result['img_url']} is image url"
		else
			page.search("#main-image-id").each do |img_id|
				img_tag=img_id.search("img")
				img_url=img_tag.attribute("src")
			end
			result["img_url"]=img_url.to_s	
			puts "Secondary Image: #{result['img_url']} is image url"
		end
		#storing the price
		price = page.search("#fk-mprod-list-id").text()
		price = page.search("#fk-mprod-our-id").text() if price ==""	
		price = page.search(".fk-font-finalprice").text() if price ==""	
		
		price.delete!("Rs. ")
		result["price"] = price
		result["availability"] = page.search("#fk-stock-info-id").text()
		result["description"] = page.search("#description").inner_html().force_encoding("UTF-8")
		result["description"].gsub!('<a href="#">top</a>',"")
		result
	end
end


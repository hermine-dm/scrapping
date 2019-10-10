require 'rubygems'
require 'nokogiri'
require 'open-uri'

=begin
def finding_the_page(ville)
	townhall_url = Nokogiri::HTML(open("https://www.annuaire-des-mairies.com/95/#{ville}.html"))
	return townhall_url
end
=end

def get_townhall_email(townhall_url)
	begin #ne sert à rien il n'y avait pas d'erreur haha
		page = Nokogiri::HTML(open("#{townhall_url}"))
		email = page.xpath('//section[2]//tr[4]/td[2]/text()') #// saute le chemin au milieu
	rescue  => e
  		email = "n/a"
  	end
  	return email
end
  	

def get_towhall_city()
	page = Nokogiri::HTML(open("http://annuaire-des-mairies.com/val-d-oise.html"))
	array_of_city = page.xpath('//*[@class="lientxt"]/text()')
	return array_of_city
end

def get_townhall_urls(array)
	arr_wo_space = array.map{|city| city.to_s.tr(' ','-')}
	array_of_urls = arr_wo_space.map{|city_wo|"https://www.annuaire-des-mairies.com/95/#{city_wo.downcase}.html"}
	return array_of_urls
end

def creat_final_array(arr_city,arr_email)
	arr_final = []
	for i in 0...arr_city.size
		arr_final << {arr_city[i].to_s => arr_email[i].to_s} #ne pas mettre des crochets autour sinon ca fait un array	
	end
	return arr_final
end

def perform()
	array_of_city = get_towhall_city()
	array_of_urls = get_townhall_urls(array_of_city)
	array_of_email = array_of_urls.map{|urls| urls = get_townhall_email(urls)}
	arr_final = creat_final_array(array_of_city,array_of_email)
	puts arr_final
	return arr_final
end

perform()

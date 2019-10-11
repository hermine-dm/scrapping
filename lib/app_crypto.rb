require 'rubygems'
require 'nokogiri'
require 'open-uri'

=begin
mon programme au début sans les méthodes :
page = Nokogiri::HTML(open("https://coinmarketcap.com/all/views/all/"))
all_crypto_sym = page.xpath('//td[3]/text()')
all_crypto_cur = page.xpath('//td[5]/a/text()')
arr_final_cur = []
for i in 0...arr_sym.size
	arr_final_cur << {all_crypto_sym[i].to_s => all_crypto_cur[i].to_s.delete('$').to_f}
end
=end

#avec les methodes qui rendent le programme plus lourd
def finding_the_page(https)
	page = Nokogiri::HTML(open("#{https}"))
	return page
end

def array_of_sym(page) 
	all_crypto_sym = page.xpath('//td[3]/text()')
	#on peut aussi écrire page.xpath('//*[@class="text-left col-symbol"]/text()')
	return all_crypto_sym
end

def array_of_cur(page) 
	all_crypto_cur = page.xpath('//td[5]/a/text()')
	return all_crypto_cur
end

def creat_final_array(arr_sym,arr_cur)
	arr_final_cur = []
	for i in 0...arr_sym.size
		arr_final_cur << {arr_sym[i].to_s => arr_cur[i].to_s.delete('$').to_f} #ne pas mettre des crochets autour sinon ca fait un array
		
	end
	return arr_final_cur
end

def perform(href)
	page = finding_the_page(href)
	all_crypto_sym = array_of_sym(page)
	all_crypto_cur = array_of_cur(page)
	arr_final_cur = creat_final_array(all_crypto_sym,all_crypto_cur)
	puts arr_final_cur
	return arr_final_cur
end

perform("https://coinmarketcap.com/all/views/all/")

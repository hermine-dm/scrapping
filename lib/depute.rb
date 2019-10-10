require 'rubygems'
require 'nokogiri'
require 'open-uri'



def get_members_list()
    page = Nokogiri::HTML(open("http://www2.assemblee-nationale.fr/deputes/liste/tableau"))
    list_of_members = page.xpath('///a[starts-with(@href,"/deputes/fiche")]/text()')
    return list_of_members
end

def member_url()
	page = Nokogiri::HTML(open("http://www2.assemblee-nationale.fr/deputes/liste/tableau"))
    list_of_urls = page.xpath('///a[starts-with(@href,"/deputes/fiche")]/@href')
    list_of_urls = list_of_urls.map{|url| "http://www2.assemblee-nationale.fr#{url}"}
    return list_of_urls
end

def find_email(url)
	begin 
		page = Nokogiri::HTML(open("#{url}"))
		email = page.xpath('//*[@id="haut-contenu-page"]/article/div[3]/div/dl//ul/li[2]/a/text()')
	rescue  => e
  		email = "n/a"
  	end
  	return email
end

def create_hash_member(one_member)
	split_array = one_member.to_s.split(" ")
	first_name = split_array[1]
	last_name = split_array[2...split_array.size].join('')
	

	hash_of_member = Hash.new(0)
	hash_of_member["first_name"] = first_name
	hash_of_member["last_name"] = last_name
	
	return hash_of_member
end

def create_arr_members(array)
	array_of_members =[]
	array.each do |member|
		array_of_members << create_hash_member(member)
	end
	return array_of_members
end

def create_arr_mail(array)
	array_of_mail =[]
	for i in 0...array.size
		array_of_mail << {"email" => find_email(array[i]).to_s}
	end
	return array_of_mail
end

def create_final(array_members, array_mail)
	array_final = []
	for i in 0...array_members.size
		array_final << array_members[i].merge(array_mail[i])
	end	
	puts array_final
	return array_final
end

def perform()
	list_of_members = get_members_list()
	array_of_members = create_arr_members(list_of_members)
	list_of_urls = member_url()
	array_of_mail = create_arr_mail(list_of_urls)
	create_final(array_of_members, array_of_mail)
end

perform()


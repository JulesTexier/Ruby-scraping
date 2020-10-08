require 'rubygems'
require 'nokogiri'
require 'open-uri'
  


# je récupère les urls de chaque ville

def get_townhall_urls
  page = Nokogiri::HTML(URI.open('https://www.annuaire-des-mairies.com/val-d-oise.html'))
  liens = page.xpath('//*[@class="Style20"]//a')
  hrefs = liens.css(".lientxt").map { |anchor| anchor["href"] }
  link = hrefs.map {|x| x.gsub("./", 'https://www.annuaire-des-mairies.com/')}
end
 

# je récupère le nom des villes
def get_townhall_name (get_townhall_urls)
  town = get_townhall_urls.map do |x|
    page_2 = Nokogiri::HTML(URI.open(x))
    list_cities = page_2.xpath('/html/body/div/main/section[1]/div/div/div/h1').text
    puts list_cities
    list_cities
  end
end

# je récupère les emails des mairies
def get_townhall_email (get_townhall_urls)
  mails_adress = get_townhall_urls.map do |x|
    page_2 = Nokogiri::HTML(URI.open(x))
    list_emails = page_2.xpath('/html/body/div/main/section[2]/div/table/tbody/tr[4]/td[2]').text
    puts list_emails
    list_emails
  end
end

# je réunis tout dans un array
def array_final (get_townhall_name, get_townhall_email)
  array_final = get_townhall_name.zip(get_townhall_email).map{|x| {x[0] => x[1]}}
  print array_final
end

def perf 
  init = get_townhall_urls
  names = get_townhall_name(init)
  emails = get_townhall_email(init)
  array = array_final(names, emails)
end

perf
  



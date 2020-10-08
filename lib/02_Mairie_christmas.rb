require 'rubygems'
require 'nokogiri'
require 'open-uri'
  


def get_townhall_urls
  page = Nokogiri::HTML(URI.open('https://www.annuaire-des-mairies.com/val-d-oise.html'))
  gg = page.xpath('//*[@class="Style20"]//a')
  hrefs = gg.css(".lientxt").map { |anchor| anchor["href"] }
  link = hrefs.map {|x| x.gsub("./", 'https://www.annuaire-des-mairies.com/')}
end
 
def get_townhall_name (get_townhall_urls)
  town = get_townhall_urls.map do |x|
    page_2 = Nokogiri::HTML(URI.open(x))
    imp_1 = page_2.xpath('/html/body/div/main/section[1]/div/div/div/h1').text
    puts imp_1
    imp_1
  end
end

def get_townhall_email (get_townhall_urls)
  mails_adress = get_townhall_urls.map do |x|
    page_2 = Nokogiri::HTML(URI.open(x))
    imp_2 = page_2.xpath('/html/body/div/main/section[2]/div/table/tbody/tr[4]/td[2]').text
    puts imp_2
    imp_2
  end
end

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
  



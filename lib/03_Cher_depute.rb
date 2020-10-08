require 'rubygems'
require 'nokogiri'
require 'open-uri'
  
# je récupère l'url de chaque député
def get_depute_url
  page = Nokogiri::HTML(URI.open('http://www2.assemblee-nationale.fr/deputes/liste/alphabetique'))
  gg = page.xpath('//*[@id="deputes-list"]/div/ul')
  hrefs = gg.css('ul.col3 a').map { |anchor| anchor["href"] }
  link = hrefs.map {|x| x.gsub("/deputes", 'http://www2.assemblee-nationale.fr/deputes')}
  link
end

# je génère les prénoms et noms et fais une boucle
def name (get_depute_url)
  deputes = get_depute_url.map do |x|
    page_1 = Nokogiri::HTML(URI.open(x))
    imp_1 = page_1.xpath('//*[@id="haut-contenu-page"]/article/div[2]/h1').text
    puts imp_1
    imp_1
  end
end

# je génère les emails et fais une boucle
def mail (get_depute_url)
  mail = get_depute_url.map do |x|
    page_2 = Nokogiri::HTML(URI.open(x))
    imp_2 = page_2.xpath('//*[@id="haut-contenu-page"]/article/div[3]/div/dl/dd[4]/ul/li[2]/a').text
    puts imp_2
    imp_2
  end
end

# je réunis dans un array
def array_final (name, mail)
  i = 0
  array = []
  while i < mail.length
    array << {:first_name => name[i].to_s.split(' ')[1], :last_name => name[i].to_s.split(' ')[2], :email => mail[i].to_s} 
    i+=1
  end
  puts array
end

def perf
  url = get_depute_url
  names = name(url)
  mails = mail(url)
  array = array_final(names, mails)
end

perf




  
  
  
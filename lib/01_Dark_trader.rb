require 'rubygems'
require 'nokogiri'
require 'open-uri'
  

page = Nokogiri::HTML(URI.open('https://coinmarketcap.com/all/views/all/'))

all_crypto_symbols = page.xpath('//*[@id="__next"]/div[1]/div[2]/div[1]/div[2]/div/div[2]/div[3]/div/table/tbody/tr/td[3]/div')
all_crypto_values = page.xpath('//*[@id="__next"]/div[1]/div[2]/div[1]/div[2]/div/div[2]/div[3]/div/table/tbody/tr/td[5]')


# je récupère les devises et fais une boucle
all_cryptos_symbols = all_crypto_symbols.map do |symbols|
symbols.text
end

# je récupère les valeurs et fais une boucle
all_cryptos_values = all_crypto_values.map do |values|
values.text
end

# je réunis tout dans un array
def array_final (symbols, values)
  array_final = symbols.zip(values).map{|x| {x[0] => x[1]}}
  print array_final
  return array_final
end

array_final(all_cryptos_symbols, all_cryptos_values)
# frozen_string_literal: true

require 'nokogiri'
require 'httparty'
require 'byebug'

def pages
  url = 'https://www.cabelas.ca/category/casting-rods/622'
  unparsed_page = HTTParty.get(url)
  parsed_page = Nokogiri::HTML(unparsed_page)
  products = []
  product_listings = parsed_page.css('article.productCard')
  page = 1
  per_page = product_listings.count
  total = 60 # parsed_page.css('p.pagination-showing').text.split('')[1].gsub(',', '').to_i
  last_page = (total.to_f / per_page.to_f).round
  while page <= last_page
    pagination_url = "https://www.cabelas.ca/category/casting-rods/622?pagesize=24&orderby=0&pagenumber=#{page}"
    puts pagination_url
    puts "Page: #{page}"
    puts ''
    pagination_unparsed_page = HTTParty.get(pagination_url)
    pagination_parsed_page = Nokogiri::HTML(pagination_unparsed_page)
    pagination_product_listings = pagination_parsed_page.css('article.productCard')

    product_listings.each do |product_listing|
      product = {
        # image: product_listing.css('img.lazy-load').image,
        title: product_listing.css('a').text,
        price: product_listing.css('span.price-primary').text
        # url: "https://www.cabelas.ca/category/casting-rods/622" + product_listing.css('a')[0].attributes["href"].value
      }
      products << product
      puts (product[:title]).to_s
      puts (product[:price]).to_s
      puts ''
    end
    page += 1
end
  byebug
end
pages

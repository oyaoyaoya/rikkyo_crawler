gem 'nokogiri'
require './capybara_crawle'
require './nokogiri_crawle'

capybara_crawle = CapybaraCrawler.new
capybara_crawle.set_target_url
capybara_crawle.access_to_target
capybara_crawle.move_to_koma_page
html = capybara_crawle.return_html

nokogiri = NokogiriCrawle.new(html)
nokogiri.get_list

require './capybara_crawler'
require './nokogiri_crawler'

# Capybaraのオブジェクトを作成
capybara_crawler = CapybaraCrawler.new

# 親となるページにアクセスする
capybara_crawler.access_to_target(capybara_crawler.set_parent_url)

capybara_crawler.make_links_list_for_department.each do |link|
	capybara_crawler.access_to_target(link)
	html = capybara_crawler.return_html

	nokogiri = NokogiriCrawler.new(html)
	nokogiri.scraping_lessons

	# 処理を60秒停止する
	sleep(60)
end




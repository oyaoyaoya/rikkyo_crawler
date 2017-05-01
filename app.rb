require './capybara_crawler'
require './nokogiri_crawler'
require './csv_crawler'

# Capybaraのオブジェクトを作成
capybara_crawler = CapybaraCrawler.new

# 親となるページにアクセスする
capybara_crawler.access_to_target(capybara_crawler.set_parent_url)

capybara_crawler.make_links_list_for_department.each do |link|

	capybara_crawler.access_to_target(link)
	html = capybara_crawler.return_html

	# 学部学科IDをセット
	fa_de_id = NokogiriCrawler.belongs_format(link)

	puts "#{fa_de_id}のページです"

	for i in 0..99
		master_lesson_data = []
		puts "-----#{i+1}ページ目-----"
		# 確認用
		capybara_crawler.screen_shot

		nokogiri = NokogiriCrawler.new(capybara_crawler.return_html, fa_de_id)
		master_lesson_data << nokogiri.scraping_lessons

		# 次のページが存在する場合は遷移
		# ない場合はcsvに書き出して次の学科ページへ
		if capybara_crawler.next_page_exist
		capybara_crawler.click_link(capybara_crawler.next_page_exist)
		CsvCrawler.new(master_lesson_data, fa_de_id).generate_csv

		sleep(10)
	else
		break
	end
end

	# 処理を60秒停止する
	sleep(60)
end




require './capybara_crawler'
require './nokogiri_crawler'
require './csv_crawler'

# Capybaraのオブジェクトを作成
capybara_crawler = CapybaraCrawler.new

# 親となるページにアクセスする
capybara_crawler.access_to_target(capybara_crawler.set_parent_url)

# ディレクトリの名前をセット
dir_name = "lesson_data_#{Time.now.strftime("%H%M%S")}"
Dir.mkdir("lesson_data/#{dir_name}", 0755)

capybara_crawler.make_links_list_for_department.each do |link|

	capybara_crawler.access_to_target(link)
	html = capybara_crawler.return_html

	# 学部学科IDをセット
	fa_de_id = NokogiriCrawler.belongs_format(link)
	puts "#{fa_de_id}のページです"

	# 各学科ごとのファイルの名前をセット
	time_stamp = Time.now.strftime("%H%M%S")
	file_name = "lesson_#{fa_de_id[0]}_#{fa_de_id[1]}_#{time_stamp}.csv"

	for i in 0..500
		puts "-----#{i+1}ページ目-----"
		# 確認用。スクショ撮ってどのページにいるか見る
		# capybara_crawler.screen_shot

		nokogiri = NokogiriCrawler.new(capybara_crawler.return_html, fa_de_id)

		# 次のページが存在する場合は遷移
		# ない場合はcsvに書き出して次の学科ページへ
		if capybara_crawler.next_page_exist
			capybara_crawler.click_link(capybara_crawler.next_page_exist)
			CsvCrawler.new(nokogiri.scraping_lessons, file_name, dir_name).generate_csv

			sleep(10)
		else
			break
		end
	end

	# 処理を60秒停止する
	sleep(60)
end




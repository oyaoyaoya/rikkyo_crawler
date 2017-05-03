require './capybara_crawler'
require './nokogiri_crawler'
require './csv_crawler'

# Capybaraのオブジェクトを作成
capybara_crawler = CapybaraCrawler.new

# ディレクトリ名を入力する
puts "ディレクトリ名を入力してください"
dir_name = gets.chomp!


# 指定したディレクトリの中にあるファイル名を取得する
CsvCrawler.get_files_list(dir_name).each do |file|

	lesson_detail_url = []

	# ファイルの12列目に含まれるURLを配列にセット
	lesson_detail_url << CsvCrawler.get_url(file)

	lesson_data = []

	lesson_detail_url.first.each do |url|
		# もしURLがない場合はスキップ
		# TODO URLがない場合でもidだけ振ってからのレコードを入れる
		next if url == nil

		# シラバスページにアクセス
		capybara_crawler.access_to_target(url)
		nokogiri = NokogiriCrawler.new(capybara_crawler.return_html, "")

		lesson_data << nokogiri.scraping_lesson_detail

		break
	end
	# シラバスのスクレイピング
	CsvCrawler.new(lesson_data, "test.csv", "aa").generate_csv
end


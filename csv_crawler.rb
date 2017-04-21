 require 'csv'

 class CsvCrawler
	def initialize(data)
		@lesson_data = data
	end

	def generate_csv
		puts 'csvファイルを出力中・・・'
		csv_data = CSV.generate do |csv|
			count = @lesson_data.count
			@lesson_data.each do |data|
				lesson_msg = data.each { |d| d }
				csv << lesson_msg
			end
		end

		File.open('test.csv', 'w') do |file|
			file.write(csv_data)
		end

		puts 'csvファイルの出力が完了しました。'
	end
 end

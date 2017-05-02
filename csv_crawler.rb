 require 'csv'

 class CsvCrawler
	def initialize(data, file_name, dir_name)
		@lesson_data = data
		@file_name = file_name
		@dir_name = dir_name
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

		time_stamp = Time.now.strftime("%H%M%S")

		File.open("lesson_data/#{@dir_name}/#{@file_name}", 'a') do |file|
			file.write(csv_data)
		end

		puts 'csvファイルの出力が完了しました。'
	end
 end

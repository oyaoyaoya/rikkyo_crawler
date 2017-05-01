 require 'csv'

 class CsvCrawler
	def initialize(data, fa_de_id)
		@lesson_data = data.first
		@fa_de_id = fa_de_id
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

		File.open("lesson_#{@fa_de_id[0]}_#{@fa_de_id[1]}.csv", 'a') do |file|
			file.write(csv_data)
		end

		puts 'csvファイルの出力が完了しました。'
	end
 end

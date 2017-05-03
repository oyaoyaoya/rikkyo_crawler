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
			@lesson_data.each do |data|
				p data
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

	# 任意のディレクトリに含まれるcsvファイルの配列を生成
	# dir_nameはディレクトリの名前
	def self.get_files_list(dir_name)
		Dir.glob("./lesson_data/#{dir_name}/*.csv")
	end

	# 授業一覧のcsvに含まれるURLの配列を生成する
	# 引数：ファイルのパス
	def self.get_url(file_name)
		url = []
		csv_data = CSV.read(file_name)
		csv_data.each do |data|
			# data[12]がURLが記載されている列
			url << data[12]
		end
		url
	end

 end

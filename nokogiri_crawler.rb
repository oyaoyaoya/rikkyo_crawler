gem 'nokogiri'
require './lib/department'
require './lib/faculty'

class NokogiriCrawler
	def initialize(html, fa_de_id)
		# htmlをパースしてオブジェクトを生成
		@doc = Nokogiri::HTML.parse(html)
		@fa_de_id = fa_de_id

		@lesson_data = []
	end

	def scraping_lessons
		# 授業名のリストを取得
		@doc.css('.column_even, .column_odd').each do |lesson_row|
			@lesson_data << format_each_lesson(lesson_row)
		end

		@lesson_data
	end

	def format_each_lesson(lesson_row)
		lesson_row_formated = []
		lesson_row_formated << @fa_de_id

		for num in 1..7 do
			case num
			when 2,3
				# 科目コードと科目名の整形
				lesson_row_formated << lesson_row.css("td:nth-child(#{num})").text.gsub(/(\r\n|\r|\n|)/, "").strip!
			when 4
				# 担当者名を半角スペースで区切る
				lesson_row_formated << lesson_row.css("td:nth-child(#{num})").inner_html.gsub(/(<br>)/, " ")
			when 5
				# 学期・曜日・時限・教室の整形
				lesson_row_formated << lesson_koma_format(lesson_row.css("td:nth-child(#{num})").text.gsub(/(\r\n|\r|\n)/, ""))
			when 6
				# キャンパス名を数字に変換
				lesson_row_formated << lesson_campus_format(lesson_row.css("td:nth-child(#{num})").text.gsub(/(\r\n|\r|\n)/, ""))
			else
				lesson_row_formated << lesson_row.css("td:nth-child(#{num})").text.gsub(/(\r\n|\r|\n)/, "")
			end

		end
		# 各授業ページへのリンクを取得
		lesson_row_formated << "https://sy.rikkyo.ac.jp" + lesson_row.css("td:nth-child(3) a")[0][:href]
		# 年度を追加
		# プログラム上は現在の年を追加
		lesson_row_formated << "#{Time.now.year}"

		lesson_row_formated.flatten!.map do |l|
			# 空文字ならnilを
			# 文字があるならそれ自身を代入
			if l.length <= 0
				l = 'nil'
			else
				l = l
			end
		end
	end

	def self.belongs_format(link)
		belongs = []
		if faculty_id = link.match(/\(crclm\)=X(\S{2})/)
			faculty = Faculty.new(faculty_id[1]).select_faculty
			belongs << faculty
		end
		if department_id = link.match(/\(crclm\)=X(\S{5})/)
			department = Department.new(department_id[1]).select_department
			belongs << department
		end

		belongs
	end

	def lesson_koma_format(data)
		# 学期・曜日・時限・教室を整形する。
		koma = []
		splited = data.split("・")
		splited.each_with_index do |s, i|
			case i
			when 0
				# 学期を数に変換
				# DB設計によっては不要か
				# 現在コメントアウト。学期は文字列のままDBへ
				s_formted = s.sub(/春.*/, "1").sub(/秋.*/,"2").sub(/通年/,"3").sub(/他/,"4")
				koma << s_formted
			when 1
				# 曜日を数に変換
				days = {'月'=>'1', '火'=>'2', '水'=>'3', '木'=>'4', '金'=>'5', '土'=>'6', '日'=>'7'}
				s_formted = s.gsub(/#{days.keys.join('|')}/, days)
				koma << s_formted
			else
				# 時限を全角から半角に
				s.split.each {|x| koma << x.tr("０-９", "0-9")}
			end
		end
		koma
	end

	def lesson_campus_format(data)
		# 校地を数に変換
		campus = ""
		if data == "池袋"
			campus = "1"
		elsif data == "新座"
			campus = "2"
		else
			campus = "3"
		end
		campus
	end

end

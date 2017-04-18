gem 'nokogiri'

class NokogiriCrawler
	def initialize(html)
		# htmlをパースしてオブジェクトを生成
		@doc = Nokogiri::HTML.parse(html)

		@lesson_data = []
	end

	def scraping_lessons
		# 授業名のリストを取得
		@doc.css('.column_even, .column_odd').each do |lesson_row|
			@lesson_data << format_each_lesson(lesson_row)
		end

		p @lesson_data
	end

	def format_each_lesson(lesson_row)
		lesson_row_formated = []
		for num in 1..7 do
			case num
			when 2,3
				# 科目コードと科目名の整形
				lesson_row_formated << lesson_row.css("td:nth-child(#{num})").text.gsub(/(\r\n|\r|\n)/, "").strip!
			when 5
				# 学期・曜日・時限・教室の整形
				lesson_row_formated << lesson_koma_format(lesson_row.css("td:nth-child(#{num})").text.gsub(/(\r\n|\r|\n)/, ""))
			else
				lesson_row_formated << lesson_row.css("td:nth-child(#{num})").text.gsub(/(\r\n|\r|\n)/, "")
			end
		end

		lesson_row_formated.flatten!
	end

	def lesson_koma_format(data)

		# 学期・曜日・時限・教室を整形する。
		koma = []
		splited = data.split("・")
		splited.each_with_index do |s, i|
			case i
			when 0
				# 学期を数に変換
				s_formted = s.sub(/春.*/, "1").sub(/秋.*/,"2").sub(/通年/,"3")
				koma << s_formted
			when 1
				# 曜日を数に変換
				days = {'月'=>'1', '火'=>'2', '水'=>'3', '木'=>'4', '金'=>'5', '土'=>'6', '日'=>'7'}
				s_formted = s.gsub(/#{days.keys.join('|')}/, days)
				koma << s_formted
			else
				s.split.each {|x| koma << x.tr("０-９", "0-9")}
			end
		end
		koma
	end

end

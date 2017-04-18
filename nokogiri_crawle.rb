gem 'nokogiri'

class NokogiriCrawle
	def initialize(html)
		# htmlをパースしてオブジェクトを生成
		@doc = Nokogiri::HTML.parse(html)
	end

	def get_list
		# 授業名のリストを取得
		@doc.css('.list a').each do |lesson_name|
			p lesson_name.inner_html
		end
	end
end

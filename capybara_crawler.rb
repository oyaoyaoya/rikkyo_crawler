gem 'poltergeist'
gem 'capybara'

require 'capybara/poltergeist'

class CapybaraCrawler

	def initialize()
		Capybara.register_driver :poltergeist do |app|
			Capybara::Poltergeist::Driver.new(app, {:js_errors => false, :timeout => 5000 })
		end
		@session = Capybara::Session.new(:poltergeist)
		@session.driver.headers = {
			'User-Agent' => "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_11_3) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/49.0.2564.97 Safari/537.36"
		}

		@links = []
	end

	# 一覧画面のURLを生成
	def set_parent_url
		target_url = "https://sy.rikkyo.ac.jp/timetable/slbsscmr.do?value(nendo)=2017&value(setti)=1"
	end

	# target_urlへアクセス
	# 引数にurlを渡せばアクセスする
	def access_to_target(target_url)
		@session.visit target_url
	end

	# parent_urlで各学科一覧ページへのURLの配列を作成する
	def make_links_list_for_department
		for i in 0..(@session.all('#main tr:nth-child(1) div a').length-1)
			@links << @session.all('#main tr:nth-child(1) div a')[i][:href]
		end
		@links
	end

	def return_html
		# スクリーンショットを取得
		# 必須ではない。デバック用。
		# @session.save_screenshot('screen_shot.png')

		# visit中のhtmlを返す
		html = @session.html
	end

end

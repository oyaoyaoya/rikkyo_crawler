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
		@target_url = ""

	end

	# 一覧画面のURLを生成
	def set_target_url
		@target_url = "https://sy.rikkyo.ac.jp/timetable/slbsnkhy.do?value(nendo)=2017&value(setti)=1&value(gakubu)=100&value(crclm)=X00003&buttonName=showJknwrNkhy"

		@target_url
	end

	# 一覧画面へアクセス
	def access_to_target
		@session.visit @target_url
	end

	def move_to_koma_page
		@session.find('tr:nth-child(2) th+ td span').click
	end

	def return_html
		html = @session.html
	end

end

gem 'nokogiri'
gem 'poltergeist'
gem 'capybara'

require 'capybara/poltergeist'

Capybara.register_driver :poltergeist do |app|
  Capybara::Poltergeist::Driver.new(app, {:js_errors => false, :timeout => 5000 })
end

session = Capybara::Session.new(:poltergeist)

session.driver.headers = {
    'User-Agent' => "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_11_3) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/49.0.2564.97 Safari/537.36"
}

# 学科のコマ一覧画面
# session.visit ""
session.visit "https://sy.rikkyo.ac.jp/timetable/slbsnkhy.do?value(nendo)=2017&value(setti)=1&value(gakubu)=100&value(crclm)=X00003&buttonName=showJknwrNkhy"

# 一覧画面からクリック
session.find('tr:nth-child(2) th+ td span').click

# スクリーンショットを生成
session.save_screenshot('screen_shot.png')

# sessionからhtmlを取得
html = session.html

# htmlをパースしてオブジェクトを生成
doc = Nokogiri::HTML.parse(html)
# HTMLの取得
# inner_html = doc.inner_html

doc.css('.list a').each do |lesson_name|
	p lesson_name.inner_html
end

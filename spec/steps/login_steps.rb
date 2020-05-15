# encoding: utf-8

step 'ログインページを表示する' do
  visit 'http://localhost:3000/'
end

step '管理者ユーザーが存在する' do
  data = {
    name: 'admin',
    id: 1,
    password: 'password',
    administrator: true
  }

  create(:user, data)
end

step '一般ユーザーが存在する' do
  data = {
    name: 'general',
    id: 2,
    password: 'password',
    administrator: false
  }

  create(:user, data)
end

step '次の値を入力する' do |table|
  table.hashes.each do |hash|
    begin
      fill_in(hash['key'], with: hash['value'])
    rescue Capybara::ElementNotFound
      select(hash['value'], from: hash['key'])
    end
  end

end

step ':buttonをクリックする' do |button|
  begin
    click_button(button, match: :first)
  rescue Capybara::ElementNotFound
    click_link(button, match: :first)
  end
end

step '管理TOPページが表示されていること' do
  expect(page).to have_content 'Home'
end

step 'アプリTOPページが表示されていること' do
  expect(page).to have_title 'トップ | e-learning'
end

step 'ログインエラーが表示されていること' do
  expect(page).to have_content 'ユーザー名とパスワードが一致しません'
end

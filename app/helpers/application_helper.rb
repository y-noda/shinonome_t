module ApplicationHelper

  # ページタイトルを表示
  def page_title
    title = "e-learning"
    title = @page_title + " | " + title if @page_title
    title
  end

  # 選択中のサイドメニューのクラスを返す
  def sidebar_activate(sidebar_link_url)
    current_url = request.headers['PATH_INFO']
    if current_url.match(sidebar_link_url)
      ' class="active"'
    else
      ''
    end
  end

  # サイドメニューの項目を出力する
  def sidebar_list_items
    items = [
      { text: 'CSVエクスポート', path: admin_csv_export_index_path },
      { text: '講座一覧', path: admin_categories_path },
    ]

    html = ''
    items.each do |item|
      text = item[:text]
      path = item[:path]
      html = html + %Q(<li#{sidebar_activate(path)}><a href="#{path}">#{text}</a></li>)
    end

    raw(html)
  end

  def shallow_args(parent, child)
    child.try(:new_record?) ? [parent, child] : [child]
  end
end

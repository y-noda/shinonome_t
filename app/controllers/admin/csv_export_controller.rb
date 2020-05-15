class Admin::CsvExportController < Admin::Base
  def index
  end

  def progress_checksheet
    respond_to do |format|
      format.csv do
        filename = '進捗-チェックシート回答.csv'
        filename = ERB::Util.url_encode(filename) if msie?
        headers['Content-Disposition'] = "attachment; filename=\"#{filename}\""
      end
    end
  end

  def questionnaire
    respond_to do |format|
      format.csv do
        filename = 'アンケート回答.csv'
        filename = ERB::Util.url_encode(filename) if msie?
        headers['Content-Disposition'] = "attachment; filename=\"#{filename}\""
      end
    end
  end

  private
  def msie?
    request.user_agent =~ /MSIE|[Tt]rident|Edge/
  end
end

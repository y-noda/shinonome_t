class TopController < ApplicationController
  def index; end
  def textlist; end
  def text; end
  def questionnaire; end

  def elearning_manual
    filepath = Rails.root.join('app', 'assets', 'pdfs', 'elearning_manual.pdf')
    stat = File::stat(filepath)
    send_file(filepath, :filename => 'elearning_manual.pdf', :length => stat.size)
  end
end

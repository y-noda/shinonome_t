class ChangeColumnToChecksheetAnswer < ActiveRecord::Migration
  def change
    add_column :checksheet_answers, :answer, :json
    remove_reference :checksheet_answers, :checksheet
    add_reference :checksheet_answers, :video, index: true
  end
end

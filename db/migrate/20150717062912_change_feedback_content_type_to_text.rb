class ChangeFeedbackContentTypeToText < ActiveRecord::Migration
  def change
    change_table :feedbacks do |t|
      t.change :content, :text
    end
  end
end

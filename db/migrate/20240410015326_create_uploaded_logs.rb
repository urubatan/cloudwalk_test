class CreateUploadedLogs < ActiveRecord::Migration[7.1]
  def change
    create_table :uploaded_logs do |t|

      t.timestamps
    end
  end
end

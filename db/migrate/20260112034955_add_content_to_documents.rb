class AddContentToDocuments < ActiveRecord::Migration[8.1]
  def change
    add_column :documents, :content, :text
  end
end

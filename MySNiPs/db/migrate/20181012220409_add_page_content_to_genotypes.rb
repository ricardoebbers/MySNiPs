class AddPageContentToGenotypes < ActiveRecord::Migration[5.2]
  def change
    add_column :genotypes, :page_content, :text
  end
end

class FixCommentsSoContentNotInteger < ActiveRecord::Migration[5.0]
  def change
    remove_column :comments, :content, :integer
    add_column :comments, :content, :string
  end
end

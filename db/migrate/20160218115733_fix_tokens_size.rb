class FixTokensSize < ActiveRecord::Migration
  def change
    # each token has 128 chars; then, 10 tokens = 1280
    change_column :usuarios, :tokens, :string, :limit => 1280
  end
end

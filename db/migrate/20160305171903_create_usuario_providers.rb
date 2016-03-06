class CreateUsuarioProviders < ActiveRecord::Migration
  def change
    create_table :usuario_providers do |t|
      t.references :usuario, index: true
      t.string :provider
      t.string :uid
      t.string :token
      t.string :expires_at

      t.timestamps null: false
    end
  end
end

class AddCountryRefToEstados < ActiveRecord::Migration
  def change
    add_reference :estados, :country, index: true
  end
end

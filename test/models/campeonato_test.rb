require 'test_helper'

class CampeonatoTest < ActiveSupport::TestCase

test "Campeontao validate" do
	c = Campeonato.new
	assert c.valid? , "Campeontao nao valido"
end
  # test "the truth" do
  #   assert true
  # end
end

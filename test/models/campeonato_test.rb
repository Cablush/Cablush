require 'test_helper'

class CampeonatoTest < ActiveSupport::TestCase
  def setup
    @champ = campeonatos(:champ)
  end

  test 'Campeontao validate' do
    c = Campeonato.new
    assert c.valid?, 'Campeontao nao valido'
  end

  test 'Campeonato field is not empty' do
  end
end

require 'test_helper'

class Campeonato::ParticipanteTest < ActiveSupport::TestCase
  test 'Create Valid Participante' do
    p = participantes(:one)
    assert p.valid?
  end

  # test "the truth" do
  #   assert true
  # end
end

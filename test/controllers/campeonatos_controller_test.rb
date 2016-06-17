require 'test_helper'

class CampeonatosControllerTest < ActionController::TestCase

  def setup
   		 @campeonato = campeonatos(:mock)
  	end


  	#method test create account sucess
	test "successful create" do
		post :create, :campeonato => {   :nome => 'Campeonato de Skate' , :descricao => "campeonato de skate" ,
			:data_inicio => Date.new , :data_fim => Date.new , :hora => Time.new  }
    	assert_redirected_to campeonatos_path
	end

	#method test create account sucess
	test "successful create participante" do
		participante = participantes(:one)
		post :save_participante, participante: participante
    	assert_redirected_to cadastros_campeonatos_path
	end

	


    #method test get account and show balance
	
	# test "successful getshow" do
	# 	get :balance
	# end

	# #method test withdrawing value 
	# test "successful withdrawing" do
	# 	post :withdrawingValue, :cents =>  50 , :value => 2 , :password => "22"
	#     assert_redirected_to '/withdrawing'
	#     assert_equal "A operação de saque foi realizada com sucesso!", flash[:success]
	# end

	# #method test withdrawing value > balance account
	# test "failed withdrawing balance account lower than value" do
	# 	post :withdrawingValue, :cents =>  50 , :value => 50 , :password => "22"
	#     assert_redirected_to '/withdrawing'
	#     assert_equal "Não existe saldo suficiente para concluir a operação de saque.", flash[:warning]
	# end

end

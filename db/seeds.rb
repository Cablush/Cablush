# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

     bh = Cidade.create(nome: "Belo Horizonte")
     novaLima = Cidade.create(nome: "Nova Lima")
     vespasiano = Cidade.create(nome: "Vespasiano")
     sp = Cidade.create(nome:"São Paulo")
     itabirito = Cidade.create(nome:"Itabirito")
     
    Estado.create(rg: "AC", nome: "Acre", logo: " ")
    Estado.create(rg: "AL", nome: "Alagoas", logo: " ")
    Estado.create(rg: "AP", nome: "Amapa", logo: " ")
    Estado.create(rg: "AM", nome: "Amazonas", logo: " ")
    Estado.create(rg: "BA", nome: "Bahia", logo: " ")
    Estado.create(rg: "CE", nome: "Ceara", logo: " ")
    Estado.create(rg: "DF", nome: "Distrito Federal", logo: " ")
    Estado.create(rg: "ES", nome: "Espirito Santo", logo: " ")
    Estado.create(rg: "GO", nome: "Goias", logo: " ")
    Estado.create(rg: "MA", nome: "Maranhao", logo: " ")
    Estado.create(rg: "MT", nome: "Mato Grosso", logo: " ")
    Estado.create(rg: "MS", nome: "Mato Grosso do Sul", logo: " ")
    Estado.create(rg: "PA", nome: "Para", logo: " ")
    Estado.create(rg: "PB", nome: "Paraiba", logo: " ")
    Estado.create(rg: "PR", nome: "Parana", logo: " ")
    Estado.create(rg: "PE", nome: "Pernambuco", logo: " ")
    Estado.create(rg: "PI", nome: "Piaui", logo: " ")
    Estado.create(rg: "RJ", nome: "Rio de Janeiro", logo: " ")
    Estado.create(rg: "RN", nome: "Rio Grande do Norte", logo: " ")
    Estado.create(rg: "RS", nome: "Rio Grande do Sul", logo: " ")
    Estado.create(rg: "RR", nome: "Roraima", logo: " ")
    Estado.create(rg: "RO", nome: "Rondonia", logo: " ")
    Estado.create(rg: "SC", nome: "Santa Catarina", logo: " ")
    Estado.create(rg: "SE", nome: "Sergipe", logo: " ")
    Estado.create(rg: "TO", nome: "Tocantins", logo: " ")
    
    mg = Estado.create(rg: "MG", nome: "Minas Gerais", logo: " ",cidade: [bh,novaLima,vespasiano,itabirito])
    spEstado = Estado.create(rg: "SP", nome: "Sao Paulo", logo: " ",cidade:[sp])
    
    #Esporte
    skate = Esporte.create(nome: "Skate", modalidade: [Modalidade.create(nome: "Street"), Modalidade.create(nome: "Longboard")])
    patins = Esporte.create(nome: "Patins")
    bike = Esporte.create(nome: "Bike", modalidade: [Modalidade.create(nome: "Street"), Modalidade.create(nome: "BMX"),Modalidade.create(nome: "Downhill")])
    futebol = Esporte.create(nome: "Futebol", modalidade: [Modalidade.create(nome: "Salao"), Modalidade.create(nome: "Campo"),Modalidade.create(nome: "Society"),Modalidade.create(nome: "Areia")])
    volei = Esporte.create(nome: "Volei", modalidade: [Modalidade.create(nome: "Praia"), Modalidade.create(nome: "Quadra")])
    #Fim do Esporte
    
    #Modalidade
    #longboard = Modalidade.create(nome:"Longboard", esporte:skate)
    #street = Modalidade.create(nome:"Street", esporte:skate)
    
    #montainBike = Modalidade.create(nome:"Mountain", esporte:bike)
    #bmx = Modalidade.create(nome:"BMX", esporte:bike)
    
    #voleiDePraia = Modalidade.create(nome:"Praia", esporte:volei)
    #voleiDeQuadra = Modalidade.create(nome:"Quadra", esporte:volei)
    
    #futebolDeSalao = Modalidade.create(nome:"Salão", esporte:futebol)
    #futebolDeSociet = Modalidade.create(nome:"Society", esporte:futebol)
    #futebolDeCampo = Modalidade.create(nome:"Campo", esporte:futebol)
    #Fim de Modalidade
    
    
    #Local 
    apac = Local.create( latitude:-20.040428, longitude:-43.838011, logradouro:"MG-030 - Nova Lima, MG", cidade:vespasiano, estado:mg)
    sereno = Local.create( latitude:-19.984420, longitude:-43.940511, logradouro:"R. Jacarandá, 353 - Vale do Sereno, MG, 34000-000", cidade:novaLima, estado:mg)
    belvis = Local.create( latitude:-19.967716, longitude:-43.940511, logradouro:"Av. Célso Porfírio Machado, 1072 - Belvedere, 30320-400", cidade:bh,estado:mg)
    alfa = Local.create( latitude:-20.185716, longitude:-43.948614, logradouro:"Av. Wimbledon, Nova Lima - MG, 34000-000", cidade:novaLima,estado:mg)
    tubarina = Local.create( latitude:-20.252336, longitude:-43.926573, logradouro:"Itabirito, proximo à Herculano Mineração, 35450-000", cidade:itabirito,estado:mg)
    vinteSeteVoltas = Local.create( latitude:-19.984420, longitude:-43.940511, logradouro:"R. Jacarandá, 353 - Vale do Sereno, MG, 34000-000", cidade:novaLima, estado:mg)
    #, 
    #Fim do Local
    
    #Pistas
    Pista.create(nome:"Drop da Apac", local:apac,descricao: "Proximo de rio acima", esporte:skate )
    Pista.create(nome:"Drop do Sereno", local:sereno ,descricao: "Proximo do Serena Mall", esporte:skate )
    Pista.create(nome:"Drop do Belveder", local:belvis ,descricao: "Proximo da igreja nossa senhora rainha", esporte:skate  )
    Pista.create(nome:"Drop da Tubarina", local:tubarina,descricao: "Proximo da Herculano Mineração em itabirito", esporte:skate  )
    Pista.create(nome:"Drop do Alfa", local:tubarina,descricao: "Proximo da Herculano Mineração em itabirito", esporte:skate  )
     
    # Pista.create(nome:"Drop da Real", local:apac,descricao: "Proximo de rio acima", modalidade:longboard  )
    # Pista.create(nome:"Drop da Bartô", local:apac,descricao: "Proximo de rio acima", modalidade:longboard  )
    # Pista.create(nome:"Pico do Asilo", local:apac,descricao: "Proximo de rio acima", modalidade:longboard  )
    
    
    #Pista.create(nome:"Trilha das 27 Voltas", local:vinteSeteVoltas, descricao: "Proximo da Herculano Mineração em itabirito",esporte:bike  )
    #Fim das Pistas
    
    #Lojas
    Loja.create(nome:"Drop SkateShop",fundo: true ,contato: "031 9991-0420", horario:"09:00--18:00", esporte: skate , descricao: "A DROP foi fundada em Janeiro de 2013 por skatistas profissionais, que enxergaram uma certa dificuldade das pessoas" +
 "em adquirirem peças de qualidade a preços acessíveis. ", site: "http://www.dropskateshop.com/",logo:"http://www.dropskateshop.com/front/images/logo.png", local: Local.create(latitude:-19.964037, longitude:-43.944982, logradouro:"Rua Arrudas 542, Santa Lúcia - BH",cidade:bh,estado:mg))

   Loja.create(nome:"Hawkshop", contato: "031 7588-7142" , horario:"09:00--18:00",esporte: skate , descricao: "A Hawkshop é uma loja virtual especializada em skate downhill.<br/>Criada em Belo Horizonte com o intuito de fornecer as melhores peças do mercado para todo Brasil.<br/>Nossa meta é crescer o esporte em nosso país e oferecer os melhores produtos para os atletas.", site: "https://hawkshop.com.br/",logo:"lojas_logos/hawkshop.png", local: Local.create(latitude:-19.968706, longitude:-43.945610, logradouro:"Avenida Terra, Santa Lúcia - BH",cidade:bh,estado:mg))
   
   Loja.create(nome:"Blunt",contato: "031 3284-2161" , horario:"09:00--18:00",esporte: skate , descricao: "A Blunt skate park esta a 12 (doze) anos no mercado mineiro, com Skate park coberta,com área de Street e banks, skateshop com as melhores marcas nacionais e importadas,lanchonete e estacionamento próprio  ",esporte: skate , site: "https://blunt.com.br/",logo:"lojas_logos/blunt.png", local:  Local.create(latitude:-19.943580, longitude:-43.933578, logradouro:"Rua Montes Claros, 189, Carmo - BH ",cidade:bh,estado:mg))
 
   Loja.create(nome:"Roll-Laden",contato: "011 99500-2415" , horario:"11:00--17:00", descricao: "Somos uma loja virtual, especializada em Longboard, Downhill, Slalom, Freeride Skateboards. Além de vender o que existe de melhor no mercado mundial nós também andamos de skate e competimos na modalidade Downhill Skate.", site: "https://www.roll-laden.net/",logo:"lojas_logos/rollladen.png")
   
   Loja.create(nome:"EverBag Skate Longboard Shop",contato: "011 7734.0821" , horario:"09:00--18:00", descricao: "EverBag Skate Longboard Shop ", site: "http://www.everbag.com.br/",logo:"lojas_logos/everbag.png",esporte: skate , local:  Local.create(latitude:-23.478586, longitude:-46.607053, logradouro:"Av. Mazzei, 140 - Vila Mazzei São Paulo - SP Brasil",cidade:sp,estado:spEstado))
   
   Loja.create(nome:"BhInline",contato: "031 4141-4477" , horario:"09:00--18:00", descricao: "A BH INLINE é loja de artigos esportivos criada com intuito de facilitar o acesso dos atletas aos equipamentos que seguem em nossa linha de produtos. Trabalhamos com as melhores marcas de equipamentos esportivos do mercado.É uma empresa administrada por atletas praticantes de esportes radicais e esta localizada em Belo Horizonte - Minas Gerais. ", site: "http://www.bhinline.com.br",logo:"",esporte: patins , local:  Local.create(latitude:-19.936890, longitude:-43.935425, logradouro:"Rua: Pernambuco, numero 1070, loja 125 galeria Savassi Point",cidade:bh,estado:mg))
   
   
   
   #end Lojas
 


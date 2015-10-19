# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

# Estados - begin
estado_ac = Estado.create(rg: "AC", nome: "Acre")
estado_al = Estado.create(rg: "AL", nome: "Alagoas")
estado_ap = Estado.create(rg: "AP", nome: "Amapa")
estado_am = Estado.create(rg: "AM", nome: "Amazonas")
estado_ba = Estado.create(rg: "BA", nome: "Bahia")
estado_ce = Estado.create(rg: "CE", nome: "Ceara")
estado_df = Estado.create(rg: "DF", nome: "Distrito Federal")
estado_es = Estado.create(rg: "ES", nome: "Espírito Santo")
estado_go = Estado.create(rg: "GO", nome: "Goias")
estado_ma = Estado.create(rg: "MA", nome: "Maranhão")
estado_mg = Estado.create(rg: "MG", nome: "Minas Gerais")
estado_mt = Estado.create(rg: "MT", nome: "Mato Grosso")
estado_ms = Estado.create(rg: "MS", nome: "Mato Grosso do Sul")
estado_pa = Estado.create(rg: "PA", nome: "Pará")
estado_pb = Estado.create(rg: "PB", nome: "Paraíba")
estado_pr = Estado.create(rg: "PR", nome: "Paraná")
estado_pe = Estado.create(rg: "PE", nome: "Pernambuco")
estado_pi = Estado.create(rg: "PI", nome: "Piauí")
estado_rj = Estado.create(rg: "RJ", nome: "Rio de Janeiro")
estado_rn = Estado.create(rg: "RN", nome: "Rio Grande do Norte")
estado_rs = Estado.create(rg: "RS", nome: "Rio Grande do Sul")
estado_rr = Estado.create(rg: "RR", nome: "Roraima")
estado_ro = Estado.create(rg: "RO", nome: "Rondônia")
estado_sc = Estado.create(rg: "SC", nome: "Santa Catarina")
estado_se = Estado.create(rg: "SE", nome: "Sergipe")
estado_sp = Estado.create(rg: "SP", nome: "São Paulo")
estado_to = Estado.create(rg: "TO", nome: "Tocantins")
# Estados - end

# Cidades - begin
Cidade.create(nome: "Belo Horizonte", estado:  estado_mg)
Cidade.create(nome: "Nova Lima", estado:  estado_mg)
Cidade.create(nome: "Vespasiano", estado:  estado_mg)
Cidade.create(nome: "São Paulo", estado:  estado_sp)
Cidade.create(nome: "Rio de Janeiro", estado:  estado_rj)
Cidade.create(nome: "Vitória", estado:  estado_es)
Cidade.create(nome: "Curitiba", estado:  estado_pr)
Cidade.create(nome: "Florianópolis", estado:  estado_sc)
Cidade.create(nome: "Porto Alegre", estado:  estado_rs)
# Cidades - end

# Esportes - begin
Esporte.create(nome: "Street", categoria: "Skate")
Esporte.create(nome: "Longboard", categoria: "Skate")
Esporte.create(nome: "Street", categoria: "Patins")
Esporte.create(nome: "BMX", categoria: "Bike")
Esporte.create(nome: "Drift Trike", categoria: "Bike")
# Esportes - end
    
#Local 
#apac = Local.create( latitude:-20.040428, longitude:-43.838011, logradouro:"MG-030 - Nova Lima, MG", cidade:vespasiano, estado:mg)
#sereno = Local.create( latitude:-19.984420, longitude:-43.940511, logradouro:"R. Jacarandá, 353 - Vale do Sereno, MG, 34000-000", cidade:novaLima, estado:mg)
#belvis = Local.create( latitude:-19.967716, longitude:-43.940511, logradouro:"Av. Célso Porfírio Machado, 1072 - Belvedere, 30320-400", cidade:bh,estado:mg)
#alfa = Local.create( latitude:-20.185716, longitude:-43.948614, logradouro:"Av. Wimbledon, Nova Lima - MG, 34000-000", cidade:novaLima,estado:mg)
#tubarina = Local.create( latitude:-20.252336, longitude:-43.926573, logradouro:"Itabirito, proximo à Herculano Mineração, 35450-000", cidade:itabirito,estado:mg)
#vinteSeteVoltas = Local.create( latitude:-19.984420, longitude:-43.940511, logradouro:"R. Jacarandá, 353 - Vale do Sereno, MG, 34000-000", cidade:novaLima, estado:mg)
#, 
#Fim do Local
    
#Pistas
#Pista.create(nome:"Drop da Apac", local:apac,descricao: "Proximo de rio acima", esporte:skate )
#Pista.create(nome:"Drop do Sereno", local:sereno ,descricao: "Proximo do Serena Mall", esporte:skate )
#Pista.create(nome:"Drop do Belveder", local:belvis ,descricao: "Proximo da igreja nossa senhora rainha", esporte:skate  )
#Pista.create(nome:"Drop da Tubarina", local:tubarina,descricao: "Proximo da Herculano Mineração em itabirito", esporte:skate  )
#Pista.create(nome:"Drop do Alfa", local:tubarina,descricao: "Proximo da Herculano Mineração em itabirito", esporte:skate  )
     
# Pista.create(nome:"Drop da Real", local:apac,descricao: "Proximo de rio acima", modalidade:longboard  )
# Pista.create(nome:"Drop da Bartô", local:apac,descricao: "Proximo de rio acima", modalidade:longboard  )
# Pista.create(nome:"Pico do Asilo", local:apac,descricao: "Proximo de rio acima", modalidade:longboard  )
    
    
#Pista.create(nome:"Trilha das 27 Voltas", local:vinteSeteVoltas, descricao: "Proximo da Herculano Mineração em itabirito",esporte:bike  )
#Fim das Pistas
    
#Lojas
#    Loja.create(nome:"Drop SkateShop",fundo: true ,contato: "031 9991-0420", horario:"09:00--18:00", esporte: skate , descricao: "A DROP foi fundada em Janeiro de 2013 por skatistas profissionais, que enxergaram uma certa dificuldade das pessoas" +
# "em adquirirem peças de qualidade a preços acessíveis. ", site: "http://www.dropskateshop.com/",logo:"http://www.dropskateshop.com/front/images/logo.png", local: Local.create(latitude:-19.964037, longitude:-43.944982, logradouro:"Rua Arrudas 542, Santa Lúcia - BH",cidade:bh,estado:mg))

#   Loja.create(nome:"Hawkshop", contato: "031 7588-7142" , horario:"09:00--18:00",esporte: skate , descricao: "A Hawkshop é uma loja virtual especializada em skate downhill.<br/>Criada em Belo Horizonte com o intuito de fornecer as melhores peças do mercado para todo Brasil.<br/>Nossa meta é crescer o esporte em nosso país e oferecer os melhores produtos para os atletas.", site: "https://hawkshop.com.br/",logo:"lojas_logos/hawkshop.png", local: Local.create(latitude:-19.968706, longitude:-43.945610, logradouro:"Avenida Terra, Santa Lúcia - BH",cidade:bh,estado:mg))
   
#   Loja.create(nome:"Blunt",contato: "031 3284-2161" , horario:"09:00--18:00",esporte: skate , descricao: "A Blunt skate park esta a 12 (doze) anos no mercado mineiro, com Skate park coberta,com área de Street e banks, skateshop com as melhores marcas nacionais e importadas,lanchonete e estacionamento próprio  ",esporte: skate , site: "https://blunt.com.br/",logo:"lojas_logos/blunt.png", local:  Local.create(latitude:-19.943580, longitude:-43.933578, logradouro:"Rua Montes Claros, 189, Carmo - BH ",cidade:bh,estado:mg))
 
#   Loja.create(nome:"Roll-Laden",contato: "011 99500-2415" , horario:"11:00--17:00", descricao: "Somos uma loja virtual, especializada em Longboard, Downhill, Slalom, Freeride Skateboards. Além de vender o que existe de melhor no mercado mundial nós também andamos de skate e competimos na modalidade Downhill Skate.", site: "https://www.roll-laden.net/",logo:"lojas_logos/rollladen.png")
   
#   Loja.create(nome:"EverBag Skate Longboard Shop",contato: "011 7734.0821" , horario:"09:00--18:00", descricao: "EverBag Skate Longboard Shop ", site: "http://www.everbag.com.br/",logo:"lojas_logos/everbag.png",esporte: skate , local:  Local.create(latitude:-23.478586, longitude:-46.607053, logradouro:"Av. Mazzei, 140 - Vila Mazzei São Paulo - SP Brasil",cidade:sp,estado:spEstado))
   
#   Loja.create(nome:"BhInline",contato: "031 4141-4477" , horario:"09:00--18:00", descricao: "A BH INLINE é loja de artigos esportivos criada com intuito de facilitar o acesso dos atletas aos equipamentos que seguem em nossa linha de produtos. Trabalhamos com as melhores marcas de equipamentos esportivos do mercado.É uma empresa administrada por atletas praticantes de esportes radicais e esta localizada em Belo Horizonte - Minas Gerais. ", site: "http://www.bhinline.com.br",logo:"",esporte: patins , local:  Local.create(latitude:-19.936890, longitude:-43.935425, logradouro:"Rua: Pernambuco, numero 1070, loja 125 galeria Savassi Point",cidade:bh,estado:mg))
   
#end Lojas
 
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
Esporte.create(nome: "Street", categoria: "skate")
Esporte.create(nome: "Longboard", categoria: "skate")
Esporte.create(nome: "Street", categoria: "patins")
Esporte.create(nome: "BMX", categoria: "bike")
Esporte.create(nome: "Drift Trike", categoria: "bike")
# Esportes - end


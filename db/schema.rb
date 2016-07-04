# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20160703222645) do

  create_table "amizades", force: :cascade do |t|
    t.integer  "usuario_id"
    t.integer  "amigo_id"
    t.boolean  "aprovado"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "amizades", ["amigo_id"], name: "index_amizades_on_amigo_id"
  add_index "amizades", ["usuario_id"], name: "index_amizades_on_usuario_id"

  create_table "campeonatos", force: :cascade do |t|
    t.string   "nome"
    t.date     "data_inicio"
    t.date     "data_fim"
    t.time     "hora"
    t.string   "descricao"
    t.integer  "responsavel_id"
    t.datetime "created_at",                                 null: false
    t.datetime "updated_at",                                 null: false
    t.string   "uuid",                                       null: false
    t.integer  "max_competidores_categoria"
    t.integer  "min_competidores_categoria"
    t.integer  "max_competidores_prova"
    t.integer  "min_competidores_prova"
    t.integer  "num_vencedores_prova"
    t.string   "flyer_file_name"
    t.string   "flyer_content_type"
    t.integer  "flyer_file_size"
    t.datetime "flyer_updated_at"
    t.boolean  "fundo",                      default: false
  end

  create_table "campeonatos_esportes", id: false, force: :cascade do |t|
    t.integer "campeonato_id", null: false
    t.integer "esporte_id",    null: false
  end

  create_table "categorias", force: :cascade do |t|
    t.integer  "campeonato_id"
    t.string   "nome"
    t.string   "descricao"
    t.string   "regras"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
    t.string   "uuid",          null: false
  end

  add_index "categorias", ["campeonato_id"], name: "index_categorias_on_campeonato_id"
  add_index "categorias", ["uuid"], name: "index_categorias_on_uuid", unique: true

  create_table "cidades", force: :cascade do |t|
    t.string   "nome"
    t.integer  "estado_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "cidades", ["estado_id"], name: "index_cidades_on_estado_id"

  create_table "contacts", force: :cascade do |t|
    t.string   "name"
    t.string   "email"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "countries", force: :cascade do |t|
    t.string   "iso",        limit: 2
    t.string   "name"
    t.datetime "created_at",           null: false
    t.datetime "updated_at",           null: false
  end

  create_table "esportes", force: :cascade do |t|
    t.string   "nome"
    t.string   "categoria"
    t.string   "icone"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "esportes_eventos", id: false, force: :cascade do |t|
    t.integer "evento_id",  null: false
    t.integer "esporte_id", null: false
  end

  create_table "esportes_grupos", id: false, force: :cascade do |t|
    t.integer "grupo_id",   null: false
    t.integer "esporte_id", null: false
  end

  create_table "esportes_lojas", id: false, force: :cascade do |t|
    t.integer "loja_id",    null: false
    t.integer "esporte_id", null: false
  end

  create_table "esportes_pistas", id: false, force: :cascade do |t|
    t.integer "pista_id",   null: false
    t.integer "esporte_id", null: false
  end

  create_table "esportes_usuarios", id: false, force: :cascade do |t|
    t.integer "usuario_id", null: false
    t.integer "esporte_id", null: false
  end

  create_table "estados", force: :cascade do |t|
    t.string   "rg",         limit: 2
    t.string   "nome"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "country_id"
  end

  add_index "estados", ["country_id"], name: "index_estados_on_country_id"

  create_table "etapas", force: :cascade do |t|
    t.string   "nome"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
    t.integer  "campeonato_id"
  end

  add_index "etapas", ["campeonato_id"], name: "index_etapas_on_campeonato_id"

  create_table "eventos", force: :cascade do |t|
    t.string   "nome",               limit: 50
    t.string   "descricao",          limit: 500
    t.date     "data"
    t.time     "hora"
    t.string   "website",            limit: 150
    t.string   "facebook",           limit: 150
    t.integer  "responsavel_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "flyer_file_name"
    t.string   "flyer_content_type"
    t.integer  "flyer_file_size"
    t.datetime "flyer_updated_at"
    t.boolean  "fundo",                          default: false
    t.string   "uuid",                                           null: false
    t.date     "data_fim"
  end

  add_index "eventos", ["responsavel_id"], name: "index_eventos_on_responsavel_id"
  add_index "eventos", ["uuid"], name: "index_eventos_on_uuid", unique: true

  create_table "eventos_grupos", id: false, force: :cascade do |t|
    t.integer "grupo_id",  null: false
    t.integer "evento_id", null: false
  end

  create_table "eventos_lojas", id: false, force: :cascade do |t|
    t.integer "loja_id",   null: false
    t.integer "evento_id", null: false
  end

  create_table "grupos", force: :cascade do |t|
    t.string   "nome"
    t.string   "descricao"
    t.string   "logo"
    t.boolean  "fundo",          default: false
    t.integer  "responsavel_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "grupos", ["responsavel_id"], name: "index_grupos_on_responsavel_id"

  create_table "grupos_usuarios", id: false, force: :cascade do |t|
    t.integer "grupo_id",   null: false
    t.integer "usuario_id", null: false
  end

  create_table "horarios", force: :cascade do |t|
    t.time     "inicio"
    t.time     "fim"
    t.integer  "funcionamento_id"
    t.string   "funcionamento_type"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "seg"
    t.boolean  "ter"
    t.boolean  "qua"
    t.boolean  "qui"
    t.boolean  "sex"
    t.boolean  "sab"
    t.boolean  "dom"
    t.string   "detalhes",           limit: 100
  end

  add_index "horarios", ["funcionamento_type", "funcionamento_id"], name: "index_horarios_on_funcionamento_type_and_funcionamento_id"

  create_table "impressions", force: :cascade do |t|
    t.string   "impressionable_type"
    t.integer  "impressionable_id"
    t.integer  "user_id"
    t.string   "controller_name"
    t.string   "action_name"
    t.string   "view_name"
    t.string   "request_hash"
    t.string   "ip_address"
    t.string   "session_hash"
    t.text     "message"
    t.text     "referrer"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "impressions", ["controller_name", "action_name", "ip_address"], name: "controlleraction_ip_index"
  add_index "impressions", ["controller_name", "action_name", "request_hash"], name: "controlleraction_request_index"
  add_index "impressions", ["controller_name", "action_name", "session_hash"], name: "controlleraction_session_index"
  add_index "impressions", ["impressionable_type", "impressionable_id", "ip_address"], name: "poly_ip_index"
  add_index "impressions", ["impressionable_type", "impressionable_id", "request_hash"], name: "poly_request_index"
  add_index "impressions", ["impressionable_type", "impressionable_id", "session_hash"], name: "poly_session_index"
  add_index "impressions", ["impressionable_type", "message", "impressionable_id"], name: "impressionable_type_message_index"
  add_index "impressions", ["user_id"], name: "index_impressions_on_user_id"

  create_table "inscricoes", force: :cascade do |t|
    t.string   "nome"
    t.string   "tipo_documento"
    t.string   "documento"
    t.string   "arquivo_documento"
    t.string   "foto"
    t.string   "email"
    t.integer  "campeonato_id"
    t.integer  "categoria_id"
    t.integer  "numero_inscricao"
    t.string   "tipo_pagamento"
    t.decimal  "valor_pagamento"
    t.datetime "created_at",        null: false
    t.datetime "updated_at",        null: false
  end

  add_index "inscricoes", ["campeonato_id"], name: "index_inscricoes_on_campeonato_id"
  add_index "inscricoes", ["categoria_id"], name: "index_inscricoes_on_categoria_id"

  create_table "locais", force: :cascade do |t|
    t.decimal  "latitude",                     precision: 15, scale: 10, default: 0.0
    t.decimal  "longitude",                    precision: 15, scale: 10, default: 0.0
    t.string   "logradouro",       limit: 100
    t.string   "numero",           limit: 10
    t.string   "complemento",      limit: 25
    t.string   "bairro",           limit: 100
    t.string   "cidade",           limit: 100
    t.string   "estado",           limit: 2
    t.string   "cep",              limit: 10
    t.string   "pais",             limit: 2
    t.integer  "localizavel_id"
    t.string   "localizavel_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "locais", ["localizavel_type", "localizavel_id"], name: "index_locais_on_localizavel_type_and_localizavel_id"

  create_table "lojas", force: :cascade do |t|
    t.string   "nome",              limit: 50
    t.string   "descricao",         limit: 500
    t.string   "telefone",          limit: 20
    t.string   "email",             limit: 50
    t.string   "website",           limit: 150
    t.string   "facebook",          limit: 150
    t.integer  "responsavel_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "logo_file_name"
    t.string   "logo_content_type"
    t.integer  "logo_file_size"
    t.datetime "logo_updated_at"
    t.boolean  "fundo",                         default: false
    t.string   "uuid",                                          null: false
  end

  add_index "lojas", ["responsavel_id"], name: "index_lojas_on_responsavel_id"
  add_index "lojas", ["uuid"], name: "index_lojas_on_uuid", unique: true

  create_table "participantes", force: :cascade do |t|
    t.string   "nome"
    t.string   "uuid"
    t.integer  "usuario_id"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
    t.integer  "numero_inscricao"
    t.integer  "categoria_id"
    t.string   "classificacao"
  end

  add_index "participantes", ["categoria_id"], name: "index_participantes_on_categoria_id"
  add_index "participantes", ["usuario_id"], name: "index_participantes_on_usuario_id"

  create_table "pistas", force: :cascade do |t|
    t.string   "nome",              limit: 50
    t.string   "descricao",         limit: 500
    t.string   "website",           limit: 150
    t.string   "facebook",          limit: 150
    t.integer  "responsavel_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "foto_file_name"
    t.string   "foto_content_type"
    t.integer  "foto_file_size"
    t.datetime "foto_updated_at"
    t.boolean  "fundo",                         default: false
    t.string   "uuid",                                          null: false
    t.string   "video",             limit: 150
  end

  add_index "pistas", ["responsavel_id"], name: "index_pistas_on_responsavel_id"
  add_index "pistas", ["uuid"], name: "index_pistas_on_uuid", unique: true

  create_table "provas", force: :cascade do |t|
    t.integer  "etapa_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "provas", ["etapa_id"], name: "index_provas_on_etapa_id"

  create_table "provas_participantes", force: :cascade do |t|
    t.decimal  "pontuacao"
    t.integer  "participante_id"
    t.integer  "prova_id"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end

  add_index "provas_participantes", ["participante_id"], name: "index_provas_participantes_on_participante_id"
  add_index "provas_participantes", ["prova_id"], name: "index_provas_participantes_on_prova_id"

  create_table "sessions", force: :cascade do |t|
    t.string   "session_id", null: false
    t.text     "data"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "sessions", ["session_id"], name: "index_sessions_on_session_id", unique: true
  add_index "sessions", ["updated_at"], name: "index_sessions_on_updated_at"

  create_table "usuario_providers", force: :cascade do |t|
    t.integer  "usuario_id"
    t.string   "provider"
    t.string   "uid"
    t.string   "token",      limit: 1100
    t.string   "expires_at"
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
  end

  add_index "usuario_providers", ["usuario_id"], name: "index_usuario_providers_on_usuario_id"

  create_table "usuarios", force: :cascade do |t|
    t.integer  "id_social"
    t.string   "nome"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.integer  "failed_attempts",        default: 0,  null: false
    t.string   "unlock_token"
    t.datetime "locked_at"
    t.integer  "role"
    t.string   "uuid",                                null: false
    t.string   "authentication_token"
  end

  add_index "usuarios", ["authentication_token"], name: "index_usuarios_on_authentication_token"
  add_index "usuarios", ["confirmation_token"], name: "index_usuarios_on_confirmation_token", unique: true
  add_index "usuarios", ["email"], name: "index_usuarios_on_email", unique: true
  add_index "usuarios", ["reset_password_token"], name: "index_usuarios_on_reset_password_token", unique: true
  add_index "usuarios", ["unlock_token"], name: "index_usuarios_on_unlock_token", unique: true
  add_index "usuarios", ["uuid"], name: "index_usuarios_on_uuid", unique: true

end

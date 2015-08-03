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

ActiveRecord::Schema.define(version: 20150803003742) do

  create_table "amizades", force: :cascade do |t|
    t.integer  "usuario_id"
    t.integer  "amigo_id"
    t.boolean  "aprovado"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "amizades", ["amigo_id"], name: "index_amizades_on_amigo_id"
  add_index "amizades", ["usuario_id"], name: "index_amizades_on_usuario_id"

  create_table "cidades", force: :cascade do |t|
    t.string   "nome",       limit: 255
    t.integer  "estado_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "cidades", ["estado_id"], name: "index_cidades_on_estado_id"

  create_table "contacts", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.string   "email",      limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "esportes", force: :cascade do |t|
    t.string   "nome",          limit: 255
    t.integer  "modalidade_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "esportes", ["modalidade_id"], name: "index_esportes_on_modalidade_id"

  create_table "estados", force: :cascade do |t|
    t.string   "rg",         limit: 2
    t.string   "nome",       limit: 255
    t.string   "logo",       limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "eventos", force: :cascade do |t|
    t.string   "nome",             limit: 255
    t.string   "logo",             limit: 255
    t.string   "descricao",        limit: 255
    t.boolean  "public",                       default: true
    t.boolean  "patrocinado",                  default: false
    t.time     "hora"
    t.date     "data"
    t.string   "rota",             limit: 255
    t.string   "contato",          limit: 255
    t.string   "facebook",         limit: 255
    t.boolean  "fundo",                        default: false
    t.integer  "local_id"
    t.integer  "esporte_id"
    t.integer  "participantes_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "eventos", ["esporte_id"], name: "index_eventos_on_esporte_id"
  add_index "eventos", ["local_id"], name: "index_eventos_on_local_id"
  add_index "eventos", ["participantes_id"], name: "index_eventos_on_participantes_id"

  create_table "grupos", force: :cascade do |t|
    t.string   "nome",       limit: 255
    t.string   "logo",       limit: 255
    t.string   "esporte",    limit: 255
    t.integer  "eventos_id"
    t.integer  "atletas_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "grupos", ["atletas_id"], name: "index_grupos_on_atletas_id"
  add_index "grupos", ["eventos_id"], name: "index_grupos_on_eventos_id"

  create_table "locals", force: :cascade do |t|
    t.string   "logradouro", limit: 255
    t.decimal  "latitude",               precision: 15, scale: 10, default: 0.0
    t.decimal  "longitude",              precision: 15, scale: 10, default: 0.0
    t.integer  "cidade_id"
    t.integer  "estado_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "locals", ["cidade_id"], name: "index_locals_on_cidade_id"
  add_index "locals", ["estado_id"], name: "index_locals_on_estado_id"

  create_table "lojas", force: :cascade do |t|
    t.string   "nome",        limit: 255
    t.string   "logo",        limit: 255
    t.time     "horario"
    t.text     "descricao"
    t.string   "site",        limit: 255
    t.string   "contato",     limit: 255
    t.string   "email",       limit: 255
    t.string   "facebook",    limit: 255
    t.boolean  "fundo",                   default: false
    t.boolean  "patrocinado",             default: false
    t.boolean  "virtual",                 default: false
    t.integer  "local_id"
    t.integer  "esporte_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "usuario_id"
  end

  add_index "lojas", ["esporte_id"], name: "index_lojas_on_esporte_id"
  add_index "lojas", ["local_id"], name: "index_lojas_on_local_id"
  add_index "lojas", ["usuario_id"], name: "index_lojas_on_usuario_id"

  create_table "modalidades", force: :cascade do |t|
    t.string   "nome",       limit: 255
    t.integer  "esporte_id"
    t.string   "icon",       limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "modalidades", ["esporte_id"], name: "index_modalidades_on_esporte_id"

  create_table "pista", force: :cascade do |t|
    t.string   "nome",       limit: 255
    t.text     "descricao"
    t.string   "horario",    limit: 255
    t.string   "logo",       limit: 255
    t.string   "contato",    limit: 255
    t.boolean  "fundo",                  default: false
    t.boolean  "facebook"
    t.integer  "local_id"
    t.integer  "esporte_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "pista", ["esporte_id"], name: "index_pista_on_esporte_id"
  add_index "pista", ["local_id"], name: "index_pista_on_local_id"

  create_table "usuarios", force: :cascade do |t|
    t.integer  "id_social"
    t.string   "nome",                   limit: 255
    t.integer  "amigos_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "email",                  limit: 255, default: "", null: false
    t.string   "encrypted_password",     limit: 255, default: "", null: false
    t.string   "reset_password_token",   limit: 255
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",                      default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip",     limit: 255
    t.string   "last_sign_in_ip",        limit: 255
    t.integer  "role"
  end

  add_index "usuarios", ["amigos_id"], name: "index_usuarios_on_amigos_id"
  add_index "usuarios", ["email"], name: "index_usuarios_on_email", unique: true
  add_index "usuarios", ["reset_password_token"], name: "index_usuarios_on_reset_password_token", unique: true

end

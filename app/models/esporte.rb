class Esporte < ActiveRecord::Base
  enum categoria: {atletismo: "atletismo", automobilismo: "automobilismo", bike: "bike",
                   moto: "moto", patins: "patins", skate: "skate", outros: "outros"}

  scope :find_like_nome, ->(nome) {
    where('esportes.nome LIKE ?', "#{nome}%") if nome.present?
  }

  scope :find_like_nome_or_categoria, ->(nome) {
    where('esportes.nome LIKE ? or esportes.categoria LIKE ?',
          "#{nome}%", "#{nome}%") if nome.present?
  }

  scope :with_categoria, ->(categoria) {
    where('esportes.categoria = ?', "#{categoria}") if categoria.present?
  }

  def self.save?(nome_esporte, nome_categoria)
    if Esporte.find_by_nome_and_categoria(nome_esporte, nome_categoria).blank?
      Esporte.create(nome: nome_esporte, categoria: nome_categoria)
    end
  end

  def categoria_esporte
    if self.outros?
      nome
    else
      categoria.humanize + ' - ' + nome
    end
  end
end

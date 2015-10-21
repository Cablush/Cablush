class Horario < ActiveRecord::Base
  
  enum dia: {dom: "dom", seg: "seg", ter: "ter", qua: "qua", qui: "qui", sex: "sex", sab: "sab", seg_sex: "seg_sex", sab_dom: "sab_dom", seg_dom: "seg_dom"}
  enum periodo: {todo: "todo", manha: "manha", tarde: "tarde", noite: "noite"}
  
  belongs_to :funcionamento, polymorphic: true
  
end

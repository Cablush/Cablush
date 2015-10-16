class String
  
  def try_append(value = '', spacer = nil)
    new_value = self
    if value.present?
      new_value += spacer if (new_value.present? and spacer.present?)
      new_value += value
    end
    new_value
  end
  
end
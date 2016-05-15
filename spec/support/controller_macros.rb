module ControllerMacros
  def login_admin
    before(:each) do
      @request.env["devise.mapping"] = Devise.mappings[:admin]
      sign_in create(:usuario, :admin) # Using factory girl as an example
    end
  end

  def login_user
    before(:each) do
      @request.env["devise.mapping"] = Devise.mappings[:usuario]
      usuario = create(:usuario)
      usuario.confirm! # or set a confirmed_at inside the factory. Only necessary if you are using the "confirmable" module
      sign_in usuario
    end
  end
end

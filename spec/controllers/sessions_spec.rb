require "rails_helper"
require 'support/controller_macros'

describe SessionController do
  login_admin

  it "should have a current_usuario" do
    # note the fact that you should remove the "validate_session" parameter if this was a scaffold-generated controller
    expect(subject.current_usuario).to_not be_nil
  end

  it "should get index" do
    # Note, rails 3.x scaffolding may add lines like get :index, {}, valid_session
    # the valid_session overrides the devise login. Remove the valid_session from your specs
    get 'index'
    expect(response).to be_truthy
  end
end

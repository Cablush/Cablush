class Api::SessionsController < DeviseTokenAuth::SessionsController
  
  protected
  
  def render_create_success
    render json: @resource.token_validation_response
  end
  
end

class Api::ApiController < ApplicationController
  
  include DeviseTokenAuth::Concerns::SetUserByToken
  
  #before_action :authenticate_usuario!
  
end

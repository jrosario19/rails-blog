class AuthenticationController < ApplicationController
    before_action :authenticate_request, except: :login
    before_action :authenticate_user!, except: :login
    #POST /api/auth/login
    def login
        @user = User.find_by_email(params[:email])
        if @user.valid_password?(params[:password])
            token = jwt_encode(user_id:@user.id)
            render json: {token:token}, status: :ok
        else
            render json: { error: 'Invalid username or password' }
        end
    end
end
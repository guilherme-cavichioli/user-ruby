module V1
  class UsersController < ApplicationController
    before_action :set_user, only: [:show, :destroy]

      def index
          @users = User.all
          render json: @users
      end

      def show
        render json: @user
      end

      def create
          @user = User.new(user_params)
        
          if @user.save
            render json: @user, status: :created
          else
            render json: @user.errors, status: :unprocessable_entity
          end
        
      end

      def destroy
        @user.destroy
        head :no_content
      end
        
        
      private  
        
      def user_params
          params.require(:user).permit(:name, :email, :document)
      end

      def set_user
        @user = User.find_by(id: params[:id])
  
        return render json: { error: 'User not found' }, status: :not_found unless @user
      end

  end
end

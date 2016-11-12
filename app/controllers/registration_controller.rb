class RegistrationController < ApplicationController
  skip_before_action :authenticate_request
  rescue_from ActiveRecord::RecordInvalid, with: :email_taken
  def register
    user = User.create!(email:                  params[:email],
                        name:                   params[:name],
                        password:               params[:password],
                        password_confirmation:  params[:password_confirmation])
    render json: { data: 'User created successfully' }, status: 200
  end

  private

  def email_taken
    render json: { error: 'Email taken already.' }, status: :unprocessable_entity
  end
end

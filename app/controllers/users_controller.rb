class UsersController < ApplicationController
  def me
    render json: {
      'data': {
        'attributes': {
          'email': current_user[:email],
          'name': current_user[:name],
          'joined': current_user[:created_at],
        },
        'id': current_user[:id],
        'type': 'users'
      }
    }, status: 200

  end
end

class Api::V1::Users::Detail < Api::V1::BaseService
  def self.call(params)
    user = find_user(params[:id])
    return build_not_found_response unless user

    response = build_success('Detalle de usuario', Api::V1::Users::Presenter.detail(user))
    { response:, status: response[:status] }
  end

  def self.build_not_found_response
    response = build_error('Usuario no encontrado', nil, 404)
    { response:, status: response[:status] }
  end

  def self.find_user(user_id)
    User.find_by(id: user_id)
  end
end

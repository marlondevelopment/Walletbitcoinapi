class Api::V1::Users::Update < Api::V1::BaseService
  def self.call(user_id, user_params)
    user = find_user(user_id)
    return build_not_found_response unless user

    if update_user(user, user_params)
      build_success_response(user)
    else
      build_error_response(user)
    end
  end

  def self.find_user(user_id)
    User.find_by(id: user_id)
  end

  def self.update_user(user, user_params)
    return false unless user_params.present?

    user.update(user_params)
  end

  def self.build_success_response(user)
    response = build_success('Usuario actualizado', Api::V1::Users::Presenter.list(user))
    { response:, status: response[:status] }
  end

  def self.build_error_response(user)
    response = build_error(user.errors.full_messages)
    { response:, status: response[:status] }
  end

  def self.build_not_found_response
    response = build_error('Usuario no encontrado', nil, 404)
    { response:, status: response[:status] }
  end
end

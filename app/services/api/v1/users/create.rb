class Api::V1::Users::Create < Api::V1::BaseService
  def self.call(params)
    user = User.new(email: params[:user][:email], password_digest: params[:user][:password], balance: params[:user][:balance],
                    first_name: params[:user][:first_name], last_name: params[:user][:last_name], nid: params[:user][:nid])
    response = if user.save
                 build_success('Usuario creado', Api::V1::Users::Presenter.list(user))
               else
                 build_error(user.errors.full_messages)
               end
    { response:, status: response[:status] }
  end
end

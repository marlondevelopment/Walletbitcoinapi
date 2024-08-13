class Api::V1::Users::List < Api::V1::BaseService
  def self.call(params)
    users = User.all.order(created_at: :desc)
    users = paginate(params, users)
    users[:data] = users[:data].map { |user| Api::V1::Users::Presenter.list(user) }
    response = build_success('Lista de usuarios', users)
    { response:, status: response[:status] }
  end
end

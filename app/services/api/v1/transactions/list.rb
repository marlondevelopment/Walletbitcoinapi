class Api::V1::Transactions::List < Api::V1::BaseService
  def self.call(params)
    user = find_user(params[:user_id])
    return build_not_found_response unless user

    transactions = user.transactions
    transactions = paginate(params, transactions)
    transactions[:data] = transactions[:data].map { |transaction| Api::V1::Transactions::Presenter.list(transaction) }
    response = build_success('Lista de transacciones', transactions)
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

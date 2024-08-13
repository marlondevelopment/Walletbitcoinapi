class Api::V1::Transactions::Detail < Api::V1::BaseService
  def self.call(params)
    user = find_user(params[:user_id])
    return build_not_found_response('Usuario no encontrado') unless user

    transaction = find_transaction(params[:id])
    return build_not_found_response('Transacción no encontrada') unless transaction

    response = build_success('Detalle de usuario', Api::V1::Transactions::Presenter.detail(transaction))
    { response:, status: response[:status] }
  end

  def self.build_not_found_response(message)
    response = build_error(message, nil, 404)
    { response:, status: response[:status] }
  end

  def self.find_user(user_id)
    User.find_by(id: user_id)
  end

  def self.find_transaction(transaction_id)
    Transaction.find_by(id: transaction_id)
  end
end

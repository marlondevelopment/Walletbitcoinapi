class Api::V1::Transactions::Create < Api::V1::BaseService
  require 'net/http'
  require 'uri'
  require 'json'
  def self.call(params)
    user = find_user(params[:user_id])
    return build_not_found_response unless user

    btc_price = Api::V1::Transactions::CurrentPrice.call[:response][:data]
    puts "esto trae #{btc_price}"
    return build_error_response('Error al obtener el precio del Bitcoin') unless btc_price

    can_transact, message = can_execute_transaction?(user, params[:amount_sent], btc_price, params[:transaction_type])
    return build_error_response(message) unless can_transact

    process_transaction(user, params, btc_price)
  end

  def self.process_transaction(user, params, btc_price)
    transaction = create_transaction(user, params, btc_price)
    if transaction.persisted?
      update_user_balance(user, transaction.amount_sent, transaction.transaction_type)
      build_success_response(Api::V1::Transactions::Presenter.created(transaction))
    else
      build_error_response(transaction.errors.full_messages.join(', '))
    end
  end

  def self.build_not_found_response
    response = build_error('Usuario no encontrado', nil, 404)
    { response:, status: response[:status] }
  end

  def self.find_user(user_id)
    User.find_by(id: user_id)
  end

  def self.can_execute_transaction?(user, amount_sent, btc_price, type)
    amount_needed = calculate_amount_needed(amount_sent, btc_price, type)
    if user.balance >= amount_needed
      [true, nil]
    else
      [false, 'Saldo insuficiente']
    end
  end

  def self.calculate_amount_needed(amount_sent, btc_price, type)
    type == 'buy' ? amount_sent * btc_price : amount_sent
  end

  def self.create_transaction(user, params, btc_price)
    user.transactions.create(
      amount_sent: params[:amount_sent],
      amount_received: calculate_amount_received(params[:amount_sent], btc_price, params[:transaction_type]),
      currency_sent: params[:currency_sent],
      currency_received: params[:currency_received],
      btc_price_at_transaction: btc_price,
      transaction_type: params[:transaction_type]
    )
  end

  def self.calculate_amount_received(amount_sent, btc_price, type)
    type == 'sell' ? amount_sent * btc_price : amount_sent / btc_price
  end

  def self.update_user_balance(user, amount_sent, type)
    amount_change = type == 'buy' ? -amount_sent : amount_sent
    user.update(balance: user.balance + amount_change)
  end

  def self.build_success_response(transaction)
    response = build_success('Transacción exitosa', transaction)
    { response:, status: response[:status] }
  end

  def self.build_error_response(message)
    response = build_error(message)
    { response:, status: response[:status] }
  end
end

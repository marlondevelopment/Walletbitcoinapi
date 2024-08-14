class Api::V1::TransactionsController < ApplicationController
  def index
    response = Api::V1::Transactions::List.call(params)
    render json: response[:response], status: response[:status]
  end

  def show
    response = Api::V1::Transactions::Detail.call(params)
    render json: response[:response], status: response[:status]
  end

  def create
    response = Api::V1::Transactions::Create.call(params)
    render json: response[:response], status: response[:status]
  end

  def current_price_btc
    response = Api::V1::Transactions::CurrentPrice.call
    render json: response[:response], status: response[:status]
  end

  private

  def transaction_params
    params.require(:transaction).permit(:amount_sent, :amount_received, :currency_sent, :currency_received,
                                        :btc_price_at_transaction, :transaction_type)
  end
end

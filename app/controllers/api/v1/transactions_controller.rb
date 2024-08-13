class Api::V1::TransactionsController < ApplicationController
  before_action :set_user

  def index
    response = Api::V1::Transactions::List.call(params)
    render json: response[:response], status: response[:status]
  end

  def show
    transaction = @user.transactions.find(params[:id])
    render json: transaction, status: :ok
  end

  def create
    transaction = @user.transactions.build(transaction_params)
    if transaction.save
      render json: transaction, status: :created
    else
      render json: transaction.errors, status: :unprocessable_entity
    end
  end

  private

  def set_user
    @user = User.find(params[:user_id])
  end

  def transaction_params
    params.require(:transaction).permit(:amount_sent, :amount_received, :currency_sent, :currency_received,
                                        :btc_price_at_transaction, :transaction_type)
  end
end

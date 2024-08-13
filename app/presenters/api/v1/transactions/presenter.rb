class Api::V1::Transactions::Presenter
  def self.list(transaction)
    base_presenter(transaction)
  end

  def self.detail(transaction)
    base_presenter(transaction)
  end

  def self.base_presenter(transaction)
    {
      id: transaction.id.to_s,
      amount_sent: transaction.amount_sent,
      amount_received: transaction.amount_received,
      currency_sent: transaction.currency_sent,
      currency_received: transaction.currency_received,
      btc_price_at_transaction: transaction.currency_received,
      transaction_type: transaction.transaction_type,
      when: transaction.created_at
    }
  end
end

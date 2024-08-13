class Api::V1::Users::Presenter
  def self.list(user)
    base_presenter(user)
  end

  def self.detail(user)
    base_presenter(user)
  end

  def self.base_presenter(user)
    {
      id: user.id.to_s,
      first_name: user.first_name,
      last_name: user.last_name,
      email: user.email,
      nid: user.nid,
      balance: user.balance
    }
  end
end

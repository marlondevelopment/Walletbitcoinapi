class Api::V1::Validator
  def self.complete_params?(request_params = {}, required_params = [])
    return false if request_params.blank?

    required_params.map(&:to_sym).each do |required_param|
      return false if request_params[required_param].blank?
    end
    true
  end
end

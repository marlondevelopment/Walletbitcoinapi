module Api::V1::Response
  def build_success(message, data)
    { success: true, message:, data:, status: 200 }
  end

  def build_error(message, data = nil, status = 403)
    { success: false, message:, data:, status: }
  end
end

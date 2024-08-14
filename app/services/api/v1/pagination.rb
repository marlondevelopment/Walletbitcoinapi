module Api::V1::Pagination
  def paginate(params, data)
    page = params[:page].present? ? params[:page].to_i : 1
    per_page = params[:per_page].present? ? params[:per_page].to_i : 50
    total = data.count
    total_pages = (total / per_page.to_f).ceil
    data = data.offset((page - 1) * per_page).limit(per_page)
    { data:, total:, total_pages:, page:, per_page: }
  end
end

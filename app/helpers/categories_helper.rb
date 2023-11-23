module CategoriesHelper
  def filter_link(filter_name, filter_text)
    filter_params = params.permit(:sharing, :vegan, :sugar_free, :gluten_free, :finger_food)
    filter_params[filter_name] = !(params[filter_name] == 'true')

    link_to(filter_text, filter_order_category_path(filter_params),
            class: "btn btn-outline-dark px-xl-4 filters #{'active' if params[filter_name] == 'true'}")
  end
end

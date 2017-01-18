module ProductsHelper
  def price_badge(price:, sale: 0.0)
    current_price = sale.zero? ? price : price * 2
    klass = 'label label-warning pull-right'
    klass << ' sale' if !sale.zero?

    content_tag(:span, number_to_currency(current_price), class: klass)
  end
end

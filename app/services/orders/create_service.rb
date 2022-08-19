module Orders
  class CreateService
    TAX = 15.0
    attr_reader :products_params, :order_params, :user, :order

    def initialize(user, params)
      @products_params = params.delete(:products).map { |x| x[1] }
      @order_params = params
      @user = user
      @total_price = 0
    end

    def perform
      @order = user.orders.new(order_params)
      assign_products
      order.assign_attributes(
        status: :pending,
        total_price: @total_price,
        total_taxed_price: @total_price * ((100.0 + TAX) / 100.0)
      )
      order.save
      order
    end

    private

    def assign_products
      products_params.each do |params|
        item = ::Item.find(params[:id])
        order_product = order.products.new(
          product: item, amount: params[:amount], unit_price: item.price, name: item.name
        )
        @total_price += order_product.unit_price * order_product.amount
      end
    end
  end
end

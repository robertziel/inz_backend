class OrdersAPI < Grape::API
  include Grape::Kaminari

  before do
    authenticate!
  end

  resource :orders do
    desc 'Show' do
      headers ApiDescHelper.with_common_headers
    end
    get do
      {
        count: User.count,
        orders: current_user.orders.as_json(only: %i[id total_price total_taxed_price status created_at street zip_code city country phone])
      }
    end

    desc 'Create' do
      headers ApiDescHelper.with_common_headers
    end
    params do
      requires :street, type: String, desc: 'Street'
      requires :zip_code, type: String, desc: 'Zip-code'
      requires :city, type: String, desc: 'City'
      requires :country, type: String, desc: 'Country'
      requires :phone, type: String, desc: 'Phone'
      requires :products, type: Hash
    end
    post do
      order = Orders::CreateService.new(current_user, declared(params)).perform

      if order.persisted?
        status 200
        { success: true }
      else
        response_json = {
          error_messages: order.errors.messages.transform_values { |value| value.join(', ') }
        }
        error!(response_json, 200)
      end
    end
  end
end

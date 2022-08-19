class Order < ApplicationRecord
  belongs_to :user
  has_many :products, class_name: 'Orders::Product'

  PENDING = 'pending'
  COMFIRMED = 'comfirmed'
  COMPLETED = 'completed'
  CANCELLED = 'cancelled'

  state_machine :status, initial: PENDING do
    event :comfirm do
      transition PENDING => COMFIRMED
    end

    event :complete do
      transition COMFIRMED => COMPLETED
    end

    event :cancel do
      transition PENDING => CANCELLED, COMFIRMED => CANCELLED
    end
  end
end

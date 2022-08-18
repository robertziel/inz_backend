require 'spec_helper'

describe Api::ItemSerializer do
  let(:item) { create :item }

  describe '#as_json' do
    subject do
      serialize(item, serializer: described_class)
    end

    it 'serializes item' do
      expect(subject).to match(
        custom_fields: [],
        description: item.description,
        id: item.id,
        price: "#{item.price} $",
        name: item.name
      )
    end
  end
end

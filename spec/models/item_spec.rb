require 'spec_helper'

describe Item, type: :model do
  let(:item) { create :item }

  describe 'associations' do
    it { should belong_to(:category) }
  end

  describe 'callbacks' do
    context '#clean_custom_fields' do
      let!(:custom_field_value_1) { create :custom_field_value, item: item }
      let!(:custom_field_value_2) { create :custom_field_value, item: item }

      before do
        custom_field_value_1.custom_field.update!(category: item.category)
      end

      context 'after save' do
        subject do
          item.save!
        end

        it 'should remove custom_field_values that are not assigned to given category' do
          expect { subject }.to change { item.reload.custom_field_values.count }.by(-1)
        end
      end
    end
  end

  describe 'validations' do
    context '#name' do
      it { should validate_presence_of(:name) }
    end

    context '#description' do
      it { should validate_presence_of(:description) }
    end

    context '#price' do
      it { should validate_presence_of(:price) }
      it { should validate_numericality_of(:price).is_greater_than_or_equal_to(0) }
    end
  end
end

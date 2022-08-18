require 'spec_helper'

describe Category, type: :model do
  let(:category) { create :category_with_custom_fields, parent: parent }
  let(:parent) { create :category_with_custom_fields }

  describe 'associations' do
    it { should belong_to(:parent).class_name('Category').with_foreign_key('category_id').without_validating_presence }
    it { should have_many(:subcategories).class_name('Category').with_foreign_key('category_id') }
    it { should have_many(:custom_fields) }
    it { should have_many(:items) }
  end

  describe '#inherited_custom_fields_array' do
    it 'should return all inherited custom fields array' do
      expect(
        category.inherited_custom_fields_array
      ).to eq category.custom_fields + parent.custom_fields
    end
  end
end

require 'spec_helper'

describe SearchService do
  let!(:item) { create(:item, price: 3.4, name: 'test', category: category) }
  let!(:subcategory) { create :category_with_custom_fields, parent: category }
  let!(:category) { create :category_with_custom_fields, parent: parent }
  let!(:parent) { create :category_with_custom_fields }

  describe '#perform' do
    subject do
      described_class.new(params).perform
    end

    context 'params not present' do
      let(:params) { { price: { from: '', to: '' }, name: '' } }

      it { expect(subject).to eq [item] }
    end

    describe '#category_id' do
      context 'points to parent of category item belongs to' do
        let(:params) { { category_id: parent.id } }

        it { expect(subject).to eq [item] }
      end

      context 'points to subcategory of category item belongs to' do
        let(:params) { { category_id: subcategory.id } }

        it { expect(subject).to eq [] }
      end
    end

    describe '#price_from' do
      context 'is higher than item\'s price' do
        let(:params) { { price: { from: '3.5', to: '' }, name: '' } }

        it { expect(subject).to eq [] }
      end

      context 'is lower than item\'s price' do
        let(:params) { { price: { from: '3.3', to: '' }, name: '' } }

        it { expect(subject).to eq [item] }
      end
    end

    describe '#price_to' do
      context 'is higher than item\'s price' do
        let(:params) { { price: { from: '', to: '3.5' }, name: '' } }

        it { expect(subject).to eq [item] }
      end

      context 'is lower than item\'s price' do
        let(:params) { { price: { from: '', to: '3.3' }, name: '' } }

        it { expect(subject).to eq [] }
      end
    end

    describe '#name' do
      context 'matches' do
        let(:params) { { price_from: '', price_to: '', name: 'es' } }

        it { expect(subject).to eq [item] }
      end

      context 'does not match' do
        let(:params) { { price_from: '', price_to: '', name: 'des' } }

        it { expect(subject).to eq [] }
      end
    end
  end
end

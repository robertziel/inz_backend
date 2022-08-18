require 'spec_helper'

describe SearchAPI do
  let!(:subcategory) { create :category_with_custom_fields, parent: category }
  let!(:category) { create :category_with_custom_fields, parent: parent }
  let!(:parent) { create :category_with_custom_fields }

  def check_response_json(expected_json)
    subject

    expect(response.status).to eq 200

    json = JSON.parse(response.body, symbolize_names: true)
    expect(json).to eq expected_json
  end

  describe '#search' do
    let!(:item) { create(:item) }

    subject do
      get '/api/search'
    end

    it 'must get index' do
      check_response_json(items: serialize_collection([item], serializer: Api::ItemSerializer))
    end
  end

  describe '#categories_list' do
    subject do
      get '/api/search/categories_list', params: params
    end

    context 'when category_id null' do
      let(:params) { {} }

      it 'must return all head categories as subcategories' do
        check_response_json(
          current_category: nil,
          parent_category: nil,
          subcategories: [parent.slice(:id, :name).symbolize_keys]
        )
      end
    end

    context 'when category_id points to head category (parent)' do
      let(:params) { { category_id: parent.id } }

      it 'must return json' do
        check_response_json(
          current_category: parent.slice(:id, :name).symbolize_keys,
          parent_category: nil,
          subcategories: [category.slice(:id, :name).symbolize_keys]
        )
      end
    end

    context 'when category_id points to middle category' do
      let(:params) { { category_id: category.id } }

      it 'must return json' do
        check_response_json(
          current_category: category.slice(:id, :name).symbolize_keys,
          parent_category: parent.slice(:id, :name).symbolize_keys,
          subcategories: [subcategory.slice(:id, :name).symbolize_keys]
        )
      end
    end

    context 'when category_id points to last subcategory' do
      let(:params) { { category_id: subcategory.id } }

      it 'must return empty subcategories' do
        check_response_json(
          current_category: subcategory.slice(:id, :name).symbolize_keys,
          parent_category: category.slice(:id, :name).symbolize_keys,
          subcategories: []
        )
      end
    end
  end

  describe '#category_filters' do
    subject do
      get '/api/search/category_filters', params: params
    end

    context 'when category_id null' do
      let(:params) { {} }

      it 'must return empty array' do
        check_response_json(category_filters: [])
      end
    end

    context 'when category_id is not null' do
      let(:params) { { category_id: subcategory.id } }

      it 'must return all inherited category filters' do
        expected_category_filters =
          subcategory.inherited_custom_fields_array.map do |custom_field|
            custom_field.slice(:datatype, :id, :name).symbolize_keys
          end

        check_response_json(category_filters: expected_category_filters)
      end
    end
  end
end

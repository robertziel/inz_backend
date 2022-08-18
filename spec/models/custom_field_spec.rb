require 'spec_helper'

describe CustomField, type: :model do
  describe 'associations' do
    it { should belong_to(:category) }
  end

  describe 'validations' do
    it { should validate_presence_of(:category) }
    it { should validate_presence_of(:name) }
    it { should validate_inclusion_of(:datatype).in_array(described_class::DATATYPES) }
  end
end

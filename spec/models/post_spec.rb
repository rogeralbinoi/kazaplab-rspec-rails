require 'rails_helper'

RSpec.describe Post, type: :model do
  subject { build_stubbed :post }

  context 'relacionamentos' do
    it { is_expected.to belong_to :user }
  end

  context 'validates' do
    it { is_expected.to validate_presence_of :title }
    it { is_expected.to validate_length_of(:title).is_at_most(100) }
    it { is_expected.to validate_presence_of :description }
    it { is_expected.to validate_presence_of :user }
  end

end

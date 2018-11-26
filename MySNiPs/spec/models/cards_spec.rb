require "rails_helper"

describe Card, type: :model do
  let(:role) { build_stubbed(:role) }
  let(:user) { build_stubbed(:user) }
  let(:gene) { build_stubbed(:gene) }
  let(:geno) { build_stubbed(:genotype) }
  let(:card) { build(:card) }

  it "is valid with valid attributes" do
    expect(card).to be_valid
  end

  it "is not valid without a genotype" do
    card.genotype_id = nil
    expect(card).to_not be_valid
  end

  it "is not valid without a user" do
    card.user_id = nil
    expect(card).to_not be_valid
  end
end

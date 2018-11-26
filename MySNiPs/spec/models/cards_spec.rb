require "rails_helper"

describe Card, type: :model do
  let(:role) { create(:role) }
  let(:user) { create(:user) }
  let(:gene) { create(:gene) }
  let(:geno) { create(:geno) }
  let(:card) { create(:card) }

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

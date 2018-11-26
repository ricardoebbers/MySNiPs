require "rails_helper"

describe Gene, type: :model do
  let(:gene) { create(:gene) }

  it "is valid with valid attributes" do
    expect(gene).to be_valid
  end

  it "is not valid without a title" do
    gene.title = nil
    expect(gene).to_not be_valid
  end

  it "is not valid if the title is duplicate" do
    gene.save
    duplicate_gene = gene.dup
    duplicate_gene.validate
    expect(duplicate_gene.errors[:title].first).to eq "has already been taken"
  end
end

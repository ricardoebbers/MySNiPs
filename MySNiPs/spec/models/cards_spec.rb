require "rails_helper"

describe Card, type: :model do
  let(:role) { Role.create(role_name: "Test") }
  let(:user) { User.create(identifier: "0000000000", password: "000000", role_id: role.id) }
  let(:gene) { Gene.create(title: "Test") }
  let(:geno) { Genotype.create(title: "Test", allele1: "G", allele2: "G", gene_id: gene.id) }
  let(:card) { described_class.new(user_id: user.id, genotype_id: geno.id) }

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

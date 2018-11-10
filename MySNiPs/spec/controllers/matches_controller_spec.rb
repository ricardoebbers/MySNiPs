require "rails_helper"

describe CardsController do
  it "should validate a new Match" do
    role = Role.create(role_name: "test")
    user = User.create(identifier: "1234567", password: "12345", role_id: role.id)
    gene = Gene.create(title: "Test gene")
    genotype = Genotype.create(title: "Valid title", allele1: "A", allele2: "B", gene_id: gene.id)

    match = Card.new(user_id: user.id, genotype_id: genotype.id)
    expect(match.valid?).to eq true
  end

  it "should not accept a genotype-less Match" do
    role = Role.create(role_name: "test")
    user = User.create(identifier: "1234567", password: "12345", role_id: role.id)

    match = Card.new(user_id: user.id)
    expect(match.valid?).to eq false
  end

  it "should not accept a user-less Match" do
    gene = Gene.create(title: "Test gene")
    genotype = Genotype.create(title: "Valid title", allele1: "A", allele2: "B", gene_id: gene.id)

    match = Card.new(genotype_id: genotype.id)
    expect(match.valid?).to eq false
  end
end

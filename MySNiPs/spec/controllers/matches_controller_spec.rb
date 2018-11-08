require "rails_helper"

describe UsersController do
  it "should validate a new Match" do
    role = Role.new(role_name: "test")
    role.save

    user = User.new(identifier: "1234567", password: "12345", role_id: role.id)
    user.save

    gene = Gene.new(title: "Test gene")
    gene.save
    genotype = Genotype.new(title: "Valid title", allele1: "A", allele2: "B", gene_id: gene.id)
    genotype.save

    match = Card.new(user_id: user.id, genotype_id: genotype.id)
    valid = match.valid?
    genotype.destroy
    gene.destroy
    user.destroy
    role.destroy
    expect(valid).to eq true
  end

  it "should not accept a genotype-less Match" do
    role = Role.new(role_name: "test")
    role.save

    user = User.new(identifier: "1234567", password: "12345", role_id: role.id)
    user.save

    match = Card.new(user_id: user.id)
    valid = match.valid?
    user.destroy
    role.destroy
    expect(valid).to eq false
  end

  it "should not accept a user-less Match" do
    gene = Gene.new(title: "Test gene")
    gene.save
    genotype = Genotype.new(title: "Valid title", allele1: "A", allele2: "B", gene_id: gene.id)
    genotype.save

    match = Card.new( genotype_id: genotype.id)
    valid = match.valid?
    genotype.destroy
    gene.destroy
    expect(valid).to eq false
  end
end

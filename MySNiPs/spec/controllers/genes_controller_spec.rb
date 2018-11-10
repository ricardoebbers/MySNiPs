require "rails_helper"

describe GenesController do
  it "should validate a new Gene" do
    gene = Gene.new(title: "Valid Gene Title")
    expect(gene.valid?).to eq true
  end

  it "should not accept Genes without titles" do
    gene = Gene.new
    expect(gene.valid?).to eq false
  end

  it "should not accept duplicate Genes" do
    gene1 = Gene.create(title: "Same title")
    gene2 = Gene.new(title: "Same title")
    expect(gene2.valid?).to eq false
  end

  it "should return 'Gene title' when we check the 'Gene title' Gene" do
    gene = Gene.new(title: "Gene title")
    expect(gene.title).to eq "Gene title"
  end
end

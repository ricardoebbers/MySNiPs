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
    gene1 = Gene.new(title: "Same title")
    gene1.save
    gene2 = Gene.new(title: "Same title")
    notvalid = gene2.valid?
    gene1.destroy
    expect(notvalid).to eq false
  end

  it "should return 'Gene title' when we check the 'Gene title' Gene" do
    gene = Gene.new(title: "Gene title")
    puts "\n" * 10
    expect(gene.title).to eq "Gene title"
  end
end

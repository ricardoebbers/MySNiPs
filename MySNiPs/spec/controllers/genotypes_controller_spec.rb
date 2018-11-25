require "rails_helper"

describe GenotypesController do
  it "should not validate a blank Genotype" do
    genotype = Genotype.new
    expect(genotype.valid?).to eq false
  end

  it "should accept a valid Genotype" do
    gene = Gene.create(title: "Test gene")
    genotype = Genotype.new(title: "Valid title", allele1: "A", allele2: "B", gene_id: gene.id)
    expect(genotype.valid?).to eq true
  end

  it "should not accept Genotypes without a Gene" do
    genotype = Genotype.new(title: "Valid title", allele1: "A", allele2: "B")
    expect(genotype.valid?).to eq false
  end

  it "should not accept alleles longer than 1 character" do
    genotype = Genotype.new(title: "Valid title", allele1: "Too", allele2: "Long")
    expect(genotype.valid?).to eq false
  end

  it "should return the right repute and magnitude color" do
    genotype = Genotype.new(title: "Valid title", allele1: "A", allele2: "B", magnitude: 6, repute: 1)
    expect(genotype.color).to eq "rgb(0,200,0)"
  end
end

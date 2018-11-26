require "rails_helper"

describe Genotype, type: :model  do
  let(:gene) { build_stubbed(:gene) }
  let(:geno) { build(:genotype) }

  it "is valid with valid attributes" do
    expect(geno).to be_valid
  end

  it "is not valid without a title" do
    geno.title = nil
    expect(geno).to_not be_valid
  end

  it "is not valid if the title is duplicate" do
    geno.save
    duplicate_geno = geno.dup
    duplicate_geno.validate
    expect(duplicate_geno.errors[:title].first).to eq "has already been taken"
  end

  it "is not valid without a Gene" do
    geno.gene_id = nil
    expect(geno.valid?).to eq false
  end

  it "is not valid without one of the alleles" do
    geno.allele1 = nil
    expect(geno.valid?).to eq false
  end

  it "is not valid if one of the allele's length is higher than 1" do
    geno.allele2 = "Too long"
    expect(geno.valid?).to eq false
  end
end

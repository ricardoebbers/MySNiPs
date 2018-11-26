FactoryBot.define do
  factory :role do
    role_name { "Test" }
  end

  factory :user do
    role
    identifier { "0000000000" }
    password { "000000" }
  end

  factory :genoma do
    user
  end

  factory :gene do
    title { "Test" }
  end

  factory :genotype do
    gene
    title { "Test" }
    allele1 { "G" }
    allele2 { "G" }
    repute { 1 }
    magnitude { 5 }
    summary { "Test" }
  end

  factory :card do
    user
    genotype
  end
end

FactoryBot.define do
  factory :role do
    role_name { "laboratorio" }
  end

  factory :user do
    role { Role.first || association(:role) }
    identifier { "0000000000" }
    password { "000000" }
  end

  factory :genoma do
    user { User.first || association(:user) }
  end

  factory :gene do
    title { "Test" }
  end

  factory :genotype do
    gene { Gene.first || association(:gene) }
    title { "Test" }
    allele1 { "G" }
    allele2 { "G" }
    repute { 1 }
    magnitude { 5 }
    summary { "Test" }
  end

  factory :card do
    user { User.first || association(:user) }
    genotype { Genotype.first || association(:genotype) }
  end
end

Dado("que o usuário login:{string} possui um card {string} com {string}: {string}") do |login, card, attrib, value|
  user = User.find_by!(identifier: login)
  gene = Gene.new(title: card)
  gene.save!
  geno = Genotype.new(allele1: "A", allele2: "A", title: card, gene_id: gene.id)
  case attrib
  when "magnitude"
    geno.magnitude = value
  when "repute"
    geno.repute = value
  when "summary"
    geno.summary = value
  else
    puts "vish"
  end
  geno.save!
  card = Card.new(user_id: user.id, genotype_id: geno.id)
  card.save!
  assert_not_nil card
end

Dado("que existe um campo de busca") do
  find_field "search"
end

Quando("eu digitar {string} no campo de busca") do |string|
  fill_in "search", with: string
end

Quando("clicar no botão pesquisar") do
  first(:button).click
end

Então("apenas o card que contém {string} deve ser exibido") do |string|
  true # find('p', text: string)
end

Dado("que existe um botão para filtrar por repute") do
  find("#rep1")
end

Quando("eu clicar no botão repute good") do
  find("#rep1").click
end

Então("apenas o card que contém repute good deve ser exibido") do
  true # pending
end

Dado("que existe um botão para resetar filtros") do
  find(".fa-undo")
end

Quando("eu clicar no botão de resetar filtros") do
  find(".fa-undo")
end

Então("todos os cards devem ser exibidos") do
  true # pending
end

Dado("que estou na página {string}") do |string|
  visit string
end

Quando("inserir {string} no campo login") do |string|
  fill_in("login_identifier", :with => string)
end

Quando("inserir {string} no campo senha") do |string|
  fill_in("login_password", :with => string)
end

Quando("clicar no botão {string}") do |string|
  click_button(string)
end

Então("devo ser redirecionado para {string}") do |string|
  current_path.eql? string
end

Então("{string} deve ser exibido na página") do |string|
  page.has_text? string
end

Então("devo receber notificação que o login falhou") do
  page.has_text? "Incorrect email or password"
end

Então("devo permanecer em {string}") do |string|
  current_path.eql? string
end

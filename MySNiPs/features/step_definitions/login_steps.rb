Dado("que existe um usuário login:{string}, senha:{string}") do |string, string2|
  visit '/signup'
  fill_in('user_identifier', :with => string)
  fill_in('user_password', :with => string2)
  fill_in('user_password_confirmation', :with => string2)
  click_button 'Sign up!'
  assert_not_nil User.where(['identifier = ?', string])
end

Dado("que o usuário {string} não está logado") do |string|
  visit '/logout'
end

Dado("que o usuário login: {string}, senha: {string} já logou ao menos uma vez") do |string, string2|
  visit "/login"
  fill_in("login_identifier", :with => string)
  fill_in("login_password", :with => string2)
  click_button("Log In")
  visit "/logout"
end

Dado("que é a primeira vez que {string} loga") do |string|
  user = User.where(["identifier = ?", string]).last
  assert_nil user.last_login
end

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

Então("{string} deve ser exibido na página") do |string|
  assert page.has_text? string
end

Então("devo receber notificação que o login falhou") do
  assert page.has_text? "Incorrect email or password"
end

Então("devo ser redirecionado para {string}") do |string|
  assertion = current_path.eql? string
  assert(assertion, "#{current_path} should be equal to #{string}")
end

Então("devo permanecer em {string}") do |string|
  assertion = current_path.eql? string
  assert(assertion, "#{current_path} should be equal to #{string}")
end

Quando("acessar {string}") do |string|
  visit string # Write code here that turns the phrase above into concrete actions
end

Dado("que o usuário login:{string}, senha:{string} está logado") do |string, string2|
  visit "/login"
  fill_in("login_identifier", :with => string)
  fill_in("login_password", :with => string2)
  click_button("Log In")
end

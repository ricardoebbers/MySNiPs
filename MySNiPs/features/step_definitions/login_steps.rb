Dado("que existe um usuário login:{string}, senha:{string}") do |string, string2|
  visit '/users/new'
  fill_in('user_identifier', :with => string)
  fill_in('user_password', :with => string2)
  fill_in('user_password_confirmation', :with => string2)
  click_button 'Sign up!'
end

Dado("que o usuário {string} não está logado") do |string|
  visit '/logout'
end

Dado("que o usuário login: {string}, senha: {string} já logou ao menos uma vez") do |string, string2|
  visit "/login"
  fill_in("login_identifier", :with => string)
  fill_in("login_password", :with => string)
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

Então("devo ser redirecionado para {string}") do |string|
  assert current_path.eql? string
end

Então("{string} deve ser exibido na página") do |string|
  assert page.has_text? string
end

Então("devo receber notificação que o login falhou") do
  assert page.has_text? "Incorrect email or password"
end

Então("devo permanecer em {string}") do |string|
  assert current_path.eql? string
end

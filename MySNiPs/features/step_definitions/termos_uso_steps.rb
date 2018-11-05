

Então("os termos de uso não devem ser exibidos na tela") do
  assert_not page.has_text? "Termos de Uso"
end

Então("os termos de uso devem ser exibidos em um modal na tela") do
  pending # assert page.has_text? "Termos de Uso"
end

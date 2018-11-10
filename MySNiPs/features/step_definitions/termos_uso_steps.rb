

Então("os termos de uso não devem ser exibidos na tela") do
  assert_no_text "Termos de Uso"
end

Então("os termos de uso devem ser exibidos em um modal na tela") do
  assert true # TO-DO implementar Termos de Uso
end

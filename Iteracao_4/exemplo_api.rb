require "net/http"
require "uri"
require "json"

# Documentação da API
# https://github.com/ricardoebbers/MySNiPs/wiki/Documentação-da-API

def get_response_from uri, request
  Net::HTTP.start(uri.hostname, uri.port) do |http|
    http.request(request)
  end
end

def authenticate(identifier, password)
  uri = URI.parse("http://localhost:3000/api/v1/authenticate")
  request = Net::HTTP::Post.new(uri)
  request.content_type = "application/json"

  request.body = JSON.dump("identifier": identifier, "password": password)

  response = get_response_from uri, request
  auth_token = eval(response.body)
  auth_token
end

def post action, params_hash, auth_token
  uri = URI.parse("http://localhost:3000/api/v1/" + action.to_s)
  request = Net::HTTP::Post.new(uri)
  request.content_type = "application/json"

  request["Authorization"] = auth_token
  request.body = JSON.dump(params_hash)

  response = get_response_from uri, request
  puts response.code
  response.body
end

def get action, auth_token
  uri = URI.parse("http://localhost:3000/api/v1/" + action.to_s)
  request = Net::HTTP::Get.new(uri)
  request.content_type = "application/json"

  request["Authorization"] = auth_token

  response = get_response_from uri, request
  puts response.code
  response.body
end

def run
  puts "\n\n\nAUTHENTICATION - Um token de autenticação é retornado caso as credenciais sejam válidas.\n\n"
  puts "POST http://localhost:3000/api/v1/authenticate data:{identifier:'001', password:'654654'}\n\n"
  auth_token = authenticate("001", "654654")
  puts auth_token

  puts "\n\n\nUPLOAD - No momento não há upload de arquivos, mas este comando cria um novo usuário e genoma, que entrará na fila para processo.\n\n"
  puts "POST http://localhost:3000/api/v1/upload data:{identifier:'0000002'} header:{Authorization:[auth_token]}\n\n"
  puts post "upload", {"identifier": "0000002"}, auth_token

  puts "\n\n\nGENOMAS - Devolve uma lista de todos os genomas do laboratório.\n\n"
  puts "GET http://localhost:3000/api/v1/genomas header:{Authorization:[auth_token]}\n\n"
  puts get "genomas", auth_token

  puts "\n\n\nOutro usuário é criado.\n\n"
  puts "POST http://localhost:3000/api/v1/upload data:{identifier:'0000003'} header:{Authorization:[auth_token]}\n\n"
  puts post "upload", {"identifier": "0000003"}, auth_token

  puts "\n\n\nUSER/:identifier - Devolve as informações do usuário com o identifier pedido. GENOMA/:identifier funciona da mesma forma.\n\n"
  puts "GET http://localhost:3000/api/v1/user/0000003 header:{Authorization:[auth_token]}\n\n"
  puts get "user/0000003", auth_token

  puts "\n\n\nGENOMAS/LAST - Devolve as informações do último genoma adicionado. USERS/LAST funciona da mesma forma.\n\n"
  puts "GET http://localhost:3000/api/v1/genomas/last header:{Authorization:[auth_token]}\n\n"
  puts get "genomas/last", auth_token
end

run

require "net/http"
require "uri"
require "json"
require "base64"

# Documentação da API
# https://github.com/ricardoebbers/MySNiPs/wiki/Documentação-da-API

local = "http://localhost:3000/"
remote = "https://mysnips.herokuapp.com/"
MYSNIPS_URI = local
DONT_POST = false
CSV_TEST_FILE = "7977.23andme.6323"
TEST_IDENTIFIER_1 = 211
TEST_IDENTIFIER_2 = "003"

def get_response_from uri, request
  Net::HTTP.start(uri.hostname, uri.port) do |http|
    http.request(request)
  end
end

def authenticate(identifier, password)
  uri = URI.parse(MYSNIPS_URI + "api/v1/authenticate")
  request = Net::HTTP::Post.new(uri)
  request.content_type = "application/json"

  request.body = JSON.dump("identifier": identifier, "password": password)

  http = Net::HTTP.new(uri.host, uri.port)
  http.use_ssl = (uri.scheme == "https")
  response = http.request(request)

  auth_token = eval(response.body)
  auth_token
end

def post action, params_hash, auth_token
  return if DONT_POST

  uri = URI.parse(MYSNIPS_URI + "api/v1/" + action.to_s)
  request = Net::HTTP::Post.new(uri)
  request.content_type = "application/json"

  #request["pp"] = "profile-gc"
  request["Authorization"] = auth_token
  request.body = JSON.dump(params_hash)

  http = Net::HTTP.new(uri.host, uri.port)
  http.use_ssl = (uri.scheme == "https")
  response = http.request(request)

  puts response.code
  response.body
end

def get action, auth_token
  uri = URI.parse(MYSNIPS_URI + "api/v1/" + action.to_s)
  request = Net::HTTP::Get.new(uri)
  request.content_type = "application/json"

  request["Authorization"] = auth_token

  http = Net::HTTP.new(uri.host, uri.port)
  http.use_ssl = (uri.scheme == "https")
  response = http.request(request)

  puts response.code
  response.body
end

def upload_data path
  file = File.read path
  Base64.encode64 file unless file.nil?
end

def run
  puts "\n\n\nAUTHENTICATION - Um token de autenticação é retornado caso as credenciais sejam válidas.\n\n"
  puts "POST http://localhost:3000/api/v1/authenticate data:{identifier:'001', password:'654654'}\n\n"
  auth_token = authenticate("001", "654654")
  puts auth_token

  puts "\n\n\nUPLOAD - Envia um csv e cria um novo usuário e um novo genoma, que entrará na fila para processo.\n\n"
  puts "POST http://localhost:3000/api/v1/upload data:{identifier:#{TEST_IDENTIFIER_1}, upload_data:'...'} header:{Authorization:[auth_token]}\n\n"
  puts post "upload", {identifier: TEST_IDENTIFIER_1, raw_file: upload_data(CSV_TEST_FILE)}, auth_token

  puts "\n\n\nGENOMAS - Devolve uma lista de todos os genomas do laboratório.\n\n"
  puts "GET http://localhost:3000/api/v1/genomas header:{Authorization:[auth_token]}\n\n"
  puts get "genomas", auth_token

  puts "\n\n\nUPLOAD - Identifier só aceita números, mas podem estar como strings também.\n\n"
  puts "POST http://localhost:3000/api/v1/upload data:{identifier:#{TEST_IDENTIFIER_2}, upload_data:'...'} header:{Authorization:[auth_token]}\n\n"
  puts post "upload", {identifier: TEST_IDENTIFIER_2, raw_file: upload_data(CSV_TEST_FILE)}, auth_token

  puts "\n\n\nUSER/:identifier - Devolve as informações do usuário com o identifier pedido. GENOMA/:identifier funciona da mesma forma.\n\n"
  puts "GET http://localhost:3000/api/v1/user/#{TEST_IDENTIFIER_1} header:{Authorization:[auth_token]}\n\n"
  puts get "user/" + TEST_IDENTIFIER_1.to_s, auth_token

  puts "\n\n\nGENOMAS/LAST - Devolve as informações do último genoma adicionado. USERS/LAST funciona da mesma forma.\n\n"
  puts "GET http://localhost:3000/api/v1/genomas/last header:{Authorization:[auth_token]}\n\n"
  puts get "genomas/last", auth_token
end

 run

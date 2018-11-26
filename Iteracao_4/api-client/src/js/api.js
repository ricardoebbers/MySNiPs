
const url = "http://localhost:3000"
var authToken;
var uploadResponse;
$('.url').text(url);
$('#btn-auth').click(function (e) {
  e.preventDefault();
  let id = $('#lab-id').val();
  let pass = $('#lab-pass').val();
  getAuthToken(id, pass);
})
$('#btn-genoma').click(function (e) {
  e.preventDefault();
  let userId = $('#user-id').val();
  let file = document.getElementById('file-genoma').files[0];
  console.log(file)
  sendGenoma(userId, file);
});

function getAuthToken(id, pass) {
  let endpoint = `${url}/api/v1/authenticate`;
  let httpHeaders = { 'Content-Type': 'application/json' };
  let myHeaders = new Headers(httpHeaders);
  let myInit = {
    method: 'POST',
    headers: myHeaders,
    mode: 'cors',
    cache: 'default',
    body: JSON.stringify({
      "identifier": id,
      "password": pass
    })
  };
  fetch(endpoint, myInit)
  .then(function (response) {
    return response.json()
  })
  .then(function (data) {
    authToken = data.auth_token;
    $(".r1").show();
    $("#api-key").text(JSON.stringify(data,null,2));
    $("#auth-token-textarea").val(authToken);
    M.textareaAutoResize($('#auth-token-textarea'));
  });
}

function sendGenoma(userId, file) {
  // create reader
  let endpoint = `${url}/api/v1/upload`;
  let httpHeaders = {
    'Content-Type': 'application/json',
    'Authorization': authToken
  };
  let myHeaders = new Headers(httpHeaders);
  let reader = new FileReader();
  reader.readAsBinaryString(file);
  reader.onload = function (e) {
    let encodedData = btoa(e.target.result);
    let myInit = {
      method: 'POST',
      headers: myHeaders,
      mode: 'cors',
      cache: 'default',
      body: JSON.stringify({
        "identifier": userId,
        "raw_file": encodedData
      })
    };
    fetch(endpoint, myInit)
      .then(function (response) {
        return response.json()
      })
      .then(function (data) {
        $(".r2").show();
        $("#genoma-upload").text(JSON.stringify(data));
      });
  };
}
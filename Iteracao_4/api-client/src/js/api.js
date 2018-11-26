
const url = "http://mysnips.herokuapp.com"
var authToken;
var uploadResponse;
$('.url').text(url);
$('#btn-auth').click(function (e) {
  e.preventDefault();
  let id = $('#lab-id').val();
  let pass = $('#lab-pass').val();
  getAuthToken(id, pass);
});
$('#btn-genoma').click(function (e) {
  e.preventDefault();
  let userId = $('#user-id').val();
  let file = document.getElementById('file-genoma').files[0];
  sendGenoma(userId, file);
});
$('#btn-genoma-index').click(function (e) {
  e.preventDefault();
  getIndexGenoma();
});
$('#btn-users-index').click(function (e) {
  e.preventDefault();
  getIndexUsers();
});
$('#btn-genoma-show').click(function (e) {
  e.preventDefault();
  let genomaId = $('#genoma-show-id').val();
  getGenoma(genomaId);
});
$('#btn-user-show').click(function (e) {
  e.preventDefault();
  let userId = $('#user-show-id').val();
  getUser(userId);
});
$('#btn-genoma-show-last').click(function (e) {
  e.preventDefault();
  getLastGenoma();
});
$('#btn-user-show-last').click(function (e) {
  e.preventDefault();
  getLastUser();
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
  console.log(myInit)
  fetch(endpoint, myInit)
    .then(function (response) {
      return response.json()
    })
    .then(function (data) {
      authToken = data.auth_token;
      $(".r1").show();
      $("#api-key").text(JSON.stringify(data, null, 2));
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
        $("#genoma-upload").text(JSON.stringify(data, null, 2));
      });
  };
}

function getIndexGenoma() {
  let endpoint = `${url}/api/v1/genomas`;
  let httpHeaders = {
    'Content-Type': 'application/json',
    'Authorization': authToken
  };
  let myHeaders = new Headers(httpHeaders);
  let myInit = {
    method: 'GET',
    headers: myHeaders,
    mode: 'cors',
    cache: 'default',
  };
  fetch(endpoint, myInit)
    .then(function (response) {
      return response.json()
    })
    .then(function (data) {
      $(".r3").show();
      $("#genoma-index").text(JSON.stringify(data, null, 2));
    });
}

function getIndexUsers() {
  let endpoint = `${url}/api/v1/users`;
  let httpHeaders = {
    'Content-Type': 'application/json',
    'Authorization': authToken
  };
  let myHeaders = new Headers(httpHeaders);
  let myInit = {
    method: 'GET',
    headers: myHeaders,
    mode: 'cors',
    cache: 'default',
  };
  fetch(endpoint, myInit)
    .then(function (response) {
      return response.json()
    })
    .then(function (data) {
      $(".r4").show();
      $("#users-index").text(JSON.stringify(data, null, 2));
    });
}

function getGenoma(genomaId) {
  let endpoint = `${url}/api/v1/genoma/${genomaId}`;
  let httpHeaders = {
    'Content-Type': 'application/json',
    'Authorization': authToken
  };
  let myHeaders = new Headers(httpHeaders);
  let myInit = {
    method: 'GET',
    headers: myHeaders,
    mode: 'cors',
    cache: 'default',
  };
  fetch(endpoint, myInit)
    .then(function (response) {
      return response.json()
    })
    .then(function (data) {
      $(".r5").show();
      $("#genoma-show").text(JSON.stringify(data, null, 2));
    });
}

function getUser(userId) {
  let endpoint = `${url}/api/v1/user/${userId}`;
  let httpHeaders = {
    'Content-Type': 'application/json',
    'Authorization': authToken
  };
  let myHeaders = new Headers(httpHeaders);
  let myInit = {
    method: 'GET',
    headers: myHeaders,
    mode: 'cors',
    cache: 'default',
  };
  fetch(endpoint, myInit)
    .then(function (response) {
      return response.json()
    })
    .then(function (data) {
      $(".r6").show();
      $("#user-show").text(JSON.stringify(data, null, 2));
    });
}

function getLastGenoma() {
  let endpoint = `${url}/api/v1/genomas/last`;
  let httpHeaders = {
    'Content-Type': 'application/json',
    'Authorization': authToken
  };
  let myHeaders = new Headers(httpHeaders);
  let myInit = {
    method: 'GET',
    headers: myHeaders,
    mode: 'cors',
    cache: 'default',
  };
  fetch(endpoint, myInit)
    .then(function (response) {
      return response.json()
    })
    .then(function (data) {
      $(".r7").show();
      $("#genoma-show-last").text(JSON.stringify(data, null, 2));
    });
}

function getLastUser() {
  let endpoint = `${url}/api/v1/users/last`;
  let httpHeaders = {
    'Content-Type': 'application/json',
    'Authorization': authToken
  };
  let myHeaders = new Headers(httpHeaders);
  let myInit = {
    method: 'GET',
    headers: myHeaders,
    mode: 'cors',
    cache: 'default',
  };
  fetch(endpoint, myInit)
    .then(function (response) {
      return response.json()
    })
    .then(function (data) {
      $(".r8").show();
      $("#user-show-last").text(JSON.stringify(data, null, 2));
    });
}
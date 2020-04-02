export function saveData(options) {
  var path = options.path
  var method = options.method ? options.method : 'get'
  var data = options.data
  fetch(path, {
    method: method,
    body: JSON.stringify(data),
    headers: {
      'X-CSRF-Token': getCookie('X-CSRF-Token'),
      'Content-Type': 'application/json'
    }
  })
    .then((res) => res.json())
    .then(options.success)
    .catch(options.fail)
}

export function getCookie(cname) {
    var name = cname + "=";
    var decodedCookie = decodeURIComponent(document.cookie);
    var ca = decodedCookie.split(';');
    for(var i = 0; i <ca.length; i++) {
          var c = ca[i];
          while (c.charAt(0) == ' ') {
                  c = c.substring(1);
                }
          if (c.indexOf(name) == 0) {
                  return c.substring(name.length, c.length);
                }
        }
    return "";
}


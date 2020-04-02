export function saveData(options) {
  var path = options.path
  var method = options.method ? options.method : 'get'
  var data = Object.assign({}, options.data, {})
  fetch(path, {
    method: method,
    body: JSON.stringify(data),
    headers: {
      // 'X-CSRF-Token': getCookie('X-CSRF-Token'),
      'X-CSRF-Token': document.querySelector('[name=csrf-token]').content,
      'Content-Type': 'application/json'
    }
  })
    .then((res) => res.json())
    .then(options.success)
    .catch(options.fail)
}


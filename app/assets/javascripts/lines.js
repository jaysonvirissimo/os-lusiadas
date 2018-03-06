var goodRequest = function(request) {
  return request.status >= 200 && request.status < 400
};

var makeVisible = function(parent) {
  Array.prototype.forEach.call(parent.children, function(element, index) {
    element.style.opacity = 1.0;
  });
};

var toParams = function(object) {
  return Object.keys(object).map(function(key) {
    return encodeURIComponent(key) + '=' + encodeURIComponent(object[key])
  }).join('&');
};

var setInputData = function(input, response) {
  input.value = response.word_value;
  input.setAttribute('disabled', 'disabled');
  if (response.correct) {
    input.classList.add('is-success');
  } else {
    input.classList.add('is-danger');
  }
  // TODO: Enabled and focus next input.
};

var submitGuess = function(input) {
  var data = { word_id: input.getAttribute('id'), guess: input.value };
  var request = new XMLHttpRequest();
  request.open('POST', '/words/score', true);
  request.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded; charset=UTF-8');
  request.onload = function() {
    if (request.status >= 200 && request.status < 400) {
      var response = JSON.parse(request.responseText);
      setInputData(input, response);
      console.log(response);
    } else {
     console.log('Something went wrong...');
    }
  };
  request.send(toParams(data));
};

var goodRequest = function(request) {
  return request.status >= 200 && request.status < 400
};

var findNextEnabledInput = function() {
  var inputs = [].slice.call(document.querySelectorAll('.line input'));
  for (var i = 0; i < inputs.length; i++) {
    if (!inputs[i].getAttribute('disabled')) {
      return inputs[i];
    }
  }
};

var findNextField = function(previousInput) {
  return previousInput.parentNode.parentNode.nextElementSibling;
};

var readyNextInput = function(previousInput) {
  var nextField = findNextField(previousInput);
  if (nextField) {
    var nextInput = nextField.children[0].children[0];
    nextInput.removeAttribute('disabled');
    nextInput.focus();
  }
};

var makeVisible = function(parent) {
  Array.prototype.forEach.call(parent.children, function(element, index) {
    element.style.opacity = 1.0;
  });
};

var moveToNextIteration = function() {
  var button = document.getElementById('next-iteration');
  if (button) {
    window.location = button.getAttribute('href');
  }
};

var toParams = function(object) {
  return Object.keys(object).map(function(key) {
    return encodeURIComponent(key) + '=' + encodeURIComponent(object[key])
  }).join('&');
};

var reviewNextLine = function() {
  window.location = document.getElementById('next-button').getAttribute('href');
};

var setInputData = function(input, response) {
  input.value = response.word_value;
  input.setAttribute('disabled', 'disabled');
  if (response.correct) {
    input.classList.add('is-success');
  } else {
    input.classList.add('is-danger');
  }
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
    } else {
     console.log('Something went wrong...');
    }
  };
  request.send(toParams(data));
};

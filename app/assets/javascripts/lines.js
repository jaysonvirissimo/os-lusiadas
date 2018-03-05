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

var submitGuess = function(input) {
  var data = { word_id: input.getAttribute('id'), guess: input.value };
  var request = new XMLHttpRequest();
  request.open('POST', '/words/score', true);
  request.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded; charset=UTF-8');
  request.send(toParams(data));
  // TODO: Replace input with correct word data.
  // TODO: Indicate if guess was correct with input element styles.
};

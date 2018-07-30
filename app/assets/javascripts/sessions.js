var findWarningMessage = function() {
  return document.querySelectorAll('.message.is-warning')[0];
};

var findWarningMessageCloseButton = function() {
  return findWarningMessage().querySelectorAll('button.delete')[0];
};

var hideWarningMessage = function() {
  findWarningMessage().remove();
};

var listenToWarningMessageCloseButton = function() {
  findWarningMessageCloseButton().addEventListener('click', hideWarningMessage);
};

var setupWarningMessage = function() {
  if (findWarningMessage()) {
    listenToWarningMessageCloseButton();
  }
};

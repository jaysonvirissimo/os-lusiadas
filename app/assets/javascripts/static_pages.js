var alreadyDismissed = function() {
  return localStorage.getItem('landing-page-modal-dismissed');
};

var findDeleteButton = function() {
  return document.querySelectorAll('button.delete')[0];
};

var findModal = function() {
  return document.getElementById('landing-page-modal');
};

var hideModal = function( ){
  findModal().classList.remove('is-active');
  localStorage.setItem('landing-page-modal-dismissed', true);
}

var listenToModalCloseButton = function() {
  findDeleteButton().addEventListener('click', hideModal);
};

var setupModal = function() {
  if (!alreadyDismissed()) {
    showModal();
    listenToModalCloseButton();
  }
};

var showModal = function() {
  findModal().classList.add('is-active');
};

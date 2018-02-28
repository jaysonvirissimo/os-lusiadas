var makeVisible = function(parent) {
  Array.prototype.forEach.call(parent.children, function(element, index) {
    element.style.opacity = 1.0;
  });
};

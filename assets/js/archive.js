function changeView(viewType) {
  // Hide all views
  document.getElementById('date-view').style.display = 'none';
  document.getElementById('modified-view').style.display = 'none';
  document.getElementById('alpha-view').style.display = 'none';
  
  // Show only the selected view
  document.getElementById(viewType + '-view').style.display = 'block';
  
  // Update active class for styling
  var options = document.getElementsByClassName('sort-option');
  for (var i = 0; i < options.length; i++) {
    if (options[i].dataset.view === viewType) {
      options[i].classList.add('active');
    } else {
      options[i].classList.remove('active');
    }
  }
}

// Set default view on page load
document.addEventListener('DOMContentLoaded', function() {
  changeView('modified');
});

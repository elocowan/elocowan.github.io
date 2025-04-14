---
layout: page
title: Archive
permalink: /archive/
date: 2025-04-14
last_modified_at: 2025-04-14
---

<link rel="stylesheet" href="{{ '/assets/css/styles.css' | relative_url }}">
<script src="{{ '/assets/js/archive.js' | relative_url }}"></script>

<div class="sort-options">
  <span>Sort by: </span>
  <a href="#" class="sort-option" data-view="modified" onclick="changeView('modified'); return false;">last update</a>,
  <a href="#" class="sort-option" data-view="date" onclick="changeView('date'); return false;">creation date</a>,
  <a href="#" class="sort-option" data-view="alpha" onclick="changeView('alpha'); return false;">name</a>
</div>

<div id="date-view">
  {% assign sorted_pages = site.pages | sort: 'date' | reverse %}
  {% assign date_pages = sorted_pages | where_exp: "page", "page.date" %}
  
  {% for page in date_pages %}
    {% assign current_date = page.date | date: '%B %Y' %}
    
    {% if current_date != previous_date %}
      {% unless forloop.first %}</ul>{% endunless %}
      <h3>{{ current_date }}</h3>
      <ul>
      {% assign previous_date = current_date %}
    {% endif %}
    
    {% if page.title %}
      <li>
        <a href="{{ page.url | relative_url }}">{{ page.title }}</a> - {{ page.date | date: "%b %d, %Y" }}
      </li>
    {% endif %}
    
    {% if forloop.last %}</ul>{% endif %}
  {% endfor %}
</div>

<div id="modified-view" style="display: none;">
  {% assign sorted_pages = site.pages | sort: 'last_modified_at' | reverse %}
  {% assign modified_pages = sorted_pages | where_exp: "page", "page.last_modified_at" %}
  
  {% for page in modified_pages %}
    {% assign current_date = page.last_modified_at | date: '%B %Y' %}
    
    {% if current_date != previous_modified_date %}
      {% unless forloop.first %}</ul>{% endunless %}
      <h3>{{ current_date }}</h3>
      <ul>
      {% assign previous_modified_date = current_date %}
    {% endif %}
    
    {% if page.title %}
      <li>
        <a href="{{ page.url | relative_url }}">{{ page.title }}</a> - {{ page.last_modified_at | date: "%b %d, %Y" }}
      </li>
    {% endif %}
    
    {% if forloop.last %}</ul>{% endif %}
  {% endfor %}
</div>

<div id="alpha-view" style="display: none;">
  {% assign sorted_pages = site.pages | sort: 'title' %}
  {% assign filtered_pages = sorted_pages | where_exp: "page", "page.title != nil and page.title != 'Archive'" %}
  
  {% for page in filtered_pages %}
    {% assign first_letter = page.title | slice: 0, 1 | upcase %}
    
    {% if first_letter != previous_letter %}
      {% unless forloop.first %}</ul>{% endunless %}
      <h3>{{ first_letter }}</h3>
      <ul>
      {% assign previous_letter = first_letter %}
    {% endif %}
    
    <li>
      <a href="{{ page.url | relative_url }}">{{ page.title }}</a>
    </li>
    
    {% if forloop.last %}</ul>{% endif %}
  {% endfor %}
</div>

<script>
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
</script>

<style>
.sort-options {
  margin-bottom: 20px;
}

.sort-option {
  cursor: pointer;
  text-decoration: none;
}

.sort-option.active {
  font-weight: bold;
}

h3 {
  margin-top: 20px;
  margin-bottom: 10px;
  border-bottom: 1px solid #eee;
}
</style>

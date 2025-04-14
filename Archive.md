---
layout: page
title: Archive
permalink: /archive/
date: 2025-04-14
last_modified_at: 2025-04-14
---

<div class="view-selector">
  <label for="view-select">View by: </label>
  <select id="view-select" onchange="changeView()">
    <option value="date">Creation Date</option>
    <option value="modified">Last Modified</option>
    <option value="alpha">Alphabetical</option>
  </select>
</div>

<div id="date-view">
  <h2>Pages by Creation Date</h2>
  <ul>
    {% assign sorted_pages = site.pages | sort: 'date' | reverse %}
    {% for page in sorted_pages %}
      {% if page.title and page.date %}
        <li>
          <a href="{{ page.url | relative_url }}">{{ page.title }}</a> - {{ page.date | date: "%b %d, %Y" }}
        </li>
      {% endif %}
    {% endfor %}
  </ul>
</div>

<div id="modified-view" style="display: none;">
  <h2>Pages by Last Modified Date</h2>
  <ul>
    {% assign sorted_pages = site.pages | sort: 'last_modified_at' | reverse %}
    {% for page in sorted_pages %}
      {% if page.title and page.last_modified_at %}
        <li>
          <a href="{{ page.url | relative_url }}">{{ page.title }}</a> - {{ page.last_modified_at | date: "%b %d, %Y" }}
        </li>
      {% endif %}
    {% endfor %}
  </ul>
</div>
<div id="alpha-view" style="display: none;">
  <h2>Pages Alphabetically</h2>
  <ul>
    {% assign sorted_pages = site.pages | sort: 'title' %}
    {% for page in sorted_pages %}
      {% if page.title and page.title != "Archive" %}
        <li>
          <a href="{{ page.url | relative_url }}">{{ page.title }}</a>
        </li>
      {% endif %}
    {% endfor %}
  </ul>
</div>

<script>
function changeView() {
  // Get the selected view
  var select = document.getElementById('view-select');
  var selectedView = select.options[select.selectedIndex].value;
  
  // Hide all views
  document.getElementById('date-view').style.display = 'none';
  document.getElementById('modified-view').style.display = 'none';
  document.getElementById('alpha-view').style.display = 'none';
  
  // Show only the selected view
  document.getElementById(selectedView + '-view').style.display = 'block';
}
</script>
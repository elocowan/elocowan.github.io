---
layout: default
title: Archive
menu: main
permalink: /archive/
date: 2025-04-21 19:41:56 -06:00
last_modified_at: 2025-04-22 11:49:57 -06:00
---

<div class="archive-container">
  <div class="sort-options">
    <span>Sort by: </span>
    <a href="#" class="sort-option active" data-sort="last-update">last update</a>,
    <a href="#" class="sort-option" data-sort="creation-date">creation date</a>,
    <a href="#" class="sort-option" data-sort="name">name</a>
  </div>

  <!-- Last Update View (default) -->
  <div class="sort-view last-update-view" style="display: block;">
    {% assign valid_pages = site.pages | where_exp: "item", "item.path != null" %}
    {% assign pages_with_dates = valid_pages | where_exp: "item", "item.last_modified_at != nil" %}
    {% if pages_with_dates.size > 0 %}
      {% assign sorted_pages = pages_with_dates | sort: 'last_modified_at' | reverse %}
      {% assign grouped_pages = sorted_pages | group_by_exp: "item", "item.last_modified_at | date: '%Y-%m'" %}
      
      {% for year_month in grouped_pages %}
        {% assign date_parts = year_month.name | split: "-" %}
        {% assign month_index = date_parts[1] | minus: 1 %}
        {% assign month_names = "January,February,March,April,May,June,July,August,September,October,November,December" | split: "," %}
        {% assign month_name = month_names[month_index] %}
        
        <h2>{{ month_name }} {{ date_parts[0] }}</h2>
        <ul class="page-list">
          {% for item in year_month.items %}
            {% if item.title and item.url != "/archive/" %}
              <li>
                <a href="{{ item.url | relative_url }}" class="no-arrow">{{ item.title | escape }}</a>
              </li>
            {% endif %}
          {% endfor %}
        </ul>
      {% endfor %}
    {% else %}
      <p>No pages found with last_modified_at metadata.</p>
    {% endif %}
  </div>

  <!-- Creation Date View (hidden by default) -->
  <div class="sort-view creation-date-view" style="display: none;">
    {% assign valid_pages = site.pages | where_exp: "item", "item.path != null" %}
    {% assign pages_with_dates = valid_pages | where_exp: "item", "item.date != nil" %}
    {% if pages_with_dates.size > 0 %}
      {% assign sorted_pages = pages_with_dates | sort: 'date' | reverse %}
      {% assign grouped_pages = sorted_pages | group_by_exp: "item", "item.date | date: '%Y-%m'" %}
      
      {% for year_month in grouped_pages %}
        {% assign date_parts = year_month.name | split: "-" %}
        {% assign month_index = date_parts[1] | minus: 1 %}
        {% assign month_names = "January,February,March,April,May,June,July,August,September,October,November,December" | split: "," %}
        {% assign month_name = month_names[month_index] %}
        
        <h2>{{ month_name }} {{ date_parts[0] }}</h2>
        <ul class="page-list">
          {% for item in year_month.items %}
            {% if item.title and item.url != "/archive/" %}
              <li>
                <a href="{{ item.url | relative_url }}" class="no-arrow">{{ item.title | escape }}</a>
              </li>
            {% endif %}
          {% endfor %}
        </ul>
      {% endfor %}
    {% else %}
      <p>No pages found with date metadata.</p>
    {% endif %}
  </div>

  <!-- Name View (hidden by default) -->
  <div class="sort-view name-view" style="display: none;">
    {% assign valid_pages = site.pages | where_exp: "item", "item.title != nil" %}
    {% assign sorted_pages = valid_pages | sort: 'title' %}
    {% if sorted_pages.size > 0 %}
      {% assign first_chars = "" | split: "" %}
      {% for item in sorted_pages %}
        {% if item.title and item.url != "/archive/" %}
          {% assign first_char = item.title | slice: 0, 1 | upcase %}
          {% unless first_chars contains first_char %}
            {% assign first_chars = first_chars | push: first_char %}
          {% endunless %}
        {% endif %}
      {% endfor %}
      {% assign first_chars = first_chars | sort %}
      
      {% for letter in first_chars %}
        <h2>{{ letter }}</h2>
        <ul class="page-list">
          {% for item in sorted_pages %}
            {% if item.title and item.url != "/archive/" %}
              {% assign page_first_letter = item.title | slice: 0, 1 | upcase %}
              {% if page_first_letter == letter %}
                <li>
                  <a href="{{ item.url | relative_url }}" class="no-arrow">{{ item.title | escape }}</a>
                </li>
              {% endif %}
            {% endif %}
          {% endfor %}
        </ul>
      {% endfor %}
    {% else %}
      <p>No pages found.</p>
    {% endif %}
  </div>
</div>

<style>
  .archive-container {
    max-width: 800px;
    margin: 0 auto;
    padding: 20px;
  }
  
  .sort-options {
    margin-bottom: 30px;
    font-size: 1.1em;
  }
  
  .sort-option {
    text-decoration: none;
    cursor: pointer;
    color: #1a73e8;
  }
  
  .sort-option.active {
    font-weight: bold;
    text-decoration: underline;
  }
  
  h2 {
    margin-top: 30px;
    padding-bottom: 10px;
    border-bottom: 1px solid #eaeaea;
  }
  
  .page-list {
    list-style: none;
    padding-left: 0;
  }
  
  .page-list li {
    margin-bottom: 0px;
  }
  
  .page-date {
    color: #666;
    font-size: 0.9em;
    margin-right: 10px;
  }
</style>

<script>
  window.addEventListener('load', function() {
    const sortOptions = document.querySelectorAll('.sort-option');
    const sortViews = document.querySelectorAll('.sort-view');
    
    sortOptions.forEach(option => {
      option.addEventListener('click', function(e) {
        e.preventDefault();
        
        // Update active class
        sortOptions.forEach(opt => opt.classList.remove('active'));
        this.classList.add('active');
        
        // Show the appropriate view
        const sortType = this.getAttribute('data-sort');
        sortViews.forEach(view => {
          if (view.classList.contains(sortType + '-view')) {
            view.style.display = 'block';
          } else {
            view.style.display = 'none';
          }
        });
      });
    });
  });
</script>

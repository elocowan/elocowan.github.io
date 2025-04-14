---
layout: page
title: Archive
permalink: /archive/
---
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
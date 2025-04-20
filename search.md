---
layout: default
title: Search
menu: main
permalink: /search/
---

<div id="search-container">
  <input type="text" id="search-input" placeholder="Search...">
  <button id="search-button">Search</button>
  <div id="results-container"></div>
</div>

<script src="https://unpkg.com/lunr/lunr.js"></script>
<script>
document.addEventListener('DOMContentLoaded', function() {
  // Fetch the search index
  fetch('/search.json')
    .then(response => {
      if (!response.ok) {
        throw new Error(`HTTP error! Status: ${response.status}`);
      }
      return response.json();
    })
    .then(data => {
      console.log("Search data loaded successfully");
      
      // Initialize lunr with the data
      const idx = lunr(function() {
        this.ref('url');
        this.field('title', { boost: 10 });
        this.field('content');
        
        data.forEach(doc => {
          this.add(doc);
        });
      });
      
      // Get DOM elements
      const searchInput = document.getElementById('search-input');
      const searchButton = document.getElementById('search-button');
      const resultsContainer = document.getElementById('results-container');
      
      // Function to extract context around search term
      function getContextAroundTerm(text, term, contextSize = 75) {
        const lowerText = text.toLowerCase();
        const lowerTerm = term.toLowerCase();
        
        const index = lowerText.indexOf(lowerTerm);
        if (index === -1) return text.substring(0, 150) + '...'; // Term not found, return beginning
        
        // Calculate start and end indices for the context
        let start = Math.max(0, index - contextSize);
        let end = Math.min(text.length, index + term.length + contextSize);
        
        // Add ellipsis if needed
        const prefix = start > 0 ? '...' : '';
        const suffix = end < text.length ? '...' : '';
        
        return prefix + text.substring(start, end) + suffix;
      }
      
      // Function to highlight the search term in text
      function highlightTerm(text, term) {
        if (!term) return text;
        
        // Escape special regex characters in the term
        const escapedTerm = term.replace(/[.*+?^${}()|[\]\\]/g, '\\$&');
        
        // Create a regular expression that matches the term in a case-insensitive way
        const regex = new RegExp(`(${escapedTerm})`, 'gi');
        
        // Replace occurrences with a highlighted version
        return text.replace(regex, '<span class="highlight">$1</span>');
      }
      
      // Function to perform search
      function performSearch() {
        const query = searchInput.value;
        
        if (!query) {
          resultsContainer.innerHTML = '<p class="search-no-results">Please enter a search term</p>';
          return;
        }
        
        try {
          const results = idx.search(query);
          
          // Clear results
          resultsContainer.innerHTML = '';
          
          if (results.length === 0) {
            resultsContainer.innerHTML = '<p class="search-no-results">No results found</p>';
            return;
          }
          
          // Display results
          results.forEach(result => {
            const item = data.find(item => item.url === result.ref);
            
            // Create result container
            const resultDiv = document.createElement('div');
            resultDiv.className = 'search-result';
            
            // Create title with link
            const titleElement = document.createElement('h3');
            const titleLink = document.createElement('a');
            titleLink.href = item.url;
            titleLink.innerHTML = highlightTerm(item.title, query);
            titleElement.appendChild(titleLink);
            
            // Create content preview with term in context
            const contextText = getContextAroundTerm(item.content, query);
            const contentPreview = document.createElement('p');
            contentPreview.innerHTML = highlightTerm(contextText, query);
            
            // Append elements to result div
            resultDiv.appendChild(titleElement);
            resultDiv.appendChild(contentPreview);
            
            // Append to results container
            resultsContainer.appendChild(resultDiv);
          });
        } catch (error) {
          console.error("Search error:", error);
          resultsContainer.innerHTML = '<p class="search-no-results">Error performing search</p>';
        }
      }
      
      // Listen for input changes (for real-time search)
      searchInput.addEventListener('input', performSearch);
      
      // Listen for button click
      searchButton.addEventListener('click', performSearch);
      
      // Listen for Enter key
      searchInput.addEventListener('keypress', function(e) {
        if (e.key === 'Enter') {
          performSearch();
        }
      });
    })
    .catch(error => {
      console.error("Error loading search index:", error);
      document.getElementById('results-container').innerHTML = 
        '<p class="search-no-results">Error loading search index. See console for details.</p>';
    });
});
</script>

<style>
  #search-container {
    margin: 2rem 0;
  }
  
  #search-input {
    width: 70%;
    padding: 0.5rem;
    font-size: 1rem;
    border: 1px solid #ccc;
    border-radius: 4px;
  }
  
  #search-button {
    padding: 0.5rem 1rem;
    background-color: #007bff;
    color: white;
    border: none;
    border-radius: 4px;
    cursor: pointer;
    margin-left: 0.5rem;
  }
  
  #search-button:hover {
    background-color: #0056b3;
  }
  
  #results-container {
    margin-top: 1.5rem;
  }
  
  .search-result {
    margin-bottom: 1.5rem;
    padding: 1rem;
    border-bottom: 1px solid #eee;
  }
  
  .search-result h3 {
    margin: 0 0 0.5rem 0;
  }
  
  .search-result p {
    margin: 0;
    color: #555;
    line-height: 1.5;
  }
  
  .search-no-results {
    color: #666;
    font-style: italic;
  }
  
  .highlight {
    background-color: #ffff99;
    padding: 0 2px;
    border-radius: 2px;
    font-weight: bold;
  }
</style>

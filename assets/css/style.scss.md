---
---

@import "{{ site.theme }}";

// Metadata styling
.metadata-divider {
  margin-top: 2rem;
  margin-bottom: 1rem;
  border: 0;
  height: 1px;
  background-color: #ddd;
}

.page-metadata {
  border-top: 3px solid red; 
  padding-top: 10px;
  font-size: 0.8rem;
  font-style: italic;
  color: #666;
  
  // Nested rule for date lines (Sass feature)
  .date-line {
    margin: 0;
    padding: 0;
    line-height: 1.4;
  }
}
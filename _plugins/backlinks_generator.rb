#
//  backlinks.rb
//  
//
//  Created by Ethan Cowan on 4/16/25.
//

class BacklinksGenerator < Jekyll::Generator
  def generate(site)
    puts "==== Backlinks Generator Starting ===="
    puts "Total pages: #{site.pages.size}"
    
    # Initialize empty backlinks array for all pages
    site.pages.each do |page|
      page.data['backlinks'] = []
      puts "Initialized backlinks for: #{page.url}"
    end
    
    # Find all backlinks
    site.pages.each do |page|
      puts "Checking links from: #{page.url}"
      source_url = page.url
      source_title = page.data['title'] || "Untitled"
      
      # Extract all links from the page content
      content = page.content.to_s
      # A very simple regex to find links (will be refined in future steps)
      links = content.scan(/\(([^)]+)\)/).flatten
      
      links.each do |link|
        puts "  Found link: #{link}"
        # Clean up the link
        link = link.strip
        
        # Find the target page
        target_page = site.pages.find do |p|
          p.url == link || p.url == link + '/' || p.url == link + '.html'
        end
        
        if target_page && target_page != page
          puts "  This is a link to: #{target_page.url}"
          target_page.data['backlinks'] << {
            'url' => source_url,
            'title' => source_title
          }
        end
      end
    end
    
    # Print backlinks summary
    site.pages.each do |page|
      if page.data['backlinks'].size > 0
        puts "Page #{page.url} has #{page.data['backlinks'].size} backlinks"
      end
    end
    puts "==== Backlinks Generator Complete ===="
  end
end

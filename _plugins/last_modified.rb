#
//  last_modified.rb
//  
//
//  Created by Ethan Cowan on 4/21/25.
//

require 'time'

module Jekyll
  class LastModifiedTag < Liquid::Tag
    def initialize(tag_name, path, tokens)
      super
      @path = path.strip
    end

    def render(context)
      site = context.registers[:site]
      page = context.registers[:page]
      path = page["path"]

      return "" if path.nil?

      begin
        git_last_modified_time = `git log -1 --format="%ad" -- #{path}`
        git_last_modified_time.strip!
        
        # If git output is empty (file not in git), use file mtime
        if git_last_modified_time.empty?
          last_modified_time = File.mtime(path)
        else
          last_modified_time = Time.parse(git_last_modified_time)
        end
        
        # Format the time as requested or with default format
        format = site.config['date_format'] || "%B %-d, %Y"
        last_modified_time.strftime(format)
      rescue => e
        puts "Error getting last modified time for #{path}: #{e.message}"
        ""
      end
    end
  end
end

# This is the proper way to register a tag with Jekyll
Liquid::Template.register_tag('last_modified', Jekyll::LastModifiedTag)

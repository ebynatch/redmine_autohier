#require_dependency 'application_helper'


# ApplicationHelper
module Autohier
  module ApplicationHelperAh
    def self.included(base)
      base.send(:include, InstanceMethods)
      base.class_eval do |mod|
	alias_method :breadcrumb_without_autohier, :breadcrumb
	alias_method :breadcrumb, :breadcrumb_with_autohier
	alias_method :render_page_hierarchy_without_autohier, :render_page_hierarchy
	alias_method :render_page_hierarchy, :render_page_hierarchy_with_autohier
      end
    end
    
    module InstanceMethods  
      
      # Replacing the method render_page_hierarchy, which is
      # used for {{child_pages}} etc.
      # This version uses page.short_title instead of page.pretty_title
      def render_page_hierarchy_with_autohier(pages, node=nil, options={})
	content = ''
	if pages[node]
	  content << "<ul class=\"pages-hierarchy\">\n"
	  pages[node].each do |page|
	    content << "<li>"
	    content << link_to(h(page.short_title), {:controller => 'wiki', :action => 'show', :project_id => page.project, :id => page.title},
			       :title => (options[:timestamp] && page.updated_on ? l(:label_updated_time, distance_of_time_in_words(Time.now, page.updated_on)) : nil))
	    content << "\n" + render_page_hierarchy(pages, page.id, options) if pages[page.id]
	    content << "</li>\n"
	  end
	  content << "</ul>\n"
	end
	content.html_safe
      end

      # Our version of Breadcrumbs
      def breadcrumb_with_autohier(*args)
	elements = args.flatten
	elements.any? ? content_tag('p', (args.join('&gt;')+'&gt;'+@page.short_title).html_safe, :class=>'breadcrumb') : nil
      end
    end
  end
end

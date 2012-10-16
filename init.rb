require 'redmine'
require 'autohier/hook'

# Apply the wiki page patch
#require 'wiki_page_patch'

require 'dispatcher'
Dispatcher.to_prepare :redmine_autohier do
  unless WikiPage.included_modules.include? Autohier::WikiPageAh
    WikiPage.send(:include, Autohier::WikiPageAh)
  end

  unless ApplicationHelper.included_modules.include? Autohier::ApplicationHelperAh
    ApplicationHelper.send(:include, Autohier::ApplicationHelperAh)
  end
end


Redmine::Plugin.register :redmine_autohier do
  name 'Redmine Automatic Hierarchy plugin'
  author 'Shinya Maeyama'
  description <<HERE
Replaces Redmine's wiki hierarchy features with a more transparent one.
https://github.com/merikonjatta/redmine_autohier
HERE
  version '0.0.4'
  requires_redmine :version => ['1.4.0', '1.4.1', '1.4.2', '1.4.3', '1.4.4', '1.4.5', '1.4.6', '1.4.7', '1.4.8', '1.4.9']
end

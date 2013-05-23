require 'redmine'
require 'autohier/hook'

# Apply the wiki page patch
#require 'wiki_page_patch'

require 'dispatcher' unless Rails::VERSION::MAJOR >= 3

if Rails::VERSION::MAJOR >= 3
  ActionDispatch::Callbacks.to_prepare do
    unless WikiPage.included_modules.include? Autohier::WikiPageAh
      WikiPage.send(:include, Autohier::WikiPageAh)
    end
    unless ApplicationHelper.included_modules.include? Autohier::ApplicationHelperAh
      ApplicationHelper.send(:include, Autohier::ApplicationHelperAh)
    end
  end
else
  Dispatcher.to_prepare :redmine_autohier do
    unless WikiPage.included_modules.include? Autohier::WikiPageAh
      WikiPage.send(:include, Autohier::WikiPageAh)
    end
    unless ApplicationHelper.included_modules.include? Autohier::ApplicationHelperAh
      ApplicationHelper.send(:include, Autohier::ApplicationHelperAh)
    end
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
end

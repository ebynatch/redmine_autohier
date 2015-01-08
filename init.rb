require 'redmine'
require 'autohier_hook'

# Apply the wiki page patch
#require 'wiki_page_patch'

require 'dispatcher' unless Rails::VERSION::MAJOR >= 3

if Rails::VERSION::MAJOR >= 3
  ActionDispatch::Callbacks.to_prepare do
      require_dependency 'wiki_page'
      WikiPage.send(:include, WikiPagePatch)
      require_dependency 'application_helper'
      ApplicationHelper.send(:include, ApplicationHelperPatch)
  end
else
  Dispatcher.to_prepare :redmine_autohier do
      require_dependency 'wiki_page'
      WikiPage.send(:include, WikiPagePatch)
      require_dependency 'application_helper'
      ApplicationHelper.send(:include, ApplicationHelperPatch)
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

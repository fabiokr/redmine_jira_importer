require 'redmine'

Redmine::Plugin.register :redmine_jira_importer do
  name 'Redmine Jira Importer plugin'
  author 'Fabio Kreusch'
  author_url 'http://www.kreusch.com.br'
  description 'Allows a user to import tickets from Jira'
  version '0.0.1'
end

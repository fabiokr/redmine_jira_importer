require 'rexml/document'

class JiraImporter

	def initialize(file, attributes = {})
    @file = file
    @attributes = attributes
    @doc = REXML::Document.new(file)
  end

  def to_issues
    issues = []

    @doc.elements.each('rss/channel/item') do |item|
      issue = Issue.new(@attributes)
      issue.subject = item.elements['title'].text
      issue.description = item.elements['description'].text
      issues << issue
    end

    issues
  end

end

require File.dirname(__FILE__) + '/../test_helper'
require 'jira_importer'

class ImporterTest < ActiveSupport::TestCase

  fixtures :projects, :versions, :users, :roles, :members, :member_roles, :issues, :journals, :journal_details,
           :trackers, :projects_trackers, :issue_statuses, :enabled_modules, :enumerations, :boards, :messages,
           :attachments, :custom_fields, :custom_values, :time_entries

  def setup
    @file = File.open('vendor/plugins/redmine_jira_importer/test/unit/jira_sample.xml', 'r')
    @tracker, @status, @priority = Tracker.find(:first), IssueStatus.find(:first), IssuePriority.find(:first)
    @attributes = {:tracker_id => @tracker.id, :status_id => @status.id, :priority_id => @priority.id}
    @importer = JiraImporter.new(@file, @attributes)
  end

  def test_should_generate_valid_issues
    issues = @importer.to_issues

    assert_equal 2, issues.size
    assert_equal Issue.new(:tracker_id => @tracker.id, :status_id => @status.id, :priority_id => @priority.id, :subject => '[BUG-001] Bug number 1', :description => 'This is the bug number 1').attributes, issues[0].attributes
    assert_equal Issue.new(:tracker_id => @tracker.id, :status_id => @status.id, :priority_id => @priority.id, :subject => '[BUG-002] Bug number 2', :description => 'This is the bug number 2').attributes, issues[1].attributes
  end

end

require_dependency 'issue'
require_dependency 'watcher'

module Mention
  module IssueHook
    def self.included(base)
      base.send(:before_create) do |issue|
        mentioned_users = issue.description.scan(/@[\w.]+/)
        mentioned_users.each do |mentioned_user|
          username = mentioned_user[1..-1] # Remove the heading ':'
          if user = User.find_by_login(username)
            issue.set_watcher(user)
          end
        end
      end
    end
  end
end

Issue.send(:include, Mention::IssueHook) unless Issue.included_modules.include? Mention::IssueHook

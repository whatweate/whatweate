require 'slack-notifier'

class AdminMessenger
  def self.broadcast(message)
    new.broadcast(message)
  end

  def initialize
    @notifier = Slack::Notifier.new(
      Settings.slack.webhook_url,
      channel: ENV["SLACK_CHANNEL"],
      username: ENV["SLACK_USERNAME"],
      icon_url: ENV["SLACK_ICON_URL"]
    )
  end

  def broadcast(message)
    @notifier.ping(message)
  end
end

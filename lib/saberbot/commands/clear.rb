# SaberBot by Alex Taber and Megumi Sonoda
# Copyright 2016 Alex Taber, Megumi Sonoda
# This file is licensed under the MIT License

module SaberBot
  module Command
    # !clear [x] messages from the channel.
    module Clear
      extend Discordrb::Commands::CommandContainer
      command(
        :clear,
        description: 'Clear x messages. Staff only.',
        permission_level: 1,
        min_args: 1
      ) do |event, amount|
        break if event.channel.private?
        begin
          event.channel.prune(amount.to_i)
          SaberConfig.server_channels[event.server][SaberConfig.settings['modlog_channel']].send(
            "**Messages Cleared:** #{amount} in #{event.channel.mention}\n" \
            "**Responsible Moderator:** #{event.message.author.mention}"
          )
        rescue ArgumentError
          "Invalid amount \"#{amount}\". Expected a number between 2 and 100."
        end
      end
    end
  end
end

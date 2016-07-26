# SaberBot by Alex Taber and Megumi Sonoda
# Copyright 2016 Alex Taber, Megumi Sonoda
# This file is licensed under the MIT License

require 'discordrb'
require 'thread'
require 'yaml'
require 'date'
require 'chronic_duration'
require 'sequel'

# Bot configuration and saved staff roles for sudo, also saved bans
require_relative 'saberbot/config'

SaberConfig.settings = SaberConfig.read_yml('config.yml')

if SaberConfig.settings == {}
  puts 'Config is empty! Please fix.'
  exit
end

SaberConfig.roles = SaberConfig.read_yml('staff.yml')
SaberConfig.bans = SaberConfig.read_yml('bans.yml')
SaberConfig.mutes = SaberConfig.read_yml('mutes.yml')
SaberConfig.noembeds = SaberConfig.read_yml('noembeds.yml')
SaberConfig.friendcodes = SaberConfig.read_database('friendcodes.sql')[:friendcodes]

# Provide method for graceful shutdown
require_relative 'saberbot/botexit'

# SaberBot commands and event handlers
require_relative 'saberbot/commands'
require_relative 'saberbot/events'

# Require loops
require_relative 'saberbot/loops'

# Ban stuff
require_relative 'saberbot/bancheck'
require_relative 'saberbot/timeparse'

# Main logic
require_relative 'saberbot/main'

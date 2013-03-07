# Use this file to easily define all of your cron jobs.
#
# It's helpful, but not entirely necessary to understand cron before proceeding.
# http://en.wikipedia.org/wiki/Cron

# Example:
#
# set :output, "/path/to/my/cron_log.log"
#
# every 2.hours do
#   command "/usr/bin/some_great_command"
#   runner "MyModel.some_method"
#   rake "some:great:rake:task"
# end
#
# every 4.days do
#   runner "AnotherModel.prune_old_records"
# end

# every '1 * * * *' do
#   command "puts 'you can use raw cron syntax too'"
# end


# Essai d'affichage toute les secondes dans WinCmd	[FAIL]
# every 1.seconds do
# 	command "ECHO Test"
# end

# Essai de jouer le "beep" Windows	[FAIL]
# every 5.seconds do
# 	command "ECHO START/min mplay32 /play /close %windir%\media\ding.wav"
# end

# Essai avec syntaxe PowerShell		[FAIL]
# every 5.seconds do
# 	command "Write-Host 'Test'"
# end


# Learn more: http://github.com/javan/whenever
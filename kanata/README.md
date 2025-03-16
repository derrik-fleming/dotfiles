# KMonad Config

Future self,

This is running as a LaunchDaemon because it required root.

You can find the configuration property list at:

`/Library/LaunchDaemons/com.user.kmonad.plist`

In order to reload the configuration, you can run:

`sudo launchctl unload /Library/LaunchDaemons/com.user.kmonad.plist`

or

`sudo launchctl bootout system /Library/LaunchDaemons/com.user.kmonad.plist`

Followed by:

`sudo launchctl load /Library/LaunchDaemons/com.user.kmonad.plist`

or

`sudo launchctl bootstrap system /Library/LaunchDaemons/com.user.kmonad.plist`

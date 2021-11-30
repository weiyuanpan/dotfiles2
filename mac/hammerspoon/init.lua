hs.loadSpoon("SpoonInstall")
spoon.SpoonInstall.repos.ShiftIt = {
   url = "https://github.com/peterklijn/hammerspoon-shiftit",
   desc = "ShiftIt spoon repository",
   branch = "master",
}
spoon.SpoonInstall:andUse("ShiftIt", { repo = "ShiftIt" })

hs.loadSpoon("ShiftIt")
spoon.ShiftIt:bindHotkeys({
  left = {{ 'alt', 'cmd' }, 'left' },
  right = {{ 'alt', 'cmd' }, 'right' },
  up = {{ 'alt', 'cmd' }, 'up' },
  down = {{ 'alt', 'cmd' }, 'down' },
  upleft = {{ 'shift', 'alt', 'cmd' }, 'left' },
  upright = {{ 'shift', 'alt', 'cmd' }, 'right' },
  botleft = {{ 'shift', 'alt', 'cmd' }, 'down' },
  botright = {{ 'shift', 'alt', 'cmd' }, 'up' },
  maximum = {{  'alt', 'cmd' }, 'f' },
  toggleFullScreen = {{  'alt', 'cmd' }, 'm' },
  toggleZoom = {{  'alt', 'cmd' }, 'z' },
  center = {{  'alt', 'cmd' }, 'c' },
  nextScreen = {{  'alt', 'cmd' }, 'n' },
  previousScreen = {{  'alt', 'cmd' }, 'p' },
  resizeOut = {{  'alt', 'cmd' }, '=' },
  resizeIn = {{  'alt', 'cmd' }, '-' }
})

local VimMode = hs.loadSpoon('VimMode')
local vim = VimMode:new()

vim
  :disableForApp('Code')
  :disableForApp('MacVim')
  :disableForApp('zoom.us')
  :enterWithSequence('jk')

# atom-sticky-cursor package

Sticks cursor to the beginning/end of line if it was in the beginning/end of line when moving up/down/left/right (see gif below).

Add this to your keybindings:
```
'body':
  'down': 'sticky-cursor:move-down'
  'up': 'sticky-cursor:move-up'
  'left': 'sticky-cursor:move-left'
  'right': 'sticky-cursor:move-right'
 ```

![demo](https://raw.githubusercontent.com/pvorona/atom-sticky-cursor/master/ice_video_20160221-140842.gif)

**If You are using autocomplete-plus, You'll have to rebind it's movement commands.**

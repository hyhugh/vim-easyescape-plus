# vim-easyescape-plus

```
_____                  _____
 | ____|__ _ ___ _   _  | ____|___  ___ __ _ _ __   ___
 |  _| / _` / __| | | | |  _| / __|/ __/ _` | '_ \ / _ \            + (yeah the small plus is here)
 | |__| (_| \__ \ |_| | | |___\__ \ (_| (_| | |_) |  __/
 |_____\__,_|___/\__, | |_____|___/\___\__,_| .__/ \___|
                 |___/                      |_|
```
Make Escape Great Again!

Special thanks to (Yichao Zhou) the author of original vim-easyescape.

As you can see from the project name, this project is actually based on vim-easyescape. Since I modified the plugin a lot according to my personal preferences, I release this as a seperated plugin.

The essential motivation to modify the original plugin is such that
1. `vim-easyescape` is lack of the ability to map only 'kj' to escape (I don't want jk to be mapped to escape).
2. `vim-easyescape` is lack of the ability to empty a row which contains only spaces on exit (which is vim's default behaviour)

`<ESC>/<C-[>/<C-C>` is hard to press?  Try `vim-easyescape-plus`! `vim-easyescape-plus` makes exiting from insert mode easy and hesitation free.

## Problems
Traditionally, we need to use
```
inoremap kj <Esc>
```

so then we can press `kj` to exit the insert mode.  However, a problem with such map sequence is that Vim will pause whenever you type `k` in insert mode (it is waiting for the next key to determine whether to apply the mapping). The pause causes visual distraction which you cannot ignore (which drives me crazy)

`vim-easyescape-plus` does not have such problem and supports custom timeout.


## Installation
Use your favourite plugin manager. as for me I use `vim-plug`:
```
Plug "hyhugh/vim-easyescape-plus"
```

## Usage

### Configuration 1: map of `kj` (recommended since i use this one)

The unit of timeout is in ms.  A very small timeout makes an input of real `kj` possible (Python3 is required for this feature)!
```
let g:easyescape_string = "kj"
let g:easyescape_timeout = 100
```

## Dependency

Python3 is required if timeout (`g:easyescape_timeout`) is less than 2000 ms because vim does not provide a way to fetch sub-second time.

## Known problems

1. Does not work in command/visual mode (not yet implemented)
2. g:easyescape_string must have the length of 2
3. Does not support "jj" mapping, you have to use two different characters as the escape string

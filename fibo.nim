## A Fibonacci 12-hour clock in Nim using SDL2

import sdl2, times, os, tables, random

discard sdl2.init(INIT_EVERYTHING)

var
  window: WindowPtr
  render: RendererPtr

window = createWindow("fibo", 100, 100, 800, 500, SDL_WINDOW_SHOWN)
render = createRenderer(window, -1, Renderer_Accelerated or
    Renderer_PresentVsync or Renderer_TargetTexture)

var
  evt = sdl2.defaultEvent
  runGame = true
  r: Rect
  oldmin = -1
  t: Table[int, seq[string]]
  v: int
  tt, hl, ml: string

randomize()

for i1 in 0..1:
  for i2 in 0..1:
    for i3 in 0..1:
      for i4 in 0..1:
        for i5 in 0..1:
          tt = char(i1 + 48) & char(i2 + 48) & char(i3 + 48) & char(i4 + 48) &
              char(i5 + 48)
          v = i1 + i2 + 2 * i3 + 3 * i4 + 5 * i5
          if not t.hasKey(v):
            t[v] = @[]
          t[v].add(tt)

proc setcol(i: int) =
  if hl[i] == '1' and ml[i] == '1':
    render.setDrawColor(0, 0, 255, 255)
  elif hl[i] == '1' and ml[i] == '0':
    render.setDrawColor(255, 0, 0, 255)
  elif hl[i] == '0' and ml[i] == '1':
    render.setDrawColor(0, 255, 0, 255)
  else:
    render.setDrawColor(0, 0, 0, 255)

while runGame:
  let
    d = now()
    h = d.hour
    m = d.minute
    mm = d.minute div 5

  var hh: int
  if h > 12:
    hh = h - 12
  elif h == 0:
    hh = 12
  else:
    hh = h

  while pollEvent(evt):
    if evt.kind == QuitEvent:
      runGame = false
      break
  render.setDrawColor(0, 0, 0, 255)
  render.clear

  if m != oldmin:
    oldmin = m
    hl = t[hh][rand(len(t[hh]) - 1)]
    ml = t[mm][rand(len(t[mm]) - 1)]

  r.w = 80
  r.h = 80
  r.x = 210
  r.y = 10
  setcol(0)
  render.fillRect(r)

  r.x = 210
  r.y = 110
  setcol(1)
  render.fillRect(r)

  r.w = 180
  r.h = 180
  r.x = 10
  r.y = 10
  setcol(2)
  render.fillRect(r)

  r.w = 280
  r.h = 280
  r.x = 10
  r.y = 210
  setcol(3)
  render.fillRect(r)

  r.w = 480
  r.h = 480
  r.x = 310
  r.y = 10
  setcol(4)
  render.fillRect(r)

  render.present
  sleep(100)

destroy render
destroy window


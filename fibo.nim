## A Fibonacci 12-hour clock in Nim using SDL2

import sdl2, times, tables, random

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
  pal = 5 # default palette entry

        # old default, plus 10 color palettes from https://github.com/pchretien/fibo/blob/master/fibonacci.ino
let
  hpal = [(255, 0, 0),
          (255, 10, 10),
          (255, 10, 10),
          (80, 40, 0),
          (245, 100, 201),
          (255, 123, 123),
          (212, 49, 45),
          (209, 62, 200),
          (237, 20, 20),
          (70, 35, 0),
          (211, 34, 34)]
  mpal = [(0, 255, 0),
          (10, 255, 10),
          (248, 222, 0),
          (20, 200, 20),
          (114, 247, 54),
          (143, 255, 112),
          (145, 210, 49),
          (69, 232, 224),
          (246, 243, 54),
          (70, 122, 10),
          (80, 151, 78)]
  bpal = [(0, 0, 255),
          (10, 10, 255),
          (10, 10, 255),
          (255, 100, 10),
          (113, 235, 219),
          (120, 120, 255),
          (141, 95, 224),
          (80, 70, 202),
          (255, 126, 21),
          (200, 182, 0),
          (16, 24, 149)]
  opal = [(0, 0, 0),
          (255, 255, 255),
          (255, 255, 255),
          (255, 255, 255),
          (255, 255, 255),
          (255, 255, 255),
          (255, 255, 255),
          (255, 255, 255),
          (255, 255, 255),
          (255, 255, 255),
          (255, 255, 255)]

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
    render.setDrawColor(cast[uint8](bpal[pal][0]),
                           cast[uint8](bpal[pal][1]),
                           cast[uint8](bpal[pal][2]))
  elif hl[i] == '1' and ml[i] == '0':
    render.setDrawColor(cast[uint8](hpal[pal][0]),
                           cast[uint8](hpal[pal][1]),
                           cast[uint8](hpal[pal][2]))
  elif hl[i] == '0' and ml[i] == '1':
    render.setDrawColor(cast[uint8](mpal[pal][0]),
                           cast[uint8](mpal[pal][1]),
                           cast[uint8](mpal[pal][2]))
  else:
    render.setDrawColor(cast[uint8](opal[pal][0]),
                           cast[uint8](opal[pal][1]),
                           cast[uint8](opal[pal][2]))

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
    if evt.kind == KeyDown and evt.key.keysym.sym == K_SPACE:
      inc pal
      if pal > len(opal) - 1:
        pal = 0

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
  delay(100)

destroy render
destroy window


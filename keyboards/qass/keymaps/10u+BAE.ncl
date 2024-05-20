let { tap, hold, .. } = import "fak/keycode.ncl" in

# This Keymap is targeted at macOS

# We alias commonly used stuff, so we don't end up repeating them over and over.
let kc = tap.reg.kc in
let md = tap.reg.mod in
let me = tap.custom.media in
let MO = hold.reg.layer in
let BOOT = tap.custom.fak.BOOT in
let XXXX = tap.none & hold.none in
let TTTT = tap.trans & hold.trans in

# "cu" for custom keys. This is just a name, so it can be whatever you want.
let cu = {
  # Again, these are just names. They don't have to be 4-letter or capitalized.
  COPY = md.lgui & kc.C,
  PSTE = md.lgui & kc.V,
  CUT =  md.lgui & kc.X,
  CLOS = md.lgui & kc.Q,
  VOLU = md.lalt & md.lsft & me.VOLU, #fine grain volume for macOS
  VOLD = md.lalt & md.lsft & me.VOLD, #fine grain volume for macOS
  SCSH = tap.reg.mod.lctl & kc.E, # Screenshot
  } in
  
  # 1 tap = play/pause. 2 taps = next track. 3 taps = prev track.
  let play_td = td.make 200 [
    me.PLAY,
    me.NEXT,
    me.PREV,
  ] in
  
  # The following keycode is a hold-tap, since it has a tap and a hold portion
  # Important: All hold-taps need to have a behavior bound with `hold.reg.behavior`
  let space_td = 
    tap.reg.kc.SPC
    & hold.reg.layer1
    & hold.reg.behavior {
      timeout_ms = 150
      # This will resolve as a hold after 150ms regardless of other keys pressed.
      # However, if released before the 150ms is up, it will resolve as a tap.
    }
  in
  


# --- Actual keymap ----

# Keymap definition for use with BAE and 10u space
# Because of the little available pins of the Miao the matrix is not straight forward at all
# With a QWERTY layout in mind:
# ISO-Enter: M74 = Enter = right of P, M24 = key right of L is also available
# Long Shift: M14 = right most key = Shift (also in short shift), M34 = key below L is unavailble with Long Shift
# ANSI-Enter: M74 = right of P = Backspace, M24 = right of L = Enter
# BA-Enter: M74 = right of P = Enter, M24 = right of L = tap.none, dont use, will also be pressed by the BAE
# Space: 10u = Split right = M43, Split left = M33

{
virtual_keys = [ #COMBOS
  # Combo activated by the first and second physical keys
  # The first argument is the timeout_ms (up to 255)
  # The second argument is the key indices/positions (min 2, max 9 keys)
  combo.make 35 [17, 18], # Backspace # Combo activated by the 18th and 19th (j + k on qwerty) physical keys, start counting at 0
  combo.make 35 [17, 18, 19], # Backspace word
  combo.make 35 [0, 1], # TAB
  combo.make 35 [11, 12], # ESC
  combo.make 35 [21, 22], # Cut
  combo.make 35 [22, 23], # Copy
  combo.make 35 [23, 24], # Paste
],

  layers = [
    [ # layer 0
      kc.Q,    kc.W,    kc.E,    kc.R,    kc.T,    kc.Y,    kc.U,    kc.I,    kc.O,    kc.P,    kc.ENTER,  #0-10
      kc.A,    kc.S,    kc.D,    kc.F,    kc.G,    kc.H,    kc.J,    kc.K,    kc.L,    XXXX,               #11-20
      kc.Z,    kc.X,    kc.C,    kc.V,    kc.B,    kc.N,    kc.M,    kc.",",  kc.".",  kc."/",             #21-30
      XXXX,    XXXX,    XXXX,    XXXX,    kc." ",  XXXX,    XXXX,    XXXX,                                 #31-38
      
      # Combos start here in the same order we defined them above
      kc.BSPC, #JK
      md.lalt & kc.BSPC, #JKL
      kc.TAB,
      kc.ESC,
      cu.CUT,
      cu.COPY,
      cu.PSTE
    ],
    [ # layer 1
      BOOT,    XXXX,    XXXX,    XXXX,    XXXX,    XXXX,    kc.N7,   kc.N8,   kc.N9,   XXXX,    kc.ENTER,
      md.lgui, md.lalt, md.lctl, md.lsft, XXXX,    XXXX,    kc.N4,   kc.N5,   kc.N6,   XXXX,
      XXXX,    XXXX,    XXXX,    XXXX,    XXXX,    kc.N0,   kc.N1,   kc.N2,   kc.N3,   XXXX,
      XXXX,    XXXX,    XXXX,    TTTT,    XXXX,    XXXX,    XXXX,    XXXX,
      TTTT,
      TTTT,
      TTTT,
      TTTT,
      TTTT,
      TTTT,
      TTTT,
    ],
  ],
}
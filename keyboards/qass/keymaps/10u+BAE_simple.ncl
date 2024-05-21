let { tap, hold, td, combo, .. } = import "fak/keycode.ncl" in

# --This Keymap is targeted at macOS---

# We alias commonly used stuff, so we don't end up repeating them over and over.
let kc = tap.reg.kc in
let ks = tap.reg.ks in
let md = hold.reg.mod in
let tm = tap.reg.mod in
let me = tap.custom.media in
let MO = hold.reg.layer in
let BOOT = tap.custom.fak.BOOT in
let XXXX = tap.none & hold.none in
let TTTT = tap.trans & hold.trans in

# "cu" for custom keys. This is just a name, so it can be whatever you want.
let cu = {
  # Again, these are just names. They don't have to be 4-letter or capitalized.
  COPY = tm.lgui & kc.C,
  PSTE = tm.lgui & kc.V,
  CUT =  tm.lgui & kc.X,
  CLOS = tm.lgui & kc.Q,
  VOLU = tm.lalt & tm.lsft & me.VOLU, #fine grain volume for macOS
  VOLD = tm.lalt & tm.lsft & me.VOLD, #fine grain volume for macOS
  SCSH = tm.lctl & kc.E, # Screenshot
  LSTZ = md.lsft & kc.Z & hold.reg.behavior, # Left shift hold + Z
  RST- = md.rsft & kc.SLSH & hold.reg.behavior, # Right shift hold + slash
  } in
  
 # HomeRowMods
 let hrm = {
 A = md.lsft & kc.A & hold.reg.behaviour, #Home Row Mod A
 S = md.lctl & kc.S & hold.reg.behaviour, #Home Row Mod A
 D = md.lalt & kc.D & hold.reg.behaviour, #Home Row Mod A
 F = md.lgui & kc.F & hold.reg.behaviour, #Home Row Mod A
 J = md.rgui & kc.J & hold.reg.behaviour, #Home Row Mod A
 K = md.ralt & kc.K & hold.reg.behaviour, #Home Row Mod A
 L = md.rctl & kc.L & hold.reg.behaviour, #Home Row Mod A
 BAE = md.rsft & kc.ENTER & hold.reg.behaviour, #Home Row Mod A
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
  & hold.reg.layer 1
  & hold.reg.behavior {
    timeout_ms = 150
    # This will resolve as a hold after 150ms regardless of other keys pressed.
    # However, if released before the 150ms is up, it will resolve as a tap.
  }
  in

# --- Combos ---
  let virtual_keys' = [
  # The first argument is the timeout_ms (up to 255)
  # The second argument is the key indices/positions (min 2, max 9 keys)
  combo.make 35 [17, 18],       # Backspace, Combo activated by the 18th and 19th (j + k on qwerty) physical keys, start counting at 0
  combo.make 35 [17, 18, 19],   # Backspace word
  combo.make 35 [18, 19],       # Delete
  combo.make 35 [0, 1],         # TAB
  combo.make 35 [11, 12],       # ESC
  combo.make 35 [21, 22],       # Cut
  combo.make 35 [22, 23],       # Copy
  combo.make 35 [23, 24],       # Paste
  ] in  
  

# Keymap definition
{
virtual_keys = virtual_keys',
  layers = [
    [
      kc.Q,    kc.W,    kc.E,    kc.R,    kc.T,    kc.Y,    kc.U,    kc.I,    kc.O,    kc.P,    hrm.BAE,        #0-10
      hrm.A,    hrm.S,    hrm.D,    hrm.F,    kc.G,    kc.H,    hrm.J,    hrm.K,    hrm.L,    XXXX,             #11-20
      cu.LSTZ,    kc.X,    kc.C,    kc.V,    kc.B,    kc.N,    kc.M,    kc.",",  kc.".",  cu.RST-,              #21-30
      XXXX,    XXXX,    XXXX,    XXXX,    space_td,  XXXX,    XXXX,    XXXX,                                    #31-38
      
      # Combos start here in the same order we defined them above
      kc.BSPC, #JK
      tm.lalt & kc.BSPC, #JKL - not yet working in FAK
      kc.DEL,  #KL
      kc.TAB,  #QW
      kc.ESC,  #AS
      cu.CUT,  #YX
      cu.COPY, #XC
      cu.PSTE, #CV
    ],
    [
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
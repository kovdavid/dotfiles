#include "keymap.h"
#include "combos.h"

// https://github.com/aleksbrgt/qmk_firmware/blob/corne_combos/keyboards/crkbd/keymaps/5col/keymap.c

#define LDEFAULT 0
#define LNUM 1
#define LNAV 3
#define LGUI 4

#define OSM_SHFT  OSM(MOD_LSHIFT)
#define OSM_CTRL  OSM(MOD_LCTRL)
#define OSM_ALT   OSM(MOD_LALT)
#define OSM_GUI   OSM(MOD_LGUI)

#define CTRL_ESC  D(MOD_LCTRL, KC_ESCAPE)
#define SHIFT_SPC D(MOD_LSHIFT, KC_SPACE)
#define SHFT_INS  LSHIFT(KC_INS)

// i3 navigation
#define GUI_F13  LGUI(KC_F13)
#define GUI_F14  LGUI(KC_F14)
#define GUI_PGUP LGUI(KC_PGUP)
#define GUI_PGDN LGUI(KC_PGDN)

#define LNUM_TAB    DL(LNUM, KC_TAB)
#define LNAV_ENT    DSL(LNAV, KC_ENTER)
#define LNAV_SCOLON DSL(LNAV, KC_SEMICOLON)
#define LGUI_SLASH  DSL(LGUI, KC_SLASH)

    /* Combos
           0        1        2        3        4        5          6        7        8        9        10       11
       ┌────────┬────────┬────────┬────────┬────────┐                   ┌────────┬────────┬────────┬────────┬────────┐
     0 │        │        │        │        │        │                   │        │        │        │        │        │
       │        │        │        │        │        │                   │        │        │        │        │        │
       ├────────┼────────┼────────┼────────┼────────┤                   ├────────┼────────┼────────┼────────┼────────┤
     1 │        │     *GUI*    *SHIFT*     │        │                   │        │      *CTRL*   *ALT*      │        │
       │        │     *GUI   *  SHIFT*     │        │                   │        │      *CTRL  *  ALT*      │        │
       ├────────┼────────┼────────┼────────┼────────┤                   ├────────┼────────┼────────┼────────┼────────┤
     2 │        │        │        │        │        │                   │        │        │        │        │        │
       │        │        │        │        │        │                   │        │        │        │        │        │
       ├────────┼────────┼────────┼────────┼────────┼────────┐ ┌────────┼────────┼────────┼────────┼────────┼────────┤
     3 │        │        │        │        │        │        │ │        │        │        │        │        │        │
       │        │        │        │        │        │        │ │        │        │        │        │        │        │
       └────────┴────────┴────────┴────────┴────────┴────────┘ └────────┴────────┴────────┴────────┴────────┴────────┘
     */

const KeyCoords combo1[] PROGMEM = { { 1, 1 }, { 1, 2 }           };
const KeyCoords combo2[] PROGMEM = {           { 1, 2 }, { 1, 3 } };
const KeyCoords combo3[] PROGMEM = { { 1, 1 }, { 1, 2 }, { 1, 3 } };

const KeyCoords combo4[] PROGMEM = { { 1, 8 }, { 1, 9 }            };
const KeyCoords combo5[] PROGMEM = {           { 1, 9 }, { 1, 10 } };
const KeyCoords combo6[] PROGMEM = { { 1, 8 }, { 1, 9 }, { 1, 10 } };

const KeyCoords combo7[] PROGMEM = { { 3, 5 }, { 3, 6 } }; // CAPS_WORD

ComboState combos[] = COMBOS({
    COMBO(combo1, OSM(MOD_LGUI)),
    COMBO(combo2, OSM(MOD_LSHIFT)),
    COMBO(combo3, OSM(MOD_LGUI | MOD_LSHIFT)),

    COMBO(combo4, OSM(MOD_LCTRL)),
    COMBO(combo5, OSM(MOD_LALT)),
    COMBO(combo6, OSM(MOD_LCTRL | MOD_LALT)),

    COMBO(combo7, CAPS_WORD),
});

const uint32_t keymap[][KEYBOARD_ROWS][KEYBOARD_COLS] PROGMEM = KEYMAP({
    /* Layer DEFAULT
       ┌────────┬────────┬────────┬────────┬────────┬────────┐ ┌────────┬────────┬────────┬────────┬────────┬────────┐
       │   Q    │   W    │   E    │   R    │   T    │  Alt+  │ │  Alt+  │   Y    │   U    │   I    │   O    │   P    │
       │        │        │        │        │        │   A    │ │   S    │        │        │        │        │        │
       ├────────┼────────┼────────┼────────┼────────┼────────┤ ├────────┼────────┼────────┼────────┼────────┼────────┤
       │   A    │   S    │   D    │   F    │   G    │  Alt+  │ │  Alt+  │   H    │   J    │   K    │   L    │ L NAV  │
       │        │        │        │        │        │   Q    │ │   W    │        │        │        │        │   ;    │
       ├────────┼────────┼────────┼────────┼────────┼────────┤ ├────────┼────────┼────────┼────────┼────────┼────────┤
       │   Z    │   X    │   C    │   V    │   B    │  Alt+  │ │  Alt+  │   N    │   M    │   ,    │   .    │ L GUI  │
       │        │        │        │        │        │   1    │ │   2    │        │        │        │        │   /    │
       ├────────┼────────┼────────┼────────┼────────┼────────┤ ├────────┼────────┼────────┼────────┼────────┼────────┤
       │  OSM   │  OSM   │        │  CTRL  │ SHIFT  │ L NUM  │ │ BSPACE │ L NAV  │ DELETE │        │        │  LHT   │
       │  CTRL  │  SHIFT │        │ ESCAPE │ SPACE  │   TAB  │ │        │ RETURN │        │        │        │  NAV   │
       └────────┴────────┴────────┴────────┴────────┴────────┘ └────────┴────────┴────────┴────────┴────────┴────────┘
     */
    LAYOUT_4x12(
        KC_Q,      KC_W,      KC_E,     KC_R,      KC_T,       LALT(KC_A),  /**/  LALT(KC_S),  KC_Y,      KC_U,       KC_I,     KC_O,     KC_P,
        KC_A,      KC_S,      KC_D,     KC_F,      KC_G,       LALT(KC_Q),  /**/  LALT(KC_W),  KC_H,      KC_J,       KC_K,     KC_L,     LNAV_SCOLON,
        KC_Z,      KC_X,      KC_C,     KC_V,      KC_B,       LALT(KC_1),  /**/  LALT(KC_2),  KC_N,      KC_M,       KC_COMM,  KC_DOT,   LGUI_SLASH,
        OSM_CTRL,  OSM_SHFT,  XXXXXXX,  CTRL_ESC,  SHIFT_SPC,  LNUM_TAB,    /**/  KC_BSPC,     LNAV_ENT,  KC_DELETE,  XXXXXXX,  XXXXXXX,  LHT(LNAV),
    ),

    /* Layer NUM
       ┌────────┬────────┬────────┬────────┬────────┬────────┐ ┌────────┬────────┬────────┬────────┬────────┬────────┐
       │        │        │        │        │        │        │ │        │   [    │   7    │   8    │   9    │   ]    │
       │        │        │        │        │        │        │ │        │⇧  {    │⇧  &    │⇧  *    │⇧  (    │⇧  }    │
       ├────────┼────────┼────────┼────────┼────────┼────────┤ ├────────┼────────┼────────┼────────┼────────┼────────┤
       │  GUI   │  SHIFT │  CTRL  │  ALT   │        │        │ │        │   =    │   4    │   5    │   6    │   '    │
       │        │        │        │        │        │        │ │        │⇧  +    │⇧  $    │⇧  %    │⇧  ^    │⇧  "    │
       ├────────┼────────┼────────┼────────┼────────┼────────┤ ├────────┼────────┼────────┼────────┼────────┼────────┤
       │        │        │        │        │        │        │ │        │   \    │   1    │   2    │   3    │   `    │
       │        │        │        │        │        │        │ │        │⇧  |    │⇧  !    │⇧  @    │⇧  #    │⇧  ~    │
       ├────────┼────────┼────────┼────────┼────────┼────────┤ ├────────┼────────┼────────┼────────┼────────┼────────┤
       │  OSM   │  OSM   │        │        │        │ L NUM  │ │ BSPACE │   0    │ DELETE │        │        │        │
       │  CTRL  │  SHIFT │        │        │        │   TAB  │ │        │⇧  )    │        │        │        │        │
       └────────┴────────┴────────┴────────┴────────┴────────┘ └────────┴────────┴────────┴────────┴────────┴────────┘
     */
    LAYOUT_4x12(
        XXXXXXX,   XXXXXXX,   XXXXXXX,  XXXXXXX,  XXXXXXX,  XXXXXXX,   /**/  XXXXXXX,  KC_LBRC,  KC_7,       KC_8,     KC_9,     KC_RBRC,
        KC_LGUI,   KC_LSFT,   KC_LCTL,  KC_LALT,  XXXXXXX,  XXXXXXX,   /**/  XXXXXXX,  KC_EQL,   KC_4,       KC_5,     KC_6,     KC_QUOT,
        XXXXXXX,   XXXXXXX,   XXXXXXX,  XXXXXXX,  XXXXXXX,  XXXXXXX,   /**/  XXXXXXX,  KC_BSLS,  KC_1,       KC_2,     KC_3,     KC_GRV,
        OSM_CTRL,  OSM_SHFT,  XXXXXXX,  XXXXXXX,  XXXXXXX,  LNUM_TAB,  /**/  KC_BSPC,  KC_0,     KC_DELETE,  XXXXXXX,  XXXXXXX,  XXXXXXX,
    ),

    /* Layer 3
       ┌────────┬────────┬────────┬────────┬────────┬────────┐ ┌────────┬────────┬────────┬────────┬────────┬────────┐
       │        │        │        │        │        │        │ │        │        │        │        │        │        │
       │        │        │        │        │        │        │ │        │        │        │        │        │        │
       ├────────┼────────┼────────┼────────┼────────┼────────┤ ├────────┼────────┼────────┼────────┼────────┼────────┤
       │        │        │        │        │        │        │ │        │        │        │        │        │        │
       │        │        │        │        │        │        │ │        │        │        │        │        │        │
       ├────────┼────────┼────────┼────────┼────────┼────────┤ ├────────┼────────┼────────┼────────┼────────┼────────┤
       │        │        │        │        │        │        │ │        │        │        │        │        │        │
       │        │        │        │        │        │        │ │        │        │        │        │        │        │
       ├────────┼────────┼────────┼────────┼────────┼────────┤ ├────────┼────────┼────────┼────────┼────────┼────────┤
       │        │        │        │        │        │        │ │        │        │        │        │        │        │
       │        │        │        │        │        │        │ │        │        │        │        │        │        │
       └────────┴────────┴────────┴────────┴────────┴────────┘ └────────┴────────┴────────┴────────┴────────┴────────┘
     */
    LAYOUT_4x12(
        XXXXXXX,  XXXXXXX,  XXXXXXX,  XXXXXXX,  XXXXXXX,  XXXXXXX,  /**/  XXXXXXX,  XXXXXXX,  XXXXXXX,  XXXXXXX,  XXXXXXX,   XXXXXXX,
        XXXXXXX,  XXXXXXX,  XXXXXXX,  XXXXXXX,  XXXXXXX,  XXXXXXX,  /**/  XXXXXXX,  XXXXXXX,  XXXXXXX,  XXXXXXX,  XXXXXXX,   XXXXXXX,
        XXXXXXX,  XXXXXXX,  XXXXXXX,  XXXXXXX,  XXXXXXX,  XXXXXXX,  /**/  XXXXXXX,  XXXXXXX,  XXXXXXX,  XXXXXXX,  XXXXXXX,   XXXXXXX,
        XXXXXXX,  XXXXXXX,  XXXXXXX,  XXXXXXX,  XXXXXXX,  XXXXXXX,  /**/  XXXXXXX,  XXXXXXX,  XXXXXXX,  XXXXXXX,  XXXXXXX,   XXXXXXX,
    ),

    /* Layer NAV
       ┌────────┬────────┬────────┬────────┬────────┬────────┐ ┌────────┬────────┬────────┬────────┬────────┬────────┐
       │  F1    │  F2    │  F3    │  F4    │        │ VolUp  │ │ Screen │        │  PgUp  │   Up   │  PgDn  │        │
       │        │        │        │        │        │        │ │ Saver  │        │        │        │        │        │
       ├────────┼────────┼────────┼────────┼────────┼────────┤ ├────────┼────────┼────────┼────────┼────────┼────────┤
       │  F5    │  F6    │  F7    │  F8    │        │ VolDn  │ │        │ Shift+ │  Left  │  Down  │  Right │        │
       │        │        │        │        │        │        │ │        │ Insert │        │        │        │        │
       ├────────┼────────┼────────┼────────┼────────┼────────┤ ├────────┼────────┼────────┼────────┼────────┼────────┤
       │  F9    │  F10   │  F11   │  F12   │        │ VolMut │ │        │        │  Home  │ Insert │  End   │        │
       │        │        │        │        │        │        │ │        │        │        │        │        │        │
       ├────────┼────────┼────────┼────────┼────────┼────────┤ ├────────┼────────┼────────┼────────┼────────┼────────┤
       │  OSM   │  OSM   │        │  CTRL  │ SHIFT  │ L NUM  │ │ BSPACE │ L NAV  │ DELETE │        │        │        │
       │  CTRL  │  SHIFT │        │ ESCAPE │ SPACE  │   TAB  │ │        │ RETURN │        │        │        │        │
       └────────┴────────┴────────┴────────┴────────┴────────┘ └────────┴────────┴────────┴────────┴────────┴────────┘
     */
    LAYOUT_4x12(
        KC_F1,     KC_F2,     KC_F3,    KC_F4,     XXXXXXX,    KC_VOLUP,  /**/  KC_SCR_SVR,  XXXXXXX,   KC_PGUP,    KC_UP,    KC_PGDN,   XXXXXXX,
        KC_F5,     KC_F6,     KC_F7,    KC_F8,     XXXXXXX,    KC_VOLDN,  /**/  XXXXXXX,     SHFT_INS,  KC_LEFT,    KC_DOWN,  KC_RIGHT,  XXXXXXX,
        KC_F9,     KC_F10,    KC_F11,   KC_F12,    XXXXXXX,    KC_MUTE,   /**/  XXXXXXX,     XXXXXXX,   KC_HOME,    KC_INS,   KC_END,    XXXXXXX,
        OSM_CTRL,  OSM_SHFT,  XXXXXXX,  CTRL_ESC,  SHIFT_SPC,  LNUM_TAB,  /**/  KC_BSPC,     LNAV_ENT,  KC_DELETE,  XXXXXXX,  XXXXXXX,   XXXXXXX,
    ),

    /* Layer GUI
       ┌────────┬────────┬────────┬────────┬────────┬────────┐ ┌────────┬────────┬────────┬────────┬────────┬────────┐
       │        │        │        │        │        │        │ │        │        │        │        │        │        │
       │        │        │        │        │        │        │ │        │        │        │        │        │        │
       ├────────┼────────┼────────┼────────┼────────┼────────┤ ├────────┼────────┼────────┼────────┼────────┼────────┤
       │        │        │        │        │        │        │ │        │        │  Gui+  │  Gui+  │  Gui+  │        │
       │        │        │        │        │        │        │ │        │        │  F13   │  F14   │   R    │        │
       ├────────┼────────┼────────┼────────┼────────┼────────┤ ├────────┼────────┼────────┼────────┼────────┼────────┤
       │        │        │        │        │        │        │ │        │        │  Gui+  │  Gui+  │  Gui+  │ L GUI  │
       │        │        │        │        │        │        │ │        │        │  PgUp  │  PgDn  │   Z    │   /    │
       ├────────┼────────┼────────┼────────┼────────┼────────┤ ├────────┼────────┼────────┼────────┼────────┼────────┤
       │        │        │        │        │        │        │ │        │        │        │        │        │        │
       │        │        │        │        │        │        │ │        │        │        │        │        │        │
       └────────┴────────┴────────┴────────┴────────┴────────┘ └────────┴────────┴────────┴────────┴────────┴────────┘
     */
    LAYOUT_4x12(
        XXXXXXX,  XXXXXXX,  XXXXXXX,  XXXXXXX,  XXXXXXX,  XXXXXXX,  /**/  XXXXXXX,  XXXXXXX,  XXXXXXX,   XXXXXXX,   XXXXXXX,     XXXXXXX,
        XXXXXXX,  XXXXXXX,  XXXXXXX,  XXXXXXX,  XXXXXXX,  XXXXXXX,  /**/  XXXXXXX,  XXXXXXX,  GUI_F13,   GUI_F14,   LGUI(KC_R),  XXXXXXX,
        XXXXXXX,  XXXXXXX,  XXXXXXX,  XXXXXXX,  XXXXXXX,  XXXXXXX,  /**/  XXXXXXX,  XXXXXXX,  GUI_PGUP,  GUI_PGDN,  LGUI(KC_Z),  LGUI_SLASH,
        XXXXXXX,  XXXXXXX,  XXXXXXX,  XXXXXXX,  XXXXXXX,  XXXXXXX,  /**/  XXXXXXX,  XXXXXXX,  XXXXXXX,   XXXXXXX,   XXXXXXX,     XXXXXXX,
    ),
});

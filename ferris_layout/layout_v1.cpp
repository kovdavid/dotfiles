#include "keymap.hpp"
#include "combo.hpp"

#define LDEFAULT 0
#define LSYM 1
#define LNAV 2
#define LWIN 3

#define CTRL_ESC    DM(MOD_LCTRL, KC_ESCAPE)
#define LNAV_SPC    THDL(LNAV, KC_SPACE)
#define SHFT_ENT    DM(MOD_LSHIFT, KC_ENTER)
#define LSYM_BSPC   THDL(LSYM, KC_BSPC)
#define LWIN_SLASH  DSL(LWIN, KC_SLASH)

#define CTAB LCTRL(KC_TAB)
#define CSTAB LCTRL(KC_TAB) | MOD_LSHIFT

const KeyCoords combo1[] = { { 0, 1 }, { 0, 2 } }; // Tab
const KeyCoords combo2[] = { { 0, 6 }, { 0, 7 } }; // CTRL+A
const KeyCoords combo3[] = { { 0, 7 }, { 0, 8 } }; // CTRL+W

const KeyCoords combo4[] = { { 1, 1 }, { 1, 2 } }; // LEFT MODS: GUI
const KeyCoords combo5[] = { { 1, 2 }, { 2, 2 } }; // LEFT MODS: CTRL
const KeyCoords combo6[] = { { 1, 3 }, { 2, 3 } }; // LEFT MODS: SHFT

const KeyCoords combo7[] = { { 1, 6 }, { 1, 6 } }; // RIGHT MODS: SHFT
const KeyCoords combo8[] = { { 1, 7 }, { 2, 7 } }; // RIGHT MODS: CTRL
const KeyCoords combo9[] = { { 1, 8 }, { 2, 8 } }; // RIGHT MODS: ALT

Combo combos[] = COMBOS({
    COMBO(combo1, KC_TAB),
    COMBO(combo2, LCTRL(KC_A)),
    COMBO(combo3, LCTRL(KC_W)),

    COMBO(combo4, OSM(MOD_LGUI)),
    COMBO(combo5, OSM(MOD_LCTRL)),
    COMBO(combo6, OSM(MOD_LSHIFT)),

    COMBO(combo7, OSM(MOD_RSHIFT)),
    COMBO(combo8, OSM(MOD_RCTRL)),
    COMBO(combo9, OSM(MOD_LALT))
});

/***** Combos

           0        1        2        3        4                  5        6        7        8        9
       ┌────────┬────────┬────────┬────────┬────────┐         ┌────────┬────────┬────────┬────────┬────────┐
     0 │        │       Tab       │        │        │         │        │      CTRL     CTRL       │        │
       │        │        │        │        │        │         │        │        A        W        │        │
       ├─Delete─┼────────┼────────┼────────┼────────┤         ├────────┼────────┼────────┼────────┼────────┤
     1 │        │        │        │        │        │         │        │        │        │        │        │
       │        │        │        │        │        │         │        │        │        │        │        │
       ├────────┼─ GUI  ─┼─ CTRL ─┼─ SHFT ─┼────────┤         ├────────┼─ SHFT ─┼─ CTRL ─┼─ ALT  ─┼────────┤
     2 │        │        │        │        │        │         │        │        │        │        │        │
       │        │        │        │        │        │         │        │        │        │        │        │
       └────────┴────────┴────────┼────────┼────────┤         ├────────┼────────┼────────┴────────┴────────┘
     3                            │        │        │         │        │        │
                                  │        │        │         │        │        │
                                  └────────┴────────┘         └────────┴────────┘

*****/

const uint32_t keymap[][KEYBOARD_ROWS][2*KEYBOARD_COLS] = KEYMAP({
    /***** Layer DEFAULT
       ┌────────┬────────┬────────┬────────┬────────┐               ┌────────┬────────┬────────┬────────┬────────┐
       │   Q    │   W    │   E    │   R    │   T    │               │   Y    │   U    │   I    │   O    │   P    │
       │        │        │        │        │        │               │        │        │        │        │        │
       ├────────┼────────┼────────┼────────┼────────┤               ├────────┼────────┼────────┼────────┼────────┤
       │   A    │   S    │   D    │   F    │   G    │               │   H    │   J    │   K    │   L    │   :    │
       │        │        │        │        │        │               │        │        │        │        │        │
       ├────────┼────────┼────────┼────────┼────────┤               ├────────┼────────┼────────┼────────┼────────┤
       │   Z    │   X    │   C    │   V    │   B    │               │   N    │   M    │   ,    │   .    │ L WIN  │
       │ L MUX  │        │        │        │        │               │        │        │        │        │   /    │
       └────────┴────────┴────────┼────────┼────────┤               ├────────┼────────┼────────┴────────┴────────┘
                                  │  CTRL  │ L NAV  │               │ SHIFT  │ L SYM  │
                                  │ ESCAPE │ SPACE  │               │ RETURN │ BSPACE │
                                  └────────┴────────┘               └────────┴────────┘
    *****/

    LAYOUT_4x10(
        KC_Q,      KC_W,      KC_E,     KC_R,      KC_T,            KC_Y,      KC_U,       KC_I,     KC_O,     KC_P,
        KC_A,      KC_S,      KC_D,     KC_F,      KC_G,            KC_H,      KC_J,       KC_K,     KC_L,     KC_SEMICOLON,
        KC_Z,      KC_X,      KC_C,     KC_V,      KC_B,            KC_N,      KC_M,       KC_COMM,  KC_DOT,   LWIN_SLASH,
        XXXXXXX,   XXXXXXX,   XXXXXXX,  CTRL_ESC,  LNAV_SPC,        SHFT_ENT,  LSYM_BSPC,  XXXXXXX,  XXXXXXX,  XXXXXXX
    ),

    /* Layer SYM
       ┌────────┬────────┬────────┬────────┬────────┐               ┌────────┬────────┬────────┬────────┬────────┐
       │   !    │   @    │   #    │   $    │   ~    │               │        │   [    │   "    │   ]    │   >    │
       │        │        │        │        │        │               │        │        │        │        │        │
       ├────────┼────────┼────────┼────────┼────────┤               ├────────┼────────┼────────┼────────┼────────┤
       │   %    │   ^    │   &    │   *    │   `    │               │        │   (    │   _    │   )    │   <    │
       │        │        │        │        │        │               │        │        │        │        │        │
       ├────────┼────────┼────────┼────────┼────────┤               ├────────┼────────┼────────┼────────┼────────┤
       │   |    │   +    │   =    │   -    │   \    │               │        │   {    │   '    │   }    │   /    │
       │        │        │        │        │        │               │        │        │        │        │        │
       └────────┴────────┴────────┼────────┼────────┤               ├────────┼────────┼────────┴────────┴────────┘
                                  │  CTRL  │ L NAV  │               │ SHIFT  │*L SYM *│
                                  │ ESCAPE │ SPACE  │               │ RETURN │*BSPACE*│
                                  └────────┴────────┘               └────────┴────────┘
    */

    LAYOUT_4x10(
        KC_EXLM,  KC_AT,    KC_HASH,  KC_DLR,    KC_TILD,           XXXXXXX,   KC_LBRC,    KC_DQUO,  KC_RBRC,   KC_RABK,
        KC_PERC,  KC_CIRC,  KC_AMPR,  KC_ASTR,   KC_GRV,            XXXXXXX,   KC_LPRN,    KC_UNDS,  KC_RPRN,   KC_LABK,
        KC_PIPE,  KC_PLUS,  KC_EQL,   KC_MINS,   KC_BSLS            XXXXXXX,   KC_LCBR,    KC_QUOT,  KC_RCBR,   KC_SLASH,
        XXXXXXX,  XXXXXXX,  XXXXXXX,  CTRL_ESC,  LNAV_SPC,          SHFT_ENT,  LSYM_BSPC,  XXXXXXX,  XXXXXXX,   XXXXXXX
    ),

    /* Layer NAV
       ┌────────┬────────┬────────┬────────┬────────┐               ┌────────┬────────┬────────┬────────┬────────┐
       │        │  PgDn  │   Up   │  PgUp  │        │               │   +    │   7    │   8    │   9    │   :    │
       │        │        │        │        │        │               │        │        │        │        │        │
       ├────────┼────────┼────────┼────────┼────────┤               ├────────┼────────┼────────┼────────┼────────┤
       │ C(Tab) │  Left  │  Down  │ Right  │        │               │   -    │   4    │   5    │   6    │   0    │
       │        │        │        │        │        │               │        │        │        │        │        │
       ├────────┼────────┼────────┼────────┼────────┤               ├────────┼────────┼────────┼────────┼────────┤
       │ CS Tab │  Home  │ Insert │  End   │        │               │   =    │   1    │   2    │   3    │   .    │
       │        │        │        │        │        │               │        │        │        │        │        │
       └────────┴────────┴────────┼────────┼────────┤               ├────────┼────────┼────────┴────────┴────────┘
                                  │  CTRL  │*L NAV *│               │ SHIFT  │ L SYM  │
                                  │ ESCAPE │*SPACE *│               │ RETURN │ BSPACE │
                                  └────────┴────────┘               └────────┴────────┘
    */

    LAYOUT_4x10(
        XXXXXXX,  KC_PGDN,  KC_UP,    KC_PGUP,   XXXXXXX,           KC_PLUS,   KC_7,       KC_8,     KC_9,      KC_COLON,
        CTAB,     KC_LEFT,  KC_DOWN,  KC_RIGHT,  XXXXXXX,           KC_MINS,   KC_4,       KC_5,     KC_6,      KC_0,
        CSTAB,    KC_HOME,  KC_INS,   KC_END,    XXXXXXX            KC_EQL,    KC_1,       KC_2,     KC_3,      KC_DOT,
        XXXXXXX,  XXXXXXX,  XXXXXXX,  CTRL_ESC,  LNAV_SPC,          SHFT_ENT,  LSYM_BSPC,  XXXXXXX,  XXXXXXX,   XXXXXXX
    ),


    /*
       Layer WIN

       ┌────────┬────────┬────────┬────────┬────────┐         ┌────────┬────────┬────────┬────────┬────────┐
       │ Shift+ │  Gui+  │  Gui+  │  Gui+  │  Gui+  │         │        │        │        │        │        │
       │ Insert │   C    │   V    │   R    │   F    │         │        │        │        │        │        │
       ├────────┼────────┼────────┼────────┼────────┤         ├────────┼────────┼────────┼────────┼────────┤
       │  Gui+  │  Gui+  │  Gui+  │  Gui+  │  Gui+  │         │        │        │        │        │        │
       │   1    │   2    │   3    │   4    │  Ret   │         │        │        │        │        │        │
       ├────────┼────────┼────────┼────────┼────────┤         ├────────┼────────┼────────┼────────┼────────┤
       │  Gui+  │  Gui+  │  Gui+  │  Gui+  │  Gui+  │         │        │        │        │        │*L WIN *│
       │  F1    │  F2    │  F3    │  F4    │  Tab   │         │        │        │        │        │*  /   *│
       └────────┴────────┴────────┼────────┼────────┤         ├────────┼────────┼────────┴────────┴────────┘
                                  │  Gui+  │ SHIFT  │         │        │        │
                                  │   Z    │        │         │        │        │
                                  └────────┴────────┘         └────────┴────────┘
    */

    TODO rework from here

    /* Layer WIN
       ┌────────┬────────┬────────┬────────┬────────┐               ┌────────┬────────┬────────┬────────┬────────┐
       │  F01   │  F02   │  F03   │  F04   │ Shift+ │               │        │        │        │        │        │
       │        │        │        │        │ Insert │               │        │        │        │        │        │
       ├────────┼────────┼────────┼────────┼────────┤               ├────────┼────────┼────────┼────────┼────────┤
       │  F05   │  F06   │  F07   │  F08   │  Gui+  │               │        │  Gui+  │  Gui+  │  Gui+  │        │
       │        │        │        │        │   C    │               │        │  F13   │  F14   │   R    │        │
       ├────────┼────────┼────────┼────────┼────────┤               ├────────┼────────┼────────┼────────┼────────┤
       │  F09   │  F10   │  F11   │  F12   │  Gui+  │               │        │  Gui+  │  Gui+  │  Gui+  │*L WIN *│
       │        │        │        │        │   V    │               │        │  F15   │  F16   │   Z    │*  /   *│
       └────────┴────────┴────────┼────────┼────────┤               ├────────┼────────┼────────┴────────┴────────┘
                                  │        │        │               │  Gui+  │  Gui+  │
                                  │        │        │               │ RETURN │   F    │
                                  └────────┴────────┘               └────────┴────────┘
                                                                      Toggle    Zoom
     */


    /*
       Layer MUX
                alt+a/s - cycle panes
                alt+q/w - cycle windows
                alt+1/2 - cycle sessions

       ┌────────┬────────┬────────┬────────┬────────┐         ┌────────┬────────┬────────┬────────┬────────┐
       │        │        │        │        │        │         │        │  Alt   │  Alt   │        │ Screen │
       │        │        │        │        │        │         │        │   A    │   S    │        │ Saver  │
       ├────────┼────────┼────────┼────────┼────────┤         ├────────┼────────┼────────┼────────┼────────┤
       │        │        │        │        │        │         │        │  Alt   │  Alt   │        │        │
       │        │        │        │        │        │         │        │   Q    │   W    │        │        │
       ├────────┼────────┼────────┼────────┼────────┤         ├────────┼────────┼────────┼────────┼────────┤
       │*  Z   *│ VolUp  │ VolDn  │ VolMut │        │         │        │  Alt   │  Alt   │        │        │
       │* MUX  *│        │        │        │        │         │        │   1    │   2    │        │        │
       └────────┴────────┴────────┼────────┼────────┤         ├────────┼────────┼────────┴────────┴────────┘
                                  │  CTRL  │ L NAV  │         │ SHIFT  │ L SYM  │
                                  │ ESCAPE │ SPACE  │         │ RETURN │ BSPACE │
                                  └────────┴────────┘         └────────┴────────┘
    */



});

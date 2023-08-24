#include "keymap.h"
#include "combo.h"
#include "tapdance.h"

// New experimental keymap. Inspiration from:
// https://github.com/aleksbrgt/qmk_firmware/blob/corne_combos/keyboards/crkbd/keymaps/5col/keymap.c

#define LDEFAULT 0
#define LNUM 1
#define LSYM 2
#define LNAV 3
#define LWIN 4

#define OSM_SHFT  OSM(MOD_LSHIFT)
#define OSM_CTRL  OSM(MOD_LCTRL)
#define OSM_ALT   OSM(MOD_LALT)
#define OSM_GUI   OSM(MOD_LGUI)

#define CTRL_ESC  DM(MOD_LCTRL, KC_ESCAPE)
#define SHIFT_SPC THDM(MOD_LSHIFT, KC_SPACE)
#define SHFT_INS  LSHIFT(KC_INS)

#define M_BTN1 MOUSE_BUTTON(BTN1)
#define M_BTN2 MOUSE_BUTTON(BTN2)
#define M_BTN3 MOUSE_BUTTON(BTN3)
#define M_BTN4 MOUSE_BUTTON(BTN4)
#define M_BTN5 MOUSE_BUTTON(BTN5)

// i3 navigation
#define GUI_F13  LGUI(KC_F13)
#define GUI_F14  LGUI(KC_F14)
#define GUI_PGUP LGUI(KC_PGUP)
#define GUI_PGDN LGUI(KC_PGDN)
#define GUI_TAB  LGUI(KC_TAB)
#define GUI_RET  LGUI(KC_ENTER)
#define GUI_STAB LGUI(LSHIFT(KC_TAB))

#define LNUM_TAB    DL(LNUM, KC_TAB)
#define LNAV_BSPC   THDL(LNAV, KC_BACKSPACE)
#define LSYM_SCOLON DSL(LSYM, KC_SEMICOLON)
#define LWIN_SLASH  DSL(LWIN, KC_SLASH)
#define LNUM_RET    DSL(LNUM, KC_ENTER)

    /* Combos
           0        1        2        3        4        5          6        7        8        9        10       11
       ┌────────┬────────┬────────┬────────┬────────┐                   ┌────────┬────────┬────────┬────────┬────────┐
     0 │        │        │        │        │        │                   │        │      *CTRL  +   A*       │        │
       │        │        │        │        │        │                   │        │        │        │        │        │
       ├────────┼────────┼────────┼────────┼────────┤                   ├────────┼────────┼────────┼────────┼────────┤
     1 │        │     *GUI*    *SHIFT*     │        │                   │        │      *CTRL*   *ALT*      │        │
       │        │     *GUI   *  SHIFT*     │        │                   │        │      *CTRL  *  ALT*      │        │
       ├────────┼────────┼────────┼────────┼────────┤                   ├────────┼────────┼────────┼────────┼────────┤
     2 │        │        │        │        │        │                   │        │        │        │        │        │
       │        │        │        │        │        │                   │        │        │        │        │        │
       ├────────┼────────┼────────┼────────┼────────┼────────┐ ┌────────┼────────┼────────┼────────┼────────┼────────┤
     3 │        │        │        │        │        │        │ │        │        │        │        │        │        │
       │        │        │        │        │        │    *CAPS WORD*    │        │        │        │        │        │
       └────────┴────────┴────────┴────────┴────────┴────────┘ └────────┴────────┴────────┴────────┴────────┴────────┘
     */

const KeyCoords combo1[] PROGMEM = { { 1, 1 }, { 1, 2 }           }; // LGUI
const KeyCoords combo2[] PROGMEM = {           { 1, 2 }, { 1, 3 } }; // LSHIFT
const KeyCoords combo3[] PROGMEM = { { 1, 1 }, { 1, 2 }, { 1, 3 } }; // LGUI + LSHIFT

const KeyCoords combo4[] PROGMEM = { { 1, 8 }, { 1, 9 }            }; // LCTRL
const KeyCoords combo5[] PROGMEM = {           { 1, 9 }, { 1, 10 } }; // LALT
const KeyCoords combo6[] PROGMEM = { { 1, 8 }, { 1, 9 }, { 1, 10 } }; // LCTRL + LALT

const KeyCoords combo7[] PROGMEM = { { 3, 5 }, { 3, 6 } }; // CAPS_WORD
const KeyCoords combo8[] PROGMEM = { { 0, 8 }, { 0, 9 }, { 0, 10 } }; // Ctrl+a

Combo combos[] = COMBOS({
    COMBO(combo1, OSM(MOD_LGUI)),
    COMBO(combo2, OSM(MOD_LSHIFT)),
    COMBO(combo3, OSM(MOD_LGUI | MOD_LSHIFT)),

    COMBO(combo4, OSM(MOD_LCTRL)),
    COMBO(combo5, OSM(MOD_LALT)),
    COMBO(combo6, OSM(MOD_LCTRL | MOD_LALT)),

    COMBO(combo7, CAPS_WORD),
    COMBO(combo8, LCTRL(KC_A))
});

// Just testing
const uint32_t tapdance1[] PROGMEM = { KC_A, KC_B, LGUI(KC_C) };

const TapDance tapdances[] = TAPDANCES({
    TAPDANCE(tapdance1),
});

const uint32_t keymap[][KEYBOARD_ROWS][2*KEYBOARD_COLS] PROGMEM = KEYMAP({
    /* Layer DEFAULT
       ┌────────┬────────┬────────┬────────┬────────┬────────┐ ┌────────┬────────┬────────┬────────┬────────┬────────┐
       │   Q    │   W    │   E    │   R    │   T    │  Alt+  │ │  Alt+  │   Y    │   U    │   I    │   O    │   P    │
       │        │        │        │        │        │   A    │ │   S    │        │        │        │        │        │
       ├────────┼────────┼────────┼────────┼────────┼────────┤ ├────────┼────────┼────────┼────────┼────────┼────────┤
       │   A    │   S    │   D    │   F    │   G    │  Alt+  │ │  Alt+  │   H    │   J    │   K    │   L    │ L SYM  │
       │        │        │        │        │        │   Q    │ │   W    │        │        │        │        │   ;    │
       ├────────┼────────┼────────┼────────┼────────┼────────┤ ├────────┼────────┼────────┼────────┼────────┼────────┤
       │   Z    │   X    │   C    │   V    │   B    │  Alt+  │ │  Alt+  │   N    │   M    │   ,    │   .    │ L WIN  │
       │        │        │        │        │        │   1    │ │   2    │        │        │        │        │   /    │
       ├────────┼────────┼────────┼────────┼────────┼────────┤ ├────────┼────────┼────────┼────────┼────────┼────────┤
       │  OSM   │  OSM   │        │  CTRL  │ SHIFT  │ L NUM  │ │ L NUM  │ L NAV  │ DELETE │        │        │  LHT   │
       │  CTRL  │  SHIFT │        │ ESCAPE │ SPACE  │  TAB   │ │ RETURN │ BSPACE │        │        │        │  NAV   │
       └────────┴────────┴────────┴────────┴────────┴────────┘ └────────┴────────┴────────┴────────┴────────┴────────┘
     */
    LAYOUT_4x12(
        KC_Q,      KC_W,      KC_E,     KC_R,      KC_T,       LALT(KC_A),  /**/  LALT(KC_S),  KC_Y,      KC_U,       KC_I,     KC_O,     KC_P,
        KC_A,      KC_S,      KC_D,     KC_F,      KC_G,       LALT(KC_Q),  /**/  LALT(KC_W),  KC_H,      KC_J,       KC_K,     KC_L,     LSYM_SCOLON,
        KC_Z,      KC_X,      KC_C,     KC_V,      KC_B,       LALT(KC_1),  /**/  LALT(KC_2),  KC_N,      KC_M,       KC_COMM,  KC_DOT,   LWIN_SLASH,
        OSM_CTRL,  OSM_SHFT,  XXXXXXX,  CTRL_ESC,  SHIFT_SPC,  LNUM_TAB,    /**/  LNUM_RET,    LNAV_BSPC, KC_DELETE,  XXXXXXX,  XXXXXXX,  LHT(LNAV)
    ),

    /* Layer NUM
       ┌────────┬────────┬────────┬────────┬────────┬────────┐ ┌────────┬────────┬────────┬────────┬────────┬────────┐
       │        │        │        │        │        │        │ │        │        │   7    │   8    │   9    │        │
       │        │        │        │        │        │        │ │        │        │        │        │        │        │
       ├────────┼────────┼────────┼────────┼────────┼────────┤ ├────────┼────────┼────────┼────────┼────────┼────────┤
       │        │        │        │        │        │        │ │        │        │   4    │   5    │   6    │   0    │
       │        │        │        │        │        │        │ │        │        │        │        │        │        │
       ├────────┼────────┼────────┼────────┼────────┼────────┤ ├────────┼────────┼────────┼────────┼────────┼────────┤
       │        │        │        │        │        │        │ │        │        │   1    │   2    │   3    │        │
       │        │        │        │        │        │        │ │        │        │        │        │        │        │
       ├────────┼────────┼────────┼────────┼────────┼────────┤ ├────────┼────────┼────────┼────────┼────────┼────────┤
       │  OSM   │  OSM   │        │  CTRL  │ SHIFT  │*L NUM *│ │*L NUM *│ L NAV  │ DELETE │        │        │        │
       │  CTRL  │  SHIFT │        │ ESCAPE │ SPACE  │*  TAB *│ │*RETURN*│ BSPACE │        │        │        │        │
       └────────┴────────┴────────┴────────┴────────┴────────┘ └────────┴────────┴────────┴────────┴────────┴────────┘
     */
    LAYOUT_4x12(
        XXXXXXX,   XXXXXXX,   XXXXXXX,  XXXXXXX,  XXXXXXX,  XXXXXXX,  /**/  XXXXXXX,  XXXXXXX,  KC_7,     KC_8,     KC_9,     XXXXXXX,
        XXXXXXX,   XXXXXXX,   XXXXXXX,  XXXXXXX,  XXXXXXX,  XXXXXXX,  /**/  XXXXXXX,  XXXXXXX,  KC_4,     KC_5,     KC_6,     KC_0,
        XXXXXXX,   XXXXXXX,   XXXXXXX,  XXXXXXX,  XXXXXXX,  XXXXXXX,  /**/  XXXXXXX,  XXXXXXX,  KC_1,     KC_2,     KC_3,     XXXXXXX,
        OSM_CTRL,  OSM_SHFT,  XXXXXXX,  _______,  _______,  _______,  /**/  _______,  _______,  _______,  XXXXXXX,  XXXXXXX,  XXXXXXX
    ),

    /* Layer SYM
       ┌────────┬────────┬────────┬────────┬────────┬────────┐ ┌────────┬────────┬────────┬────────┬────────┬────────┐
       │   !    │   @    │   #    │   $    │   ~    │        │ │        │        │   [    │   "    │   ]    │        │
       │        │        │        │        │        │        │ │        │        │        │        │        │        │
       ├────────┼────────┼────────┼────────┼────────┼────────┤ ├────────┼────────┼────────┼────────┼────────┼────────┤
       │   %    │   ^    │   &    │   *    │   -    │        │ │        │        │   (    │   _    │   )    │*L SYM *│
       │        │        │        │        │        │        │ │        │        │        │        │        │*  ;   *│
       ├────────┼────────┼────────┼────────┼────────┼────────┤ ├────────┼────────┼────────┼────────┼────────┼────────┤
       │   \    │   |    │   =    │   +    │   `    │        │ │        │        │   {    │   '    │   }    │        │
       │        │        │        │        │        │        │ │        │        │        │        │        │        │
       ├────────┼────────┼────────┼────────┼────────┼────────┤ ├────────┼────────┼────────┼────────┼────────┼────────┤
       │        │        │        │  CTRL  │ SHIFT  │ L NUM  │ │ RETURN │ BSPACE │ DELETE │        │        │        │
       │        │        │        │ ESCAPE │ SPACE  │   TAB  │ │        │        │        │        │        │        │
       └────────┴────────┴────────┴────────┴────────┴────────┘ └────────┴────────┴────────┴────────┴────────┴────────┘
     */
    LAYOUT_4x12(
        KC_EXLM,   KC_AT,   KC_HASH,  KC_DLR,    KC_TILD,    XXXXXXX,   /**/  XXXXXXX,   XXXXXXX,  KC_LBRC,    KC_DQUO,  KC_RBRC,   XXXXXXX,
        KC_PERC,  KC_CIRC,  KC_AMPR,  KC_ASTR,   KC_MINS,    XXXXXXX,   /**/  XXXXXXX,   XXXXXXX,  KC_LPRN,    KC_UNDS,  KC_RPRN,   LSYM_SCOLON,
        KC_BSLS,  KC_PIPE,  KC_EQL,   KC_PLUS,   KC_GRV,     XXXXXXX,   /**/  XXXXXXX,   XXXXXXX,  KC_LCBR,    KC_QUOT,  KC_RCBR,   XXXXXXX,
        XXXXXXX,  XXXXXXX,  XXXXXXX,  CTRL_ESC,  SHIFT_SPC,  LNUM_TAB,  /**/  KC_ENTER,  KC_BSPC,  KC_DELETE,  XXXXXXX,  XXXXXXX,   XXXXXXX
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
       │  OSM   │  OSM   │        │  CTRL  │ SHIFT  │ L NUM  │ │ L NUM  │*L NAV *│ DELETE │        │        │* LHT  *│
       │  CTRL  │  SHIFT │        │ ESCAPE │ SPACE  │   TAB  │ │ RETURN │*BSPACE*│        │        │        │* NAV  *│
       └────────┴────────┴────────┴────────┴────────┴────────┘ └────────┴────────┴────────┴────────┴────────┴────────┘
     */
    LAYOUT_4x12(
        KC_F1,     KC_F2,     KC_F3,    KC_F4,     XXXXXXX,    KC_VOLUP,  /**/  KC_SCR_SVR,  XXXXXXX,   KC_PGUP,  KC_UP,    KC_PGDN,   XXXXXXX,
        KC_F5,     KC_F6,     KC_F7,    KC_F8,     XXXXXXX,    KC_VOLDN,  /**/  XXXXXXX,     SHFT_INS,  KC_LEFT,  KC_DOWN,  KC_RIGHT,  XXXXXXX,
        KC_F9,     KC_F10,    KC_F11,   KC_F12,    XXXXXXX,    KC_MUTE,   /**/  XXXXXXX,     XXXXXXX,   KC_HOME,  KC_INS,   KC_END,    XXXXXXX,
        OSM_CTRL,  OSM_SHFT,  XXXXXXX,  CTRL_ESC,  SHIFT_SPC,  LNUM_TAB,  /**/  _______,     _______,   _______,  XXXXXXX,  XXXXXXX,   LHT(LNAV)
    ),

    /* Layer GUI
       ┌────────┬────────┬────────┬────────┬────────┬────────┐ ┌────────┬────────┬────────┬────────┬────────┬────────┐
       │        │        │        │        │        │        │ │        │        │  Gui+  │  Gui+  │        │        │
       │        │        │        │        │        │        │ │        │        │  Tab   │ S(Tab) │        │        │
       ├────────┼────────┼────────┼────────┼────────┼────────┤ ├────────┼────────┼────────┼────────┼────────┼────────┤
       │        │ MS BTN │ MS BTN │ MS BTN │        │        │ │        │        │  Gui+  │  Gui+  │  Gui+  │        │
       │        │  LEFT  │ MIDDLE │ RIGHT  │        │        │ │        │        │  F13   │  F14   │   R    │        │
       ├────────┼────────┼────────┼────────┼────────┼────────┤ ├────────┼────────┼────────┼────────┼────────┼────────┤
       │        │ MS BTN │        │ MS BTN │        │        │ │        │        │  Gui+  │  Gui+  │  Gui+  │*L WIN *│
       │        │   4    │        │   5    │        │        │ │        │        │  PgUp  │  PgDn  │   Z    │*  /   *│
       ├────────┼────────┼────────┼────────┼────────┼────────┤ ├────────┼────────┼────────┼────────┼────────┼────────┤
       │        │        │        │        │        │        │ │        │  Gui+  │        │        │        │        │
       │        │        │        │        │        │        │ │        │ RETURN │        │        │        │        │
       └────────┴────────┴────────┴────────┴────────┴────────┘ └────────┴────────┴────────┴────────┴────────┴────────┘
     */
    LAYOUT_4x12(
        XXXXXXX,  XXXXXXX,  XXXXXXX,  XXXXXXX,  XXXXXXX,  XXXXXXX,  /**/  XXXXXXX,  XXXXXXX,  GUI_TAB,   GUI_STAB,  XXXXXXX,     XXXXXXX,
        XXXXXXX,  M_BTN1 ,  M_BTN3 ,  M_BTN2 ,  XXXXXXX,  XXXXXXX,  /**/  XXXXXXX,  XXXXXXX,  GUI_F13,   GUI_F14,   LGUI(KC_R),  XXXXXXX,
        XXXXXXX,  M_BTN4 ,  XXXXXXX,  M_BTN5 ,  XXXXXXX,  XXXXXXX,  /**/  XXXXXXX,  XXXXXXX,  GUI_PGUP,  GUI_PGDN,  LGUI(KC_Z),  LWIN_SLASH,
        XXXXXXX,  XXXXXXX,  XXXXXXX,  XXXXXXX,  XXXXXXX,  XXXXXXX,  /**/  XXXXXXX,  GUI_RET,  XXXXXXX,   XXXXXXX,   XXXXXXX,     XXXXXXX
    )
});

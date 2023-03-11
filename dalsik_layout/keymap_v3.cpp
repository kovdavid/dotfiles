#include "keymap.h"
#include "combos.h"

#define CAPS_WORD_TIMEOUT 2000

#define CTRL_ESC  D(MOD_LCTRL, KC_ESCAPE)
#define SHIFT_SPC D(MOD_LSHIFT, KC_SPACE)
#define L1_SPACE  DL(1, KC_SPACE)
#define L3_SCOLON DSL(3, KC_SEMICOLON)
#define L4_SLASH  DSL(4, KC_SLASH)
#define L2_BSPC   DSL(2, KC_BACKSPACE)
#define OSM_SHFT  OSM(MOD_LSHIFT)
#define OSM_CTRL  OSM(MOD_LCTRL)
#define OSM_ALT   OSM(MOD_LALT)
#define OSM_GUI   OSM(MOD_LGUI)

#define GUI_F13 LGUI(KC_F13)
#define GUI_F14 LGUI(KC_F14)
#define GUI_PGUP LGUI(KC_PGUP)
#define GUI_PGDN LGUI(KC_PGDN)
#define SHFT_INS LSHIFT(KC_INS)

const KeyCoords combo1[] PROGMEM = { { 1, 2 }, { 1, 3 }           };
const KeyCoords combo2[] PROGMEM = {           { 1, 3 }, { 1, 4 } };
const KeyCoords combo3[] PROGMEM = { { 1, 2 }, { 1, 3 }, { 1, 4 } };

const KeyCoords combo4[] PROGMEM = { { 1, 7 }, { 1, 8 }           };
const KeyCoords combo5[] PROGMEM = {           { 1, 8 }, { 1, 9 } };
const KeyCoords combo6[] PROGMEM = { { 1, 7 }, { 1, 8 }, { 1, 9 } };

const KeyCoords combo7[] PROGMEM = { { 1, 4 }, { 1, 7 } };

const KeyCoords combo8[]  PROGMEM = { { 0, 7 }, { 0, 8 }           }; // (
const KeyCoords combo9[]  PROGMEM = {           { 0, 8 }, { 0, 9 } }; // )
const KeyCoords combo10[] PROGMEM = { { 0, 8 }, { 1, 7 } }; // [
const KeyCoords combo11[] PROGMEM = { { 0, 8 }, { 1, 9 } }; // ]
const KeyCoords combo12[] PROGMEM = { { 2, 7 }, { 1, 8 }           }; // {
const KeyCoords combo13[] PROGMEM = {           { 1, 8 }, { 2, 9 } }; // }

const KeyCoords combo14[] PROGMEM = { { 2, 7 }, { 2, 8 } }; // _
const KeyCoords combo15[] PROGMEM = { { 2, 6 }, { 2, 7 } }; // -

const KeyCoords combo16[] PROGMEM = { { 1, 1 }, { 1, 2 } }; // Tab
const KeyCoords combo17[] PROGMEM = { { 1, 9 }, { 1, 10 } }; // Enter

const KeyCoords combo18[] PROGMEM = { { 3, 5 }, { 3, 6 } }; // CAPS_WORD

ComboState combos[] = COMBOS({
    COMBO(combo1, OSM(MOD_LSHIFT)),
    COMBO(combo2, OSM(MOD_LGUI)),
    COMBO(combo3, OSM(MOD_LSHIFT | MOD_LGUI)),

    COMBO(combo4, OSM(MOD_LCTRL)),
    COMBO(combo5, OSM(MOD_LALT)),
    COMBO(combo6, OSM(MOD_LCTRL | MOD_LALT)),

    COMBO(combo7, LCTRL(KC_A)),

    COMBO(combo8, KC_LPRN), // (
    COMBO(combo9, KC_RPRN), // )
    COMBO(combo10, KC_LBRC), // [
    COMBO(combo11, KC_RBRC), // ]
    COMBO(combo12, KC_LCBR), // {
    COMBO(combo13, KC_RCBR), // }

    COMBO(combo14, KC_UNDS), // _
    COMBO(combo15, KC_MINS), // -
    COMBO(combo16, KC_TAB), // Tab
    COMBO(combo17, KC_ENTER), // Enter

    COMBO(combo18, CAPS_WORD),
});

const uint32_t keymap[][KEYBOARD_ROWS][KEYBOARD_COLS] PROGMEM = KEYMAP({
    /* Layer 0
     * ┌────────┬────────┬────────┬────────┬────────┬────────┐ ┌────────┬────────┬────────┬────────┬────────┬────────┐
     * │ Tab    │   Q    │   W    │   E    │   R    │   T    │ │   Y    │   U    │   I    │   O    │   P    │   '    │
     * │        │        │        │        │        │        │ │        │        │        │        │        │        │
     * ├────────┼────────┼────────┼────────┼────────┼────────┤ ├────────┼────────┼────────┼────────┼────────┼────────┤
     * │ Ctrl   │   A    │   S    │   D    │   F    │   G    │ │   H    │   J    │   K    │   L    │ Layer3 │ Enter  │
     * │ ESC    │        │        │        │        │        │ │        │        │        │        │   ;    │        │
     * ├────────┼────────┼────────┼────────┼────────┼────────┤ ├────────┼────────┼────────┼────────┼────────┼────────┤
     * │ OneShot│   Z    │   X    │   C    │   V    │   B    │ │   N    │   M    │   ,    │   .    │ Layer4 │ Delete │
     * │ Shift  │        │        │        │        │        │ │        │        │        │        │   /    │        │
     * ├────────┼────────┼────────┼────────┼────────┼────────┤ ├────────┼────────┼────────┼────────┼────────┼────────┤
     * │ OneShot│ Layer  │ OneShot│ OneShot│ Layer  │ Shift  │ │ Layer2 │ Layer  │ Layer  │  LHT   │  Left  │ Right  │
     * │ Ctrl   │   3    │ Alt    │ Gui    │   1    │ Space  │ │ BSpace │   3    │   3    │   1    │        │        │
     * └────────┴────────┴────────┴────────┴────────┴────────┘ └────────┴────────┴────────┴────────┴────────┴────────┘
     */
    LAYOUT_4x12(
        KC_TAB,    KC_Q,   KC_W,     KC_E,     KC_R,   KC_T,       KC_Y,     KC_U,   KC_I,     KC_O,    KC_P,       KC_QUOT,
        CTRL_ESC,  KC_A,   KC_S,     KC_D,     KC_F,   KC_G,       KC_H,     KC_J,   KC_K,     KC_L,    L3_SCOLON,  KC_ENTER,
        OSM_SHFT,  KC_Z,   KC_X,     KC_C,     KC_V,   KC_B,       KC_N,     KC_M,   KC_COMM,  KC_DOT,  L4_SLASH,   KC_DELETE,
        OSM_CTRL,  LP(3),  OSM_ALT,  OSM_GUI,  LP(1),  SHIFT_SPC,  L2_BSPC,  LP(3),  LHT(3),   LHT(1),  KC_LEFT,    KC_RIGHT
    ),

    /* Layer 1
     * ┌────────┬────────┬────────┬────────┬────────┬────────┐ ┌────────┬────────┬────────┬────────┬────────┬────────┐
     * │ Tab    │   \    │        │        │        │        │ │        │   (    │   )    │   [    │   ]    │   `    │
     * │        │        │        │        │        │        │ │        │        │        │        │        │        │
     * ├────────┼────────┼────────┼────────┼────────┼────────┤ ├────────┼────────┼────────┼────────┼────────┼────────┤
     * │ Ctrl   │   !    │   @    │   #    │   $    │   %    │ │   ^    │   &    │   *    │   {    │   }    │ Enter  │
     * │ ESC    │        │        │        │        │        │ │        │        │        │        │        │        │
     * ├────────┼────────┼────────┼────────┼────────┼────────┤ ├────────┼────────┼────────┼────────┼────────┼────────┤
     * │ OneShot│   |    │        │        │   =    │   +    │ │   -    │   _    │   <    │   >    │   ?    │ Delete │
     * │ Shift  │        │        │        │        │        │ │        │        │        │        │        │        │
     * ├────────┼────────┼────────┼────────┼────────┼────────┤ ├────────┼────────┼────────┼────────┼────────┼────────┤
     * │ OneShot│ Layer  │ OneShot│ OneShot│ Layer  │ Space  │ │ BSpace │ Layer  │ Layer  │  LHT   │   Up   │  Down  │
     * │ Ctrl   │   3    │ Alt    │ Gui    │   1    │        │ │        │   3    │   3    │   1    │        │        │
     * └────────┴────────┴────────┴────────┴────────┴────────┘ └────────┴────────┴────────┴────────┴────────┴────────┘
     */
    LAYOUT_4x12(
        _______,  KC_BSLS,  XXXXXXX,  XXXXXXX,  XXXXXXX,  XXXXXXX,  XXXXXXX,  KC_LPRN,  KC_RPRN,  KC_LBRC,  KC_RBRC,  KC_GRV,
        _______,  KC_EXLM,   KC_AT ,  KC_HASH,  KC_DLR,   KC_PERC,  KC_CIRC,  KC_AMPR,  KC_ASTR,  KC_LCBR,  KC_RCBR,  _______,
        _______,  KC_PIPE,  XXXXXXX,  XXXXXXX,  KC_EQL,   KC_PLUS,  KC_MINS,  KC_UNDS,  KC_LABK,  KC_RABK,  KC_QUES,  _______,
        _______,  _______,  _______,  _______,  _______,  KC_SPC,   KC_BSPC,  _______,  _______,  LHT(1),   KC_UP,    KC_DOWN
    ),

    /* Layer 2
     * ┌────────┬────────┬────────┬────────┬────────┬────────┐ ┌────────┬────────┬────────┬────────┬────────┬────────┐
     * │ Tab    │   F1   │   F2   │   F3   │   F4   │  PgUp  │ │  PgDn  │   F9   │  F10   │  F11   │  F12   │   '    │
     * │        │        │        │        │        │        │ │        │        │        │        │        │        │
     * ├────────┼────────┼────────┼────────┼────────┼────────┤ ├────────┼────────┼────────┼────────┼────────┼────────┤
     * │ Ctrl   │   1    │   2    │   3    │   4    │   5    │ │   6    │   7    │   8    │   9    │   0    │ Enter  │
     * │ ESC    │        │        │        │        │        │ │        │        │        │        │        │        │
     * ├────────┼────────┼────────┼────────┼────────┼────────┤ ├────────┼────────┼────────┼────────┼────────┼────────┤
     * │ OneShot│   F5   │   F6   │   F7   │   F8   │  Home  │ │  End   │   -    │   ,    │   .    │   :    │ Delete │
     * │ Shift  │        │        │        │        │        │ │        │        │        │        │        │        │
     * ├────────┼────────┼────────┼────────┼────────┼────────┤ ├────────┼────────┼────────┼────────┼────────┼────────┤
     * │ OneShot│ Layer  │ OneShot│ OneShot│ Layer  │ Space  │ │ BSpace │ Layer  │ Layer  │  LHT   │   Up   │  Down  │
     * │ Ctrl   │   3    │ Alt    │ Gui    │   1    │        │ │        │   3    │   3    │   1    │        │        │
     * └────────┴────────┴────────┴────────┴────────┴────────┘ └────────┴────────┴────────┴────────┴────────┴────────┘
     */
    LAYOUT_4x12(
        _______,  KC_F1,    KC_F2,    KC_F3,    KC_F4,    KC_PGUP,  KC_PGDN,  KC_F9,    KC_F10,   KC_F11,   KC_F12,   KC_QUOT,
        _______,  KC_1,     KC_2,     KC_3,     KC_4,     KC_5,     KC_6,     KC_7,     KC_8,     KC_9,     KC_0,     _______,
        _______,  KC_F5,    KC_F6,    KC_F7,    KC_F8,    KC_HOME,  KC_END,   KC_MINS,  KC_COMM,  KC_DOT,   KC_COLN,  _______,
        _______,  _______,  _______,  _______,  _______,  KC_SPC,   KC_BSPC,  _______,  _______,  _______,  _______,  _______
    ),

    /* Layer 3
     * ┌────────┬────────┬────────┬────────┬────────┬────────┐ ┌────────┬────────┬────────┬────────┬────────┬────────┐
     * │ Tab    │        │        │  Alt+  │  Alt+  │ VolUp  │ │        │  PgUp  │   Up   │  PgDn  │        │ Screen │
     * │        │        │        │   A    │   S    │        │ │        │        │        │        │        │ Saver  │
     * ├────────┼────────┼────────┼────────┼────────┼────────┤ ├────────┼────────┼────────┼────────┼────────┼────────┤
     * │ Ctrl   │        │        │  Alt+  │  Alt+  │ VolDn  │ │        │  Left  │  Down  │  Right │        │ Enter  │
     * │ ESC    │        │        │   Q    │   W    │        │ │        │        │        │        │        │        │
     * ├────────┼────────┼────────┼────────┼────────┼────────┤ ├────────┼────────┼────────┼────────┼────────┼────────┤
     * │ OneShot│        │        │  Alt+  │  Alt+  │ VolMut │ │        │  Home  │ Insert │  End   │        │ Delete │
     * │ Shift  │        │        │   1    │   2    │        │ │        │        │        │        │        │        │
     * ├────────┼────────┼────────┼────────┼────────┼────────┤ ├────────┼────────┼────────┼────────┼────────┼────────┤
     * │ OneShot│ Layer  │ Shift+ │ OneShot│   ,    │  Calc  │ │ BSpace │ Layer  │ Layer  │  LHT   │   Up   │  Down  │
     * │ Ctrl   │   3    │ Insert │ Gui    │        │        │ │        │   3    │   3    │   1    │        │        │
     * └────────┴────────┴────────┴────────┴────────┴────────┘ └────────┴────────┴────────┴────────┴────────┴────────┘
     */
    LAYOUT_4x12(
        _______,  XXXXXXX,  XXXXXXX,   LALT(KC_A),  LALT(KC_S),  KC_VOLUP,  XXXXXXX,  KC_PGUP,  KC_UP,    KC_PGDN,   XXXXXXX,  KC_SCR_SVR,
        _______,  XXXXXXX,  XXXXXXX,   LALT(KC_Q),  LALT(KC_W),  KC_VOLDN,  XXXXXXX,  KC_LEFT,  KC_DOWN,  KC_RIGHT,  XXXXXXX,  _______,
        _______,  XXXXXXX,  XXXXXXX,   LALT(KC_1),  LALT(KC_2),  KC_MUTE,   XXXXXXX,  KC_HOME,  KC_INS,   KC_END,    XXXXXXX,  _______,
        _______,  _______,  SHFT_INS,  _______,     KC_COMM,     KC_CALC,   KC_BSPC,  _______,  _______,  _______,   _______,  _______
    ),

    /* Layer 4
     * ┌────────┬────────┬────────┬────────┬────────┬────────┐ ┌────────┬────────┬────────┬────────┬────────┬────────┐
     * │ Tab    │        │        │        │        │        │ │        │        │        │        │        │   '    │
     * │        │        │        │        │        │        │ │        │        │        │        │        │        │
     * ├────────┼────────┼────────┼────────┼────────┼────────┤ ├────────┼────────┼────────┼────────┼────────┼────────┤
     * │ Ctrl   │ OneShot│ OneShot│ OneShot│ OneShot│        │ │        │  Gui+  │  Gui+  │        │ Layer3 │ Enter  │
     * │ ESC    │ Shift  │ Gui    │ Ctrl   │ Alt    │        │ │        │  F13   │  F14   │        │   ;    │        │
     * ├────────┼────────┼────────┼────────┼────────┼────────┤ ├────────┼────────┼────────┼────────┼────────┼────────┤
     * │ OneShot│        │        │        │        │        │ │        │  Gui+  │  Gui+  │  Gui+  │ Layer4 │ Delete │
     * │ Shift  │        │        │        │        │        │ │        │  PgUp  │  PgDn  │   Z    │   /    │        │
     * ├────────┼────────┼────────┼────────┼────────┼────────┤ ├────────┼────────┼────────┼────────┼────────┼────────┤
     * │ OneShot│ Layer  │ OneShot│ OneShot│ Layer  │ Shift  │ │ Layer2 │ Layer  │ Layer  │  LHT   │  Left  │ Right  │
     * │ Ctrl   │   3    │ Alt    │ Gui    │   1    │ Space  │ │ BSpace │   3    │   3    │   1    │        │        │
     * └────────┴────────┴────────┴────────┴────────┴────────┘ └────────┴────────┴────────┴────────┴────────┴────────┘
     */
    LAYOUT_4x12(
        KC_TAB,    XXXXXXX,   XXXXXXX,   XXXXXXX,  XXXXXXX,  XXXXXXX,    XXXXXXX,  XXXXXXX,  XXXXXXX,  XXXXXXX,    XXXXXXX,    KC_QUOT,
        CTRL_ESC,  OSM_SHFT,  OSM_GUI,   OSM_CTRL, OSM_ALT,  XXXXXXX,    XXXXXXX,  GUI_F13,  GUI_F14,  XXXXXXX,    L3_SCOLON,  KC_ENTER,
        OSM_SHFT,  XXXXXXX,   XXXXXXX,   XXXXXXX,  XXXXXXX,  XXXXXXX,    XXXXXXX,  GUI_PGUP, GUI_PGDN, LGUI(KC_Z), L4_SLASH,   KC_DELETE,
        OSM_CTRL,  LP(3),     OSM_ALT,   OSM_GUI,  LP(1),    SHIFT_SPC,  L2_BSPC,  _______,  _______,  LHT(1),     KC_LEFT,    KC_RIGHT
    ),
});

#include "keymap.hpp"

const uint32_t keymap[][KEYBOARD_ROWS][2*KEYBOARD_COLS] = KEYMAP({
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
    LAYOUT_4x10(
        KC_Q,      KC_W,      KC_E,     KC_R,      KC_T,    KC_Y,      KC_U,       KC_I,     KC_O,     KC_P,
        KC_A,      KC_S,      KC_D,     KC_F,      KC_G,    KC_H,      KC_J,       KC_K,     KC_L,     KC_H,
        KC_Z,      KC_X,      KC_C,     KC_V,      KC_B,    KC_N,      KC_M,       KC_COMM,  KC_DOT,   KC_J,
        KC_Q,      KC_W,      KC_NO,    KC_NO,     KC_NO,   KC_G,      KC_H,       KC_NO,    KC_NO,    KC_NO
    )
});

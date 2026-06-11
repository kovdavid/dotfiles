#include "keymap.hpp"
#include "combo.hpp"
#include "key_definitions.hpp"
#include "macro.hpp"

#define LDEFAULT 0
#define LSYM 1
#define LNAV 2
#define LNUM 3
#define LWIN 4

#define CTRL_ESC    DM(MOD_LCTRL, KC_ESCAPE)
#define LNUM_ENT    THDL(LNUM, KC_ENTER)
#define SHFT_SPC    THDM(MOD_RSHIFT, KC_SPACE)
#define LNAV_BSPC   THDL(LNAV, KC_BSPC)
#define LSYM_SCLN   DSL(LSYM, KC_SEMICOLON)
#define LWIN_SLASH  DSL(LWIN, KC_SLASH)
#define SHFT_INS    LSHIFT(KC_INSERT)

#define CTAB  LCTRL(KC_TAB)
#define CSTAB LCTRL(KC_TAB) | MOD_LSHIFT

const KeyCoords combo1[] = { { 1, 2 }, { 1, 3 } }; // Tab
const KeyCoords combo2[] = { { 0, 6 }, { 0, 7 } }; // CTRL+A
const KeyCoords combo3[] = { { 0, 7 }, { 0, 8 } }; // CTRL+W

const KeyCoords combo4[] = { { 1, 1 }, { 2, 1 } }; // LEFT MODS: GUI
const KeyCoords combo5[] = { { 1, 2 }, { 2, 2 } }; // LEFT MODS: CTRL
const KeyCoords combo6[] = { { 1, 3 }, { 2, 3 } }; // LEFT MODS: SHFT

const KeyCoords combo7[] = { { 1, 6 }, { 2, 6 } }; // RIGHT MODS: SHFT
const KeyCoords combo8[] = { { 1, 7 }, { 2, 7 } }; // RIGHT MODS: CTRL
const KeyCoords combo9[] = { { 1, 8 }, { 2, 8 } }; // RIGHT MODS: ALT

const KeyCoords combo11[] = { { 1, 7 }, { 1, 8 } }; // Del

const KeyCoords combo12[] = { { 2, 1 }, { 2, 3 } }; // GUI + SHFT
const KeyCoords combo13[] = { { 2, 2 }, { 2, 3 } }; // CTRL + SHFT
const KeyCoords combo14[] = { { 2, 6 }, { 2, 7 } }; // CTRL + SHFT

Combo combos[] = COMBOS({
    COMBO(combo1, KC_TAB),
    COMBO(combo2, LCTRL(KC_A)),
    COMBO(combo3, LCTRL(KC_W)),

    COMBO(combo4, OSM(MOD_LGUI)),
    COMBO(combo5, OSM(MOD_LCTRL)),
    COMBO(combo6, OSM(MOD_LSHIFT)),

    COMBO(combo7, OSM(MOD_RSHIFT)),
    COMBO(combo8, OSM(MOD_RCTRL)),
    COMBO(combo9, OSM(MOD_LALT)),

    COMBO(combo11, KC_DELETE),

    COMBO(combo12, OSM(MOD_LGUI | MOD_LSHIFT)),
    COMBO(combo13, OSM(MOD_LCTRL | MOD_LSHIFT)),
    COMBO(combo14, OSM(MOD_RCTRL | MOD_RSHIFT))
});

MacroStep m1_steps[] = {
    { MACRO_ACTION_PRESS, LCTRL(KC_A) },
    { MACRO_ACTION_RELEASE, LCTRL(KC_A) },
    { MACRO_ACTION_PRESS, KC_MINUS },
    { MACRO_ACTION_RELEASE, KC_MINUS }
};

MacroStep m2_steps[] = {
    { MACRO_ACTION_PRESS, LCTRL(KC_A) },
    { MACRO_ACTION_RELEASE, LCTRL(KC_A) },
    { MACRO_ACTION_PRESS, KC_PLUS },
    { MACRO_ACTION_RELEASE, KC_PLUS }
};

MacroStep m3_steps[] = {
    { MACRO_ACTION_PRESS, LCTRL(KC_A) },
    { MACRO_ACTION_RELEASE, LCTRL(KC_A) },
    { MACRO_ACTION_PRESS, KC_LABK },
    { MACRO_ACTION_RELEASE, KC_LABK }
};

MacroStep m4_steps[] = {
    { MACRO_ACTION_PRESS, LCTRL(KC_A) },
    { MACRO_ACTION_RELEASE, LCTRL(KC_A) },
    { MACRO_ACTION_PRESS, KC_RABK },
    { MACRO_ACTION_RELEASE, KC_RABK }
};

Macro macros[] = MACROS({
    MACRO(m1_steps), // CTRL+A -
    MACRO(m2_steps), // CTRL+A +
    MACRO(m3_steps), // CTRL+A <
    MACRO(m4_steps)  // CTRL+A >
});

const uint32_t keymap[][KEYBOARD_ROWS][2*KEYBOARD_COLS] = KEYMAP({

    /***** Combos

           0        1        2        3        4                  5        6        7        8        9
       ┌────────┬────────┬────────┬────────┬────────┐         ┌────────┬────────┬────────┬────────┬────────┐
     0 │        │        │        │        │        │         │        │      CTRL     CTRL       │        │
       │        │        │        │        │        │         │        │        A        W        │        │
       ├────────┼────────┼────────┼────────┼────────┤         ├────────┼────────┼────────┼────────┼────────┤
     1 │        │        │       Tab       │        │         │        │        │       Del       │        │
       │        │        │        │        │        │         │        │        │        │        │        │
       ├────────┼─ GUI  ─┼─ CTRL ─┼─ SHFT ─┼────────┤         ├────────┼─ SHFT ─┼─ CTRL ─┼─ ALT  ─┼────────┤
     2 │        │        │       C+S       │        │         │        │       C+S       │        │        │
       │        │* G+S  *│        │* G+S  *│        │         │        │        │        │        │        │
       └────────┴────────┴────────┼────────┼────────┤         ├────────┼────────┼────────┴────────┴────────┘
     3                            │        │        │         │        │        │
                                  │        │        │         │        │        │
                                  └────────┴────────┘         └────────┴────────┘

    *****/

    /***** Layer DEFAULT
       ┌────────┬────────┬────────┬────────┬────────┐               ┌────────┬────────┬────────┬────────┬────────┐
       │   Q    │   W    │   E    │   R    │   T    │               │   Y    │   U    │   I    │   O    │   P    │
       │        │        │        │        │        │               │        │        │        │        │        │
       ├────────┼────────┼────────┼────────┼────────┤               ├────────┼────────┼────────┼────────┼────────┤
       │   A    │   S    │   D    │   F    │   G    │               │   H    │   J    │   K    │   L    │ L SYM  │
       │        │        │        │        │        │               │        │        │        │        │   :    │
       ├────────┼────────┼────────┼────────┼────────┤               ├────────┼────────┼────────┼────────┼────────┤
       │   Z    │   X    │   C    │   V    │   B    │               │   N    │   M    │   ,    │   .    │ L WIN  │
       │        │        │        │        │        │               │        │        │        │        │   /    │
       └────────┴────────┴────────┼────────┼────────┤               ├────────┼────────┼────────┴────────┴────────┘
                                  │  CTRL  │ SHIFT  │               │ L NUM  │ L NAV  │
                                  │ ESCAPE │ SPACE  │               │ RETURN │ BSPACE │
                                  └────────┴────────┘               └────────┴────────┘
    *****/

    LAYOUT_4x10(
        KC_Q,   KC_W,    KC_E,    KC_R,     KC_T,                   KC_Y,     KC_U,      KC_I,    KC_O,   KC_P,
        KC_A,   KC_S,    KC_D,    KC_F,     KC_G,                   KC_H,     KC_J,      KC_K,    KC_L,   LSYM_SCLN,
        KC_Z,   KC_X,    KC_C,    KC_V,     KC_B,                   KC_N,     KC_M,      KC_COMM, KC_DOT, LWIN_SLASH,
        XXX,    XXX,     XXX,     CTRL_ESC, SHFT_SPC,               LNUM_ENT, LNAV_BSPC, XXX,     XXX,    XXX
    ),

    /***** Layer SYM
       ┌────────┬────────┬────────┬────────┬────────┐               ┌────────┬────────┬────────┬────────┬────────┐
       │   !    │   @    │   #    │   $    │   ~    │               │        │   [    │   "    │   ]    │        │
       │        │        │        │        │        │               │        │        │        │        │        │
       ├────────┼────────┼────────┼────────┼────────┤               ├────────┼────────┼────────┼────────┼────────┤
       │   %    │   ^    │   &    │   *    │   `    │               │        │   (    │   _    │   )    │*L SYM *│
       │        │        │        │        │        │               │        │        │        │        │        │
       ├────────┼────────┼────────┼────────┼────────┤               ├────────┼────────┼────────┼────────┼────────┤
       │   |    │   +    │   =    │   -    │   \    │               │        │   {    │   '    │   }    │        │
       │        │        │        │        │        │               │        │        │        │        │        │
       └────────┴────────┴────────┼────────┼────────┤               ├────────┼────────┼────────┴────────┴────────┘
                                  │  CTRL  │ SHIFT  │               │ L NUM  │ L NAV  │
                                  │ ESCAPE │ SPACE  │               │ RETURN │ BSPACE │
                                  └────────┴────────┘               └────────┴────────┘
    *****/

    LAYOUT_4x10(
        KC_EXLM, KC_AT,   KC_HASH, KC_DLR,  KC_TILD,                XXX,     KC_LBRC,  KC_DQUO,  KC_RBRC,   XXX,
        KC_PERC, KC_CIRC, KC_AMPR, KC_ASTR, KC_GRV,                 XXX,     KC_LPRN,  KC_UNDS,  KC_RPRN,   ___,
        KC_PIPE, KC_PLUS, KC_EQL,  KC_MINS, KC_BSLS,                XXX,     KC_LCBR,  KC_QUOT,  KC_RCBR,   XXX,
        XXX,     XXX,     XXX,     ___,     ___,                    ___,     ___,      XXX,      XXX,       XXX
    ),

    /***** Layer NAV
       ┌────────┬────────┬────────┬────────┬────────┐               ┌────────┬────────┬────────┬────────┬────────┐
       │  F1    │  F2    │  F3    │  F4    │ VolUp  │               │        │  PgUp  │   Up   │  PgDn  │        │
       │        │        │        │        │        │               │        │        │        │        │        │
       ├────────┼────────┼────────┼────────┼────────┤               ├────────┼────────┼────────┼────────┼────────┤
       │  F5    │  F6    │  F7    │  F8    │ VolDn  │               │ Shift+ │  Left  │  Down  │  Right │ C(Tab) │
       │        │        │        │        │        │               │ Insert │        │        │        │        │
       ├────────┼────────┼────────┼────────┼────────┤               ├────────┼────────┼────────┼────────┼────────┤
       │  F9    │  F10   │  F11   │  F12   │ VolMut │               │        │  Home  │ Insert │  End   │ CS Tab │
       │        │        │        │        │        │               │        │        │        │        │        │
       └────────┴────────┴────────┼────────┼────────┤               ├────────┼────────┼────────┴────────┴────────┘
                                  │  CTRL  │ SHIFT  │               │ L NUM  │*L NAV *│
                                  │ ESCAPE │ SPACE  │               │ RETURN │*BSPACE*│
                                  └────────┴────────┘               └────────┴────────┘
    *****/

    LAYOUT_4x10(
        KC_F1,   KC_F2,   KC_F3,   KC_F4,   KC_VOLUP,               XXX,      KC_PGUP, KC_UP,   KC_PGDN,  XXX,
        KC_F5,   KC_F6,   KC_F7,   KC_F8,   KC_VOLDN,               SHFT_INS, KC_LEFT, KC_DOWN, KC_RIGHT, CTAB,
        KC_F9,   KC_F10,  KC_F11,  KC_F12,  KC_MUTE,                XXX,      KC_HOME, KC_INS,  KC_END,   CSTAB,
        XXX,     XXX,     XXX,     ___,      ___,                   ___,      ___,     XXX,     XXX,      XXX
    ),

    /***** Layer NUM
       ┌────────┬────────┬────────┬────────┬────────┐               ┌────────┬────────┬────────┬────────┬────────┐
       │ CTRL+A │ CTRL+A │  Alt   │  Alt   │        │               │   +    │   7    │   8    │   9    │   :    │
       │   -    │   +    │   A    │   S    │        │               │        │        │        │        │        │
       ├────────┼────────┼────────┼────────┼────────┤               ├────────┼────────┼────────┼────────┼────────┤
       │ CTRL+A │ CTRL+A │  Alt   │  Alt   │        │               │   -    │   4    │   5    │   6    │   0    │
       │   <    │   >    │   Q    │   W    │        │               │        │        │        │        │        │
       ├────────┼────────┼────────┼────────┼────────┤               ├────────┼────────┼────────┼────────┼────────┤
       │        │        │  Alt   │  Alt   │        │               │   =    │   1    │   2    │   3    │   .    │
       │        │        │   1    │   2    │        │               │        │        │        │        │        │
       └────────┴────────┴────────┼────────┼────────┤               ├────────┼────────┼────────┴────────┴────────┘
                                  │  CTRL  │ SHIFT  │               │*L NUM *│ L NAV  │
                                  │ ESCAPE │ SPACE  │               │*RETURN*│ BSPACE │
                                  └────────┴────────┘               └────────┴────────┘
    *****/

    LAYOUT_4x10(
        KC_MACRO1, KC_MACRO2, LALT(KC_A), LALT(KC_S), XXX,          KC_PLUS, KC_7,    KC_8,    KC_9,    KC_COLON,
        KC_MACRO3, KC_MACRO4, LALT(KC_Q), LALT(KC_W), XXX,          KC_MINS, KC_4,    KC_5,    KC_6,    KC_0,
        XXX,       XXX,       LALT(KC_1), LALT(KC_2), XXX,          KC_EQL,  KC_1,    KC_2,    KC_3,    KC_DOT,
        XXX,       XXX,       XXX,        ___,        ___,          ___,     ___,     XXX,     XXX,     XXX
    ),

    /***** Layer WIN

       ┌────────┬────────┬────────┬────────┬────────┐                 ┌────────┬────────┬────────┬────────┬────────┐
       │ Shift+ │  Gui+  │  Gui+  │  Gui+  │  Gui+  │                 │        │        │        │        │        │
       │ Insert │   C    │   V    │   R    │ SPACE  │                 │        │        │        │        │        │
       ├────────┼────────┼────────┼────────┼────────┤                 ├────────┼────────┼────────┼────────┼────────┤
       │  Gui+  │  Gui+  │  Gui+  │  Gui+  │  Gui+  │                 │        │        │        │        │        │
       │   1    │   2    │   3    │   4    │  Tab   │                 │        │        │        │        │        │
       ├────────┼────────┼────────┼────────┼────────┤                 ├────────┼────────┼────────┼────────┼────────┤
       │  Gui+  │  Gui+  │  Gui+  │  Gui+  │  Gui+  │                 │ Screen │        │        │ SHIFT  │*L WIN *│
       │  F1    │  F2    │  F3    │  F4    │ Return │                 │ Saver  │        │        │        │*  /   *│
       └────────┴────────┴────────┼────────┼────────┤                 ├────────┼────────┼────────┴────────┴────────┘
                                  │  Gui+  │  Gui+  │                 │ L NUM  │ L NAV  │
                                  │   Z    │   F    │                 │ RETURN │ BSPACE │
                                  └────────┴────────┘                 └────────┴────────┘
    *****/

    LAYOUT_4x10(
        LSHIFT(KC_INSERT), LGUI(KC_C),  LGUI(KC_V),  LGUI(KC_R), LGUI(KC_SPACE),   XXX,        XXX,  XXX,  XXX,        XXX,
        LGUI(KC_1),        LGUI(KC_2),  LGUI(KC_3),  LGUI(KC_4), LGUI(KC_TAB),     XXX,        XXX,  XXX,  XXX,        XXX,
        LGUI(KC_F1),       LGUI(KC_F2), LGUI(KC_F3), LGUI(KC_F4),LGUI(KC_ENT),     KC_SCR_SVR, XXX,  XXX,  MOD_LSHIFT, ___,
        XXX,               XXX,         XXX,         LGUI(KC_Z), LGUI(KC_F),       ___,        ___,  XXX,  XXX,        XXX
    )
});

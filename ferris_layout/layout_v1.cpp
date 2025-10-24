#include "keymap.hpp"
#include "combo.hpp"

// New experimental keymap. Inspiration from:
// https://github.com/aleksbrgt/qmk_firmware/blob/corne_combos/keyboards/crkbd/keymaps/5col/keymap.c

// TODO:
//     =>
//     <> on the same layer as modifiers
//     127.0.0.1
//     25-09 12:00
//     in vim:
//          qw - switch split
//          qe - switch tab
//     in tmux:
//          <prefix>c - new window
//          <prefix>s - new pane below
//          <prefix>v - new pane right
//          <alt>1 - 2 - cycle session
//          <alt>q - w - cycle window
//          <alt>a - s - cycle pane
//

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
#define SHIFT_SPC DM(MOD_LSHIFT, KC_SPACE)
#define SHFT_INS  LSHIFT(KC_INS)

#define M_BTN1 MOUSE_BUTTON(BTN1)
#define M_BTN2 MOUSE_BUTTON(BTN2)
#define M_BTN3 MOUSE_BUTTON(BTN3)
#define M_BTN4 MOUSE_BUTTON(BTN4)
#define M_BTN5 MOUSE_BUTTON(BTN5)

// i3 navigation
#define GUI_F13  LGUI(KC_F13)
#define GUI_F14  LGUI(KC_F14)
#define GUI_F15  LGUI(KC_F15)
#define GUI_F16  LGUI(KC_F16)
#define GUI_PGUP LGUI(KC_PGUP)
#define GUI_PGDN LGUI(KC_PGDN)
#define GUI_TAB  LGUI(KC_TAB)
#define GUI_RET  LGUI(KC_ENTER)
#define GUI_STAB LGUI(LSHIFT(KC_TAB))

#define LNUM_TAB    DL(LNUM, KC_TAB)
#define LNAV_BSPC   THDL(LNAV, KC_BSPC)
#define LSYM_SCOLON DSL(LSYM, KC_SEMICOLON)
#define LWIN_SLASH  DSL(LWIN, KC_SLASH)
// define LNUM_RET   DSL(LNUM, KC_ENTER)
#define LNUM_RET    THDL(LNUM, KC_ENTER)

    /* Combos
           0        1        2        3        4                            5        6        7        8        9
       ┌────────┬────────┬────────┬────────┬────────┐                   ┌────────┬────────┬────────┬────────┬────────┐
     0 │        │        │        │        │        │                   │        │      *CTRL  +   A*       │        │
       │        │        │        │        │        │                   │        │        │        │        │        │
       ├────────┼────────┼────────┼────────┼────────┤                   ├────────┼────────┼────────┼────────┼────────┤
     1 │        │     *GUI*    *SHIFT*     │        │                   │        │      *CTRL*   *ALT*      │        │
       │        │     *GUI   *  SHIFT*     │        │                   │        │      *CTRL  *  ALT*      │        │
       ├────────┼────────┼────────┼────────┼────────┤                   ├────────┼────────┼────────┼────────┼────────┤
     2 │        │        │        │        │        │                   │        │        │        │        │        │
       │        │        │        │        │        │                   │        │        │        │        │        │
       └────────┴────────┴────────┼────────┼────────┤                   ├────────┼────────┼────────┴────────┴────────┘
     3                            │        │        │                   │        │        │
                                  │        │        │                   │        │        │
                                  └────────┴────────┘                   └────────┴────────┘
     */

const KeyCoords combo1[] = { { 1, 1 }, { 1, 2 }           }; // LGUI
const KeyCoords combo2[] = {           { 1, 2 }, { 1, 3 } }; // LSHIFT
const KeyCoords combo3[] = { { 1, 1 }, { 1, 2 }, { 1, 3 } }; // LGUI + LSHIFT

const KeyCoords combo4[] = { { 1, 6 }, { 1, 7 }           }; // LCTRL
const KeyCoords combo5[] = {           { 1, 7 }, { 1, 8 } }; // LALT
const KeyCoords combo6[] = { { 1, 6 }, { 1, 7 }, { 1, 8 } }; // LCTRL + LALT

// const KeyCoords combo7[] = { { 3, 5 }, { 3, 6 } }; // CAPS_WORD
const KeyCoords combo8[] = { { 0, 6 }, { 0, 7 }, { 0, 8 } }; // Ctrl+a

Combo combos[] = COMBOS({
    COMBO(combo1, OSM(MOD_LGUI)),
    COMBO(combo2, OSM(MOD_LSHIFT)),
    COMBO(combo3, OSM(MOD_LGUI | MOD_LSHIFT)),

    COMBO(combo4, OSM(MOD_LCTRL)),
    COMBO(combo5, OSM(MOD_LALT)),
    COMBO(combo6, OSM(MOD_LCTRL | MOD_LALT)),

    // COMBO(combo7, CAPS_WORD),
    COMBO(combo8, LCTRL(KC_A))
});

const uint32_t keymap[][KEYBOARD_ROWS][2*KEYBOARD_COLS] = KEYMAP({
    /* Layer DEFAULT
       ┌────────┬────────┬────────┬────────┬────────┐         ┌────────┬────────┬────────┬────────┬────────┐
       │   Q    │   W    │   E    │   R    │   T    │         │   Y    │   U    │   I    │   O    │   P    │
       │        │        │        │        │        │         │        │        │        │        │        │
       ├────────┼────────┼────────┼────────┼────────┤         ├────────┼────────┼────────┼────────┼────────┤
       │   A    │   S    │   D    │   F    │   G    │         │   H    │   J    │   K    │   L    │ L NAV  │
       │        │        │        │        │        │         │        │        │        │        │        │
       ├────────┼────────┼────────┼────────┼────────┤         ├────────┼────────┼────────┼────────┼────────┤
       │   Z    │   X    │   C    │   V    │   B    │         │   N    │   M    │   ,    │   .    │ L WIN  │
       │        │        │        │        │        │         │        │        │ SFT(:) │ SFT(;) │   /    │
       └────────┴────────┴────────┼────────┼────────┤         ├────────┼────────┼────────┴────────┴────────┘
                                  │  CTRL  │ SHIFT  │         │ L SYM  │ L NAV  │
                                  │ ESCAPE │ SPACE  │         │ RETURN │ BSPACE │
                                  └────────┴────────┘         └────────┴────────┘

    */

    /* Layer NAV
       ┌────────┬────────┬────────┬────────┬────────┐         ┌────────┬────────┬────────┬────────┬────────┐
       │   :    │   .    │   =    │   -    │   +    │         │        │  PgUp  │   Up   │  PgDn  │        │
       │        │        │        │        │        │         │        │        │        │        │        │
       ├────────┼────────┼────────┼────────┼────────┤         ├────────┼────────┼────────┼────────┼────────┤
       │   1    │   2    │   3    │   4    │   5    │         │        │  Left  │  Down  │ Right  │        │
       │        │        │        │        │        │         │        │        │        │        │        │
       ├────────┼────────┼────────┼────────┼────────┤         ├────────┼────────┼────────┼────────┼────────┤
       │   6    │   7    │   8    │   9    │   0    │         │        │  Home  │ Insert │  End   │        │
       │        │        │        │        │        │         │        │        │        │        │        │
       └────────┴────────┴────────┼────────┼────────┤         ├────────┼────────┼────────┴────────┴────────┘
                                  │  CTRL  │ SHIFT  │         │ L SYM  │ L NAV  │
                                  │ ESCAPE │ SPACE  │         │ RETURN │ BSPACE │
                                  └────────┴────────┘         └────────┴────────┘


     */


    /* Layer SYM
       ┌────────┬────────┬────────┬────────┬────────┐         ┌────────┬────────┬────────┬────────┬────────┐
       │   !    │   @    │   #    │   $    │   ~    │         │        │   [    │   "    │   ]    │        │
       │        │        │        │        │        │         │        │        │        │        │        │
       ├────────┼────────┼────────┼────────┼────────┤         ├────────┼────────┼────────┼────────┼────────┤
       │   %    │   ^    │   &    │   *    │   `    │         │        │   (    │   _    │   )    │   <    │
       │        │        │        │        │        │         │        │        │        │        │        │
       ├────────┼────────┼────────┼────────┼────────┤         ├────────┼────────┼────────┼────────┼────────┤
       │   \    │   |    │   =    │   -    │   +    │         │        │   {    │   '    │   }    │   >    │
       │        │        │        │        │        │         │        │        │        │        │        │
       └────────┴────────┴────────┼────────┼────────┤         ├────────┼────────┼────────┴────────┴────────┘
                                  │  CTRL  │ SHIFT  │         │*L SYM *│ L NAV  │
                                  │ ESCAPE │ SPACE  │         │*RETURN*│ BSPACE │
                                  └────────┴────────┘         └────────┴────────┘
     */


    LAYOUT_4x10(
        KC_Q,      KC_W,      KC_E,     KC_R,      KC_T,      KC_Y,      KC_U,       KC_I,     KC_O,     KC_P,
        KC_A,      KC_S,      KC_D,     KC_F,      KC_G,      KC_H,      KC_J,       KC_K,     KC_L,     LSYM_SCOLON,
        KC_Z,      KC_X,      KC_C,     KC_V,      KC_B,      KC_N,      KC_M,       KC_COMM,  KC_DOT,   LWIN_SLASH,
        XXXXXXX,   XXXXXXX,   XXXXXXX,  KC_Q,      KC_W,      KC_G,      KC_H,       XXXXXXX,  XXXXXXX,  XXXXXXX
    )
});

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

TODO how to do ctrl+tab & ctrl+shift+tab?
TODO change Z to a dual layer key - it is pressed very infrequently

const uint32_t keymap[][KEYBOARD_ROWS][2*KEYBOARD_COLS] = KEYMAP({

    /*
       Layer DEFAULT
       ┌────────┬────────┬────────┬────────┬────────┐         ┌────────┬────────┬────────┬────────┬────────┐
       │   Q    │   W    │   E    │   R    │   T    │         │   Y    │   U    │   I    │   O    │   P    │
       │        │        │        │        │        │         │        │        │        │        │        │
       ├────────┼────────┼────────┼────────┼────────┤         ├────────┼────────┼────────┼────────┼────────┤
       │   A    │   S    │   D    │   F    │   G    │         │   H    │   J    │   K    │   L    │ L NAV  │
       │        │        │        │        │        │         │        │        │        │        │        │
       ├────────┼────────┼────────┼────────┼────────┤         ├────────┼────────┼────────┼────────┼────────┤
       │   Z    │   X    │   C    │   V    │   B    │         │   N    │   M    │   ,    │   .    │ L WIN  │
       │  MUX   │        │        │        │        │         │        │        │ SFT(:) │ SFT(;) │   /    │
       └────────┴────────┴────────┼────────┼────────┤         ├────────┼────────┼────────┴────────┴────────┘
                                  │  CTRL  │ SHIFT  │         │ L SYM  │ L NAV  │
                                  │ ESCAPE │ SPACE  │         │ RETURN │ BSPACE │
                                  └────────┴────────┘         └────────┴────────┘

       Layer MUX

            CTRL+A -> tmux prefix
                alt+a/s - cycle panes
                alt+q/w - cycle windows
                alt+1/2 - cycle sessions

       ┌────────┬────────┬────────┬────────┬────────┐         ┌────────┬────────┬────────┬────────┬────────┐
       │        │        │        │        │        │         │        │  Alt   │  Alt   │        │        │
       │        │        │        │        │        │         │        │   A    │   S    │        │        │
       ├────────┼────────┼────────┼────────┼────────┤         ├────────┼────────┼────────┼────────┼────────┤
       │        │        │        │        │        │         │        │  Alt   │  Alt   │        │        │
       │        │        │        │        │        │         │        │   Q    │   W    │        │        │
       ├────────┼────────┼────────┼────────┼────────┤         ├────────┼────────┼────────┼────────┼────────┤
       │*  Z   *│        │        │        │        │         │        │  Alt   │  Alt   │        │        │
       │* MUX  *│        │        │        │        │         │        │   1    │   2    │        │        │
       └────────┴────────┴────────┼────────┼────────┤         ├────────┼────────┼────────┴────────┴────────┘
                                  │  CTRL  │ SHIFT  │         │ CTRL+A │ CTRL+A │
                                  │ ESCAPE │ SPACE  │         │ RETURN │ BSPACE │
                                  └────────┴────────┘         └────────┴────────┘
    */

























    /* Layer DEFAULT
       ┌────────┬────────┬────────┬────────┬────────┐         ┌────────┬────────┬────────┬────────┬────────┐
       │   Q    │   W    │   E    │   R    │   T    │         │   Y    │   U    │   I    │   O    │   P    │
       │        │        │        │        │        │         │        │        │        │        │        │
       ├────────┼────────┼────────┼────────┼────────┤         ├────────┼────────┼────────┼────────┼────────┤
       │   A    │   S    │   D    │   F    │   G    │         │   H    │   J    │   K    │   L    │   :    │
       │        │        │        │        │        │         │        │        │        │        │        │
       ├────────┼────────┼────────┼────────┼────────┤         ├────────┼────────┼────────┼────────┼────────┤
       │   Z    │   X    │   C    │   V    │   B    │         │   N    │   M    │   ,    │   .    │ L WIN  │
       │        │        │        │        │        │         │        │        │        │        │   /    │
       └────────┴────────┴────────┼────────┼────────┤         ├────────┼────────┼────────┴────────┴────────┘
                                  │  CTRL  │ L SYM  │         │ SHIFT  │ L NAV  │
                                  │ ESCAPE │ SPACE  │         │ RETURN │ BSPACE │
                                  └────────┴────────┘         └────────┴────────┘

                                  what is the source of most shift/space typo? Capital letter after a space..
                                  "asd S" instead I type "asd  s"..sooo separate shift&space??

    */


    /* Layer SYM
       ┌────────┬────────┬────────┬────────┬────────┐         ┌────────┬────────┬────────┬────────┬────────┐
       │   !    │   @    │   #    │   $    │   ~    │         │        │   [    │   "    │   ]    │        │
       │        │        │        │        │        │         │        │        │        │        │        │
       ├────────┼────────┼────────┼────────┼────────┤         ├────────┼────────┼────────┼────────┼────────┤
       │   %    │   ^    │   &    │   *    │   `    │         │        │   (    │   _    │   )    │   >    │
       │        │        │        │        │        │         │        │        │        │        │        │
       ├────────┼────────┼────────┼────────┼────────┤         ├────────┼────────┼────────┼────────┼────────┤
       │   \    │   |    │   =    │   -    │   +    │         │        │   {    │   '    │   }    │   <    │
       │        │        │        │        │        │         │        │        │        │        │        │
       └────────┴────────┴────────┼────────┼────────┤         ├────────┼────────┼────────┴────────┴────────┘
                                  │  CTRL  │ SHIFT  │         │*L SYM *│ L NAV  │
                                  │ ESCAPE │ SPACE  │         │*RETURN*│ BSPACE │
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
                                  │  CTRL  │ L SYM  │         │ SHIFT  │*L NAV *│
                                  │ ESCAPE │ SPACE  │         │ RETURN │*BSPACE*│
                                  └────────┴────────┘         └────────┴────────┘

                                            TODO shift to the right
                                                 and lsym return to the left, so that I have a layer key on the left hand as well


     */



    /* Layer WIN
     *
     * This left side should be for vim, things like
     * cycle tabs, split => this is probably not necessary as the are already comfortable on the default layer
     * Move split to tab (C+W => T)
     * split horizontal and vertical
     * close split
     * maximize split, cycle splits maximized, equalize splits
     * todo add tmux - toggle panes, windows, sessions
     *
                                                                         WIN L    WIN R
       ┌────────┬────────┬────────┬────────┬────────┐         ┌────────┬────────┬────────┬────────┬────────┐
       │  F11   │  F12   │  Gui+  │  Gui+  │        │         │        │        │        │        │        │
       │        │        │   C    │   V    │        │         │        │        │        │        │        │
       ├────────┼────────┼────────┼────────┼────────┤         ├────────┼────────┼────────┼────────┼────────┤
       │  F01   │  F02   │  F03   │  F04   │  F05   │         │  Gui+  │  Gui+  │  Gui+  │  Gui+  │        │
       │        │        │        │        │        │         │  Tab   │  F13   │  F14   │   R    │        │
       ├────────┼────────┼────────┼────────┼────────┤         ├────────┼────────┼────────┼────────┼────────┤
       │  F06   │  F07   │  F08   │  F09   │  F10   │         │  Gui+  │  Gui+  │  Gui+  │  Gui+  │*L WIN *│
       │        │        │        │        │        │         │ S(Tab) │  F15   │  F16   │   Z    │*  /   *│
       └────────┴────────┴────────┼────────┼────────┤         ├────────┼────────┼────────┴────────┴────────┘
                                  │        │        │         │  Gui+  │  Gui+  │
                                  │        │        │         │ RETURN │   F    │
                                  └────────┴────────┘         └────────┴────────┘
                                                                Toggle    Zoom
     */





    LAYOUT_4x10(
        KC_Q,      KC_W,      KC_E,     KC_R,      KC_T,      KC_Y,      KC_U,       KC_I,     KC_O,     KC_P,
        KC_A,      KC_S,      KC_D,     KC_F,      KC_G,      KC_H,      KC_J,       KC_K,     KC_L,     LSYM_SCOLON,
        KC_Z,      KC_X,      KC_C,     KC_V,      KC_B,      KC_N,      KC_M,       KC_COMM,  KC_DOT,   LWIN_SLASH,
        XXXXXXX,   XXXXXXX,   XXXXXXX,  KC_Q,      KC_W,      KC_G,      KC_H,       XXXXXXX,  XXXXXXX,  XXXXXXX
    )
});

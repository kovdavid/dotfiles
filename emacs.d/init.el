(setq package-archives '(("gnu" . "http://elpa.gnu.org/packages/")
                         ("marmalade" . "http://marmalade-repo.org/packages/")
                         ("melpa" . "http://melpa.org/packages/")))

(require 'package)
(package-initialize)

(require 'evil)
(evil-mode 1)
(global-evil-leader-mode)
(evil-leader/set-leader ",")
(setq evil-leader/in-all-states 1)

(add-hook 'haskell-mode-hook 'intero-mode)

(linum-relative-global-mode)
(setq linum-format "%2s ")
(setq linum-relative-format "%2s ")
(setq linum-relative-current-symbol "")

(setq tab-width 4)
(setq tab-stop-list (number-sequence 4 200 4))
(setq indent-tabs-mode nil)

(color-theme-approximate-on)

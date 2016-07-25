(setq package-archives '(("gnu" . "http://elpa.gnu.org/packages/")
                         ("marmalade" . "http://marmalade-repo.org/packages/")
                         ("melpa" . "http://melpa.org/packages/")))

(require 'package)
(package-initialize)

(require 'evil)
(evil-mode 1)
; (global-evil-tabs-mode t)
(global-evil-leader-mode)
(evil-leader/set-leader ",")
(setq evil-leader/in-all-states 1)

(add-hook 'haskell-mode-hook 'intero-mode)

(color-theme-approximate-on)

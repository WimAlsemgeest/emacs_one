;; ---------------------------------------------------------------
;;    Emacs configuration
;;    Wim Alsemgeest
;; ---------------------------------------------------------------
;;    History:
;;             - Started the configuration on 10-06-2023
;; ---------------------------------------------------------------

;; ----- General settings ----------------------------------------
(setq inhibit-startup-message t)       ;; Don't show the splash screen
(setq visible-bell t)                  ;; Flash when the bell rings
(tool-bar-mode -1)                     ;; Turn off the toolbar
(scroll-bar-mode -1)                   ;; Turn off the scrollbar
;; (menu-bar-mode -1)                     ;; Turn off the menubar
(global-display-line-numbers-mode 1)   ;; Show linenumbers
(setq column-number-mode t)            ;; Show column numbers



;; ----- Theme ----------------------------------------------------------------
;;   Theme configuration before loading the theme

(load-theme 'modus-vivendi t)          ;; Load the theme

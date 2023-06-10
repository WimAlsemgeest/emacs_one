;; ----------------------------------------------------------------------------
;;    Emacs configuration
;;    Wim Alsemgeest
;; ----------------------------------------------------------------------------
;;    History:
;;             - Started the configuration on 10-06-2023
;; ----------------------------------------------------------------------------

;; ----- General settings -----------------------------------------------------
(setq inhibit-startup-message t)       ;; Don't show the splash screen
(setq visible-bell t)                  ;; Flash when the bell rings
(tool-bar-mode -1)                     ;; Turn off the toolbar
(scroll-bar-mode -1)                   ;; Turn off the scrollbar
;; (menu-bar-mode -1)                     ;; Turn off the menubar
(global-display-line-numbers-mode 1)   ;; Show linenumbers
(setq column-number-mode t)            ;; Show column numbers
(recentf-mode 1)                       ;; Remember the last edited files
(setq history-length 25)               ;; Remember the last minibuffer prompts
(savehist-mode 1)                      ;; Enable save-history mode
(save-place-mode 1)                    ;; Remember and restore de last cursor position
(setq use-dialog-box nil)              ;; Prevent using UI dialog for prompts
(global-auto-revert-mode 1)            ;; Revert buffers when file is changed
(setq global-auto-revert-non-file-buffers t)  ;; Revert Dired and other buffers


;; ----- Move customization variables to a separate file and load it ----------
(setq custom-file (locate-user-emacs-file "custom-vars.el"))
(load custom-file 'noerror 'nomessage)

;; ----- Theme ----------------------------------------------------------------
;;   Theme configuration before loading the theme

(load-theme 'modus-vivendi t)          ;; Load the theme

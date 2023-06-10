;; -------------------------------------------------------------------------------------------------
;;    Emacs configuration
;;    Wim Alsemgeest
;; -------------------------------------------------------------------------------------------------
;;    History:
;;             - Started the configuration on 10-06-2023
;;             - Added use-package on 10-06-2023
;;             - Added modus-themes with use-package on 20-06-2023
;; -------------------------------------------------------------------------------------------------

;; ----- General settings --------------------------------------------------------------------------
(setq inhibit-startup-message t)       ;; Don't show the splash screen
(setq visible-bell t)                  ;; Flash when the bell rings
(tool-bar-mode -1)                     ;; Turn off the toolbar
(scroll-bar-mode -1)                   ;; Turn off the scrollbar
;; (menu-bar-mode -1)                     ;; Turn off the menubar

;; ----- Make ESC quit prompts ---------------------------------------------------------------------
(global-set-key (kbd "<escape>") 'keyboard-escape-quit)

(global-display-line-numbers-mode 1)   ;; Show linenumbers
(setq column-number-mode t)            ;; Show column numbers
(recentf-mode 1)                       ;; Remember the last edited files
(setq history-length 25)               ;; Remember the last minibuffer prompts
(savehist-mode 1)                      ;; Enable save-history mode
(save-place-mode 1)                    ;; Remember and restore de last cursor position
(setq use-dialog-box nil)              ;; Prevent using UI dialog for prompts
(global-auto-revert-mode 1)            ;; Revert buffers when file is changed
(setq global-auto-revert-non-file-buffers t)  ;; Revert Dired and other buffers


;; ----- Move customization variables to a separate file and load it -------------------------------
(setq custom-file (locate-user-emacs-file "custom-vars.el"))
(load custom-file 'noerror 'nomessage)

;; ----- Font configuration for Org and others
;; Main type face
(set-face-attribute 'default nil :family "Source Code Pro" :height 110)

;; Proportionately spaced typeface
(set-face-attribute 'variable-pitch nil :family "URW Bookman" :height 110)

;; Fixed type face
(set-face-attribute 'fixed-pitch nil :family "Source Code Pro" :height 110)

;; ----- Add padding in emacs frames ---------------------------------------------------------------



;; ----- Initialize package sources ----------------------------------------------------------------
(require 'package)

(setq package-archives '(("melpa" . "https://melpa.org/packages/")
			 ("org" . "https://orgmode.org/elpa/")
			 ("elpa" . "https://elpa.gnu.org/packages/")))

(package-initialize)
(unless package-archive-contents
  (package-refresh-contents))

;; ----- Initialize use-package --------------------------------------------------------------------
;; Link to use-package https://github.com/jwiegley/use-package#installing-use-package
(unless (package-installed-p 'use-package)
  (package-install 'use-package))

(require 'use-package)
(setq use-package-always-ensure t)

;; ----- Theme -------------------------------------------------------------------------------------
;;   Theme configuration before loading the theme
;;   Link to website modus-themes https://protesilaos.com/emacs/
(use-package modus-themes
  :ensure t
  :config
  ;; Add all your customizations prior to loading the themes
  (setq modus-themes-italic-constructs t
	modus-themes-bold-constructs t
	modus-themes-mixed-fonts t

	modus-themes-org-blocks "gray-background"
	)

  (setq modus-themes-headings
	'((1 . (variable-pitch 1.8))
	  (2 . (variable-pitch 1.6))
	  (3 . (variable-pitch 1.4))
	  (4 . (variable-pitch 1.2))
	  (5 . (variable-pitch 1.0))
	  ))
  

  ;; Maybe define some palette overrides, such as by using our presets
  ;; (setq modus-themes-common-palette-overrides
  ;;	modus-themes-preset-overrides-intense)
  )

;; ----- Load the theme and define a key to toggle dark and light ----------------------------------
(load-theme 'modus-vivendi-tinted t)
(define-key global-map (kbd "<f5>") #'modus-themes-toggle))


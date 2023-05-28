;; Wim's Emacs configuratie
;; 26-05-2023
;; -----------------------------------------------------------------------------

;; ----- Add melpa to the installation -----------------------------------------
(require 'package)
(setq package-archives '(("melpa" . "https://melpa.org/packages/")
			 ("org" . "https://orgmode.org/elpa/")
			 ("elpa" . "https://elpa.gnu.org/packages/")))

(package-initialize)
  (unless package-archive-contents
    (package-refresh-contents))

(unless (package-installed-p 'use-package)
  (package-install 'use-package))

(require 'use-package)
(setq use-package-always-ensure t)

;; ----- Onderdruk startup bericht ---------------------------------------------
(setq inhibit-startup-message t)

;; ----- Maak de bel visueel ---------------------------------------------------
(setq visible-bell t)

;; ----- Verberg wat UI eigenschappen ------------------------------------------
;; (menu-bar-mode -1)
(tool-bar-mode -1)
(scroll-bar-mode -1)
(set-fringe-mode 10)
(setq use-dialog-box nil)

;; ----- Automatisch buffers bijwerken als die extern gewijzigd worden ---------
(global-auto-revert-mode 1)

;; (toggle-frame-maximized)

;; ESC key quit commands same as C-x g
(global-set-key (kbd "<escape>") 'keyboard-escape-quit)

;; ----- Laat regel en kolom nummers zien --------------------------------------
(global-display-line-numbers-mode 1)
(setq column-number-mode t)

;; ----- Disable line numbers for some modes
(dolist (mode '(org-mode-hook
		term-mode-hook
		shell-mode-hook
		treemacs-mode-hook
		eshell-mode-hook))
  (add-hook mode (lambda () (display-line-numbers-mode 0))))

;; ----- Onthoud de laatste gebruikte bestanden --------------------------------
;; Met het commendo recent-open-files krijgen we een lijst met de laatst
;; gebruikte bestanden. Kies nummer om te openen.
(recentf-mode 1)

;; ----- Bewaar de history van de mini-buffer ----------------------------------
;; We gebruiken de mini-buffer heel veel in Emacs. Handig om de historie te
;; kunnen bewaren. Met M-n en M-p kunnen we door de historie bladeren.
(setq history-length 50)
(savehist-mode 1)

;; ----- Bewaar de laatste plek van bewerking in bestand -----------------------
(save-place-mode 1)


(setq custom-file (locate-user-emacs-file "custom-vars.el"))
(load custom-file 'noerror 'nomessage)

(use-package rainbow-delimiters
  :hook (prog-mode . rainbow-delimiters-mode))


;; Let us setup a font
(set-face-attribute 'default nil :font "FiraCode Nerd Font" :height 120)
(set-face-attribute 'fixed-pitch nil :font "FiraCode Nerd Font" :height 120)
(set-face-attribute 'variable-pitch nil :font "Liberation Serif" :height 130 :weight 'regular)

;; ----- Setup rust mode -------------------------------------------------------
(require 'rust-mode)
(add-hook 'rust-mode-hook
	  (lambda () (setq indent-tabs-mode nil)))
(setq rust-format-on-save t)
(add-hook 'rust-mode-hook
	  (lambda () (prettify-symbols-mode)))
;; ----- Setup Org mode --------------------------------------------------------
;; Set the size of the headings
(with-eval-after-load
    (require 'org-faces))

(defun wa/org-mode-setup ()
  (org-indent-mode)
  (variable-pitch-mode 1)
  (auto-fill-mode 0)
  (visual-line-mode 1))

(defun wa/org-font-setup ()
  ;; Replace list hyphen with dots
  (font-lock-add-keywords 'org-mode
			  '(("^ *\\([-]\\) "
			   (0 (prog1 () (compose-region (match-beginning 1) (match-end 1) "•"))))))


  (dolist (face '((org-level-1 . 1.2)
                  (org-level-2 . 1.15)
                  (org-level-3 . 1.1)
                  (org-level-4 . 1.05)
                  (org-level-5 . 1.0)
                  (org-level-6 . 0.95)
                  (org-level-7 . 0.9)
                  (org-level-8 . 0.8)))
  (set-face-attribute (car face) nil :font "Liberation Serif" :weight 'regular :height (cdr face)))

  ;; Ensure that anything that should be fixed-pitch in Org files appears that way
  (set-face-attribute 'org-block nil :foreground nil :inherit 'fixed-pitch)
  (set-face-attribute 'org-table nil :inherit '(shadow fixed-pitch))
  (set-face-attribute 'org-code nil :inherit '(shadow fixed-pitch))
  (set-face-attribute 'org-verbatim nil :inherit '(shadow fixed-pitch))
  (set-face-attribute 'org-special-keyword nil :inherit '(font-lock-comment-face fixed-pitch))
  (set-face-attribute 'org-meta-line nil :inherit '(font-lock-comment-face fixed-pitch))
  (set-face-attribute 'org-checkbox nil :inherit 'fixed-pitch))

  
(use-package org
  :hook (org-mode . wa/org-mode-setup)
  :config
  (setq org-ellipsis " ▾"
	org-hide-emphasis-markers t)

  (setq org-agenda-start-with-log-mode t)
  (setq org-log-done 'time)
  (setq org-log-into-drawer t)
  
  (setq org-agenda-files
	'("~/Nextcloud/OrgFiles/tasks.org"
	  "~/Nextcloud/OrgFiles/birthdays.org"))

  (setq org-todo-keywords
	'((sequence "TODO(t)" "NEXT(n)" "|" "DONE(d!)")
	  (sequencd "BACKLOG(b)" "PLAN(p)" "READY(r)" "ACTIVE(a)" "REVIEW(v)" "WAIT(w@/!)" "HOLD(h)" "|" "COMPLETED(c)" "CANC(k@)")))

  (setq org-refile-targets
	'(("archive.org" :maxlevel . 1)))

  ;; Save Org buffers after refiling!
  (advice-add 'org-refile :after 'org-save-all-org-buffers)
    
  (setq org-tag-alist
	'((:startgroup)
					; put mutually exclusive tags here
	  (:endgroup)
	  ("@errand" . ?E)
	  ("@home" . ?H)
	  ("@work" . ?W)
	  ("agenda" . ?a)
	  ("planning" . ?p)
	  ("publish" . ?P)
	  ("batch" . ?b)
	  ("note" . ?n)
	  ("idea" . ?i)
	  ("thinking" . ?t)
	  ("recurring" . ?r)))

  ;; Configuration of custom agenda views
  (setq org-agenda-custom-commands
	'(("d" "Dashboard"
	   ((agenda "" ((org-deadline-warning-days 7)))
	    (todo "NEXT"
		  ((org-agenda-overriding-header "Next Tasks")))
	    (tags-todo "agenda/ACTIVE" ((org-agenda-overriding-header "Active Projects")))))

	  ("n" "Next Tasks"
	   ((todo "NEXT"
		  ((org-agenda-overriding-header "Next Tasks")))))

	  ("W" "Work Tasks" tags-todo "+work")

	  ;; Low-effort next actions
	  ("e" tags-todo "+TODO=\"NEXT\"+Effort<15&+Effort>0"
	   ((org-agenda-overriding-header "Low Effort Tasks")
	    (org-agenda-max-todos 20)
	    (org-agenda-files org-agenda-files)))

	  ("w" "Workflow Status"
	   ((todo "WAIT"
		  ((org-agenda-overriding-header "Wait on External")
		   (org-agenda-files org-agenda-files)))
	    (todo "REVIEW"
		  ((org-agenda-overriding-header "In Review")
		   (org-agenda-files org-agenda-files)))
	    (todo "PLAN"
		  ((org-agenda-overriding-header "In PLanning")
		   (org-agenda-todo-list-sublevels nil)
		   (org-agenda-files org-agenda-files)))
	    (todo "BACKLOG"
		  ((org-agenda-overriding-header "Project Backlog")
		   (org-agenda-todo-list-sublevels nil)
		   (org-agenda-files org-agenda-files)))
	    (todo "READY"
		  ((org-agenda-overriding-header "Ready for Work")
		   (org-agenda-files org-agenda-files)))
	    (todo "ACTIVE"
		  ((org-agenda-overriding-header "Active Projects")
		   (org-agenda-files org-agenda-files)))
	    (todo "COMPLETED"
		  ((org-agenda-overriding-header "Completed Projects")
		   (org-agenda-files org-agenda-files)))
	    (todo "CANC"
		  ((org-agenda-overriding-header "Cancelled Projects")
		   (org-agenda-files org-agenda-files)))))))
  
  (wa/org-font-setup))

(use-package org-bullets
  :after org
  :hook (org-mode . org-bullets-mode)
  :custom
  (org-bullets-bullet-list '("◉" "○" "●" "○" "●" "○" "●")))



;; Center the text in the buffer with some room
(defun wa/org-mode-visual-fill ()
  (setq visual-fill-column-width 100
	visual-fill-column-center-text t)
  (visual-fill-column-mode 1))

(use-package visual-fill-column
  :defer t
  :hook (org-mode . wa/org-mode-visual-fill))

;; ----- Setup IRC Chat --------------------------------------------------------
(setq erc-server "irc.libera.chat"
      erc-nick "WimA"
      erc-user-full-name "Wim Alsemgeest"
      erc-track-shorten-start 8
      erc-autojoin-channels-alist '(("irc.libera.chat" "#systemcrafters" "#emacs"))
      erc-kill-buffer-on-part t
      erc-auto-query 'bury)

;; ----- Setup the theme -------------------------------------------------------
(require 'modus-themes)

(setq modus-themes-custom-auto-reload nil
      modus-themes-to-toggle '(modus-operandi modus-vivendi)
      modus-themes-mixed-fonts t
      modus-themes-variable-pitch-ui nil
      modus-themes-italic-constructs t
      modus-themes-bold-constructs nil
      modus-themes-org-blocks nil
      modus-themes-completions '((t . (extrabold)))
      modus-themes-prompts nil
      modus-themes-headings
      '((agenda-structure . (variable-pitch light 1.5))
	(agenda-date . (variable-pitch regular 1.1))
	(t . (regular 1.05))))

(setq modus-themes-common-palette-overrides
      '((cursor magenta-cooler)

	;; Make the fringe invisible
	(fringe unspecified)

	;; Make line numbers less intense and add a shade of cyan
	;; for the current line number
	(fg-line-number-inactive "gray50")
	(fg-line-number-active cyan-cooler)
	(bg-line-number-inactive unspecified)
	(bg-line-number-active unspecified)

	;; Make the current line of 'hl-line-mode' a fine shade of
	;; gray
	(bg-hl-line bg-dim)

	;; Make the region hav a cyan-green background with no
	;; specific foreground (use foreground of underlying text).
	;; "bg-sage" refers to Salvia officinalis, else the common
	;; sage.
	(bg-region bg-sage)
	(fg-region unspecified)

	;; Make matching parentheses a shade of magenta. It
	;; complements the region nicely.
	(bg-paren-match bg-magenta-intense)

	;; Make email citations faint and neutralo, reducing the
	;; default four colors to two; make mail headers cyan-blue
	(mail-cite-0 fg-dim)
	(mail-cite-1 blue-faint)
	(mail-cite-2 fg-dim)
	(mail-cite-3 blue-faint)
	(mail-part cyan-warmer)
	(mail-recipient blue-warmer)
	(mail-subject magenta-cooler)
	(mail-other cyan-warmer)

	;; Change dates to a set of more subtle combinations
	(date-deadline magenta-cooler)
	(date-scheduled magneta)
	(date-weekday fg-main)
	(date-event fg-dim)
	(date-now blue faint)
	
	;; Make tags (Org) less colorful and tables look the same as
	;; the default foreground
	(prose-done cyan-cooler)
	(prose-tag fg-dim)
	(prose-table fg-main)

	;; Make headings less colorful
	(fg-heading-2 blue-faint)
	(fg-heading-3 magenta-faint)
	(fg-heading-4 blue-faint)
	(fg-heading-5 magenta-faint)
	(fg-heading-6 blue-faint)
	(fg-heading-7 magenta-faint)
	(fg-heading-8 blue-faint)

	;; Make the active mode line a fine shade of lavender
	;; (purple) and tone down the gray of the inactive mode lines.
	(bg-mode-line-active bg-lavender)
	(border-mode-line-active bg-lavender)
	(bg-mode-line-inactive bd-dim)
	(border-mode-line-inactive bg-inactive)

	;; Make the prompts a shade of magenta, to fit in nicely with
	;; the overal blue-cyan-purple style of the other overrides.
	;; Add a nuanced background as well.
	(bg-prompt bg-magenta-nuanced)
	(fg-prompt magenta-cooler)

	;; Tweak some settings for constistency.
	(name blue-warmer)
	(identifier magenta-faint)
	(keybind magenta-cooler)
	(accent-0 magenta-cooler)
	(accent-1 cyan-cooler)
	(accent-2 blue-warmer)
	(accent-3 red-cooler)))

(custom-set-faces
 '(mode-line ((t :box (:style released-button)))))

(load-theme 'modus-vivendi t)

(define-key global-map (kbd "<f5>") #'modus-themes-toggle)

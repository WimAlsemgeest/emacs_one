;; Wim's Emacs configuratie
;; 26-05-2023
;; -----------------------------------------------------------------------------

;; ----- Onderdruk startup bericht ---------------------------------------------
(setq inhibit-startup-message t)

;; ----- Maak de bel visueel ---------------------------------------------------
(setq visible-bell t)

;; ----- Verberg wat UI eigenschappen ------------------------------------------
;; (menu-bar-mode -1)
(tool-bar-mode -1)
(scroll-bar-mode -1)
(setq use-dialog-box nil)

;; ----- Automatisch buffers bijwerken als die extern gewijzigd worden ---------
(global-auto-revert-mode 1)

;; ----- Laat regel en kolom nummers zien --------------------------------------
(global-display-line-numbers-mode 1)
(setq column-number-mode t)

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
      '((agenda-structure . (variable-pitch light 2.2))
	(agenda-date . (variable-pitch regular 1.3))
	(t . (regular 1.15))))

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

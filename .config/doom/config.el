(defun mp/tangle-on-save-org-mode-file()
  (when (string= (message "%s" major-mode) "org-mode")
    (org-babel-tangle)))

(add-hook 'after-save-hook 'mp/tangle-on-save-org-mode-file)

(setq modus-themes-headings
      '((1 . (variable-pitch 1.5)) ;; 1 means first heading level (document title)
        (2 . (1.3)) ;;
        (agenda-date . (1.3))
        (agenda-structure . (variable-pitch light 1.8))
        (t . (1.1))))

(load-theme 'modus-vivendi-tinted t)

(map! :leader
      :desc "Light and dark theme"
      "t t" 'modus-themes-toggle)

(column-number-mode)
(global-display-line-numbers-mode 0)
(setq display-line-numbers-type 'relative) ;; This sets relative line numbers.

(setq
    doom-font (font-spec :family "JetBrainsMono Nerd Font Mono" :size 16 :weight 'regular) doom-big-font (font-spec :family "JetBrainsMono Nerd Font Mono" :size 24)
    doom-variable-pitch-font (font-spec :family "SF Pro Text")
     )

(setq doom-modeline-bar-height 25)
(setq doom-modeline-time-icon t)
(setq doom-modeline-project-name t)

(use-package! evil-escape
    :init
    (setq evil-escape-key-sequence "jk"))

(map! :leader
      :desc "Weekly agenda"
      "o w" #'org-agenda-list)

(defun my/search-documents ()
  "Search files in ~/Documents using consult fd/find."
  (interactive)
  (let ((default-directory "~/Documents/"))
    (consult-fd)))

(map! :leader
      :desc "Find file in Documents"
      "d f" #'my/search-documents)

(defun my/search-papers ()
  "Search files in ~/Documents using consult fd/find."
  (interactive)
  (let ((default-directory "~/Documents/Papers"))
    (consult-fd)))

(map! :leader
      :desc "Find paper"
      "d p" #'my/search-papers)

(map! :leader
      :desc "Find citation"
      "d c" #'citar-open-entry)

(setq org-roam-directory "~/Zettelkasten")

(setq org-roam-completion-everywhere nil)

(setq org-journal-enable-agenda-integration t
      org-icalendar-store-UID t
      org-icalendar-include-todo "all"
      org-icalendar-combined-agenda-file "~/Org/emacs.ics")

(use-package org-alert
  :ensure t)
(setq alert-default-style 'libnotify)

;; (setq org-ellipsis "[..]") ;; symbol if header is closed
;; (set-face-attribute 'org-ellipsis nil :inherit 'default :box nil)

;; (use-package olivetti
;;   :ensure t
;;   :hook (org-mode . olivetti-mode)
;;   :config
;;   (setq olivetti-body-width 200))

(require 'org-download)

;; Drag-and-drop to `dired`
(add-hook 'dired-mode-hook 'org-download-enable)

;; (require 'mu4e)
(use-package mu4e
        :ensure nil
        :config
        (setq mu4e-change-filenames-when-moving t)
        (setq mu4e-update-interval (* 10 60))
        (setq mu4e-get-mail-command "mbsync -a")
        (setq mu4e-maildir (expand-file-name "~/Mail"))
        (setq mu4e-headers-show-threads nil)
        (setq mu4e-headers-include-related nil)

        ;; Make sure plain text mails flow correctly for recipients
        (setq
            mail-user-agent 'mu4e-user-agent
            sendmail-program (executable-find "msmtp")
            send-mail-function 'message-send-mail-with-sendmail
            message-send-mail-function 'message-send-mail-with-sendmail

            message-kill-buffer-on-exit t
            message-sendmail-f-is-evil t
            message-sendmail-extra-arguments '("--read-envelope-from")
            message-sendmail-envelope-from 'header)
         )
        ;; (setq mu4e-compose-format-flowed t)
        ;; (setq sendmail-program (executable-find "msmtp"))
        ;; ;; Configure the function to use for sending mail
        ;; ;; (setq message-send-mail-function 'smtpmail-send-it)
        ;; (setq send-mail-function 'sendmail-send-it
        ;;     message-send-mail-function 'sendmail-send-it)
        ;; )
(setq mu4e-contexts
      (list
       ;; Work account
       (make-mu4e-context
        :name "FAU"
        :enter-func (lambda () (mu4e-message "Switched to Work context"))
        :match-func (lambda (msg)
                (when msg
                        (string-prefix-p "/FAU" (mu4e-message-field msg :maildir))))
        :vars '((user-mail-address . "markus.pirke@fau.de")
                (user-full-name    . "Markus Pirke")
                (mu4e-sent-folder  . "/FAU/Sent")
                (mu4e-drafts-folder . "/FAU/Drafts")
                (mu4e-trash-folder  . "/FAU/Trash")
                (mu4e-refile-folder . "/FAU/Archive")))

       (make-mu4e-context
        :name "iCloud"
        :enter-func (lambda () (mu4e-message "Switched to Personal context"))
        :match-func (lambda (msg)
                (when msg
                        (string-prefix-p "/iCloud" (mu4e-message-field msg :maildir))))
        :vars '((user-mail-address . "markus.pirke@icloud.com")
                (user-full-name    . "Markus Pirke")
                (mu4e-sent-folder  . "/iCloud/Sent Messages")
                (mu4e-drafts-folder . "/iCloud/Drafts")
                (mu4e-trash-folder  . "/iCloud/Deleted Messages")
                (mu4e-refile-folder . "/iCloud/Archive")))))

(add-to-list 'mu4e-bookmarks
  ;; bookmark for message that require quick attention
  '( :name "Unread Work"
     :key  ?w
     :query "flag:unread AND NOT flag:trashed AND maildir:/FAU/INBOX"))

(add-to-list 'mu4e-bookmarks
  ;; bookmark for message that require quick attention
  '( :name "Unread Personal"
     :key  ?p
     :query "flag:unread AND NOT flag:trashed AND maildir:/iCloud/INBOX"))

(setq default-input-method "german")
(setq default-transient-input-method "german")

(gptel-make-ollama "Ollama"             ;Any name of your choosing
  :host "localhost:11434"               ;Where it's running
  :stream t                             ;Stream responses
  :models '(ministral-3:8b
            ministral-3:3b
            qwen3:4b
            qwen3-vl:4b
            lfm2.5-thinking:latest))

(use-package citar
  :custom
  (citar-bibliography '("~/Documents/references.bib")))

(defun my/citar-insert-latex-cite ()
  "Insert a \\cite{key} at point using citar."
  (interactive)
  (let ((key (car (citar-select-refs))))
    (insert (format "\\cite{%s}" key))))

(map! :leader
      :desc "Insert citation" "i c" #'my/citar-insert-latex-cite)

(use-package jinx
  :ensure t
  :hook ((LaTeX-mode . jinx-mode)
         (latex-mode . jinx-mode)
         (org-mode . jinx-mode)
         (text-mode . jinx-mode))
  :config (setq jinx-languages "en_US,de")
  )
;; this turns of the flyspell-mode when an org document is opened
;; disable flyspell-mode
(setq-default spell-checking-enable-by-default nil)
(remove-hook 'org-mode-hook #'flyspell-mode)
(remove-hook 'latex-mode-hook #'flyspell-mode)
(remove-hook 'LaTeX-mode-hook #'flyspell-mode)
(remove-hook 'text-mode-hook #'flyspell-mode)
;; Shortcut for correct word
(map! :leader
      (:prefix ("e" . "edit")
      :desc "Correct word"
      "w" #'jinx-correct-word))

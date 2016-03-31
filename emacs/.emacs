;; Local Library Path
(add-to-list 'load-path "~/.emacs.d/site-lisp/")

;; Highlight selected text
(transient-mark-mode t)

;; Highlight the current line
(require 'hl-line)
(hl-line-mode t)

;; Highlight Background color
;;(highlight-current-line-set-bg-color "MediumPurple")


;; Ident set to 4
(setq standard-indent 4)
(setq tab-width 4)

;; Scroll line by line
(setq scroll-step 1)

;; No Tabs
(setq-default indent-tabs-mode nil)

;; Show line-number in the mode line
(line-number-mode 1)

;; Show column-number in the mode line
(column-number-mode 1)

;; Parenthesis mode
(show-paren-mode t)

;; Auto-pairing brackets/quotes by João Távora(v0.3)
;(require 'autopair)
;(autopair-global-mode 1)

;; Color Theme
(require 'color-theme)
(color-theme-initialize)
(color-theme-calm-forest)

;; Remove Splash Emacs
(setq inhibit-splash-screen t)

;; Using Tramp w/ssh
(require 'tramp)
(setq tramp-default-method "ssh")
(setq password-cache-expiry nil)

;; Unique lines in a buffer
;; http://20y.hu/20080603/unique-lines-in-an-emacs-buffer.html
;; By Egy beteg srác naplója.
(defun uniq-lines (beg end)
  "Unique lines in region.
Called from a program, there are two arguments:
BEG and END (region to sort)."
  (interactive "r")
  (save-excursion
    (save-restriction
      (narrow-to-region beg end)
      (goto-char (point-min))
      (while (not (eobp))
        (kill-line 1)
        (yank)
        (let ((next-line (point)))
          (while
              (re-search-forward
               (format "^%s" (regexp-quote (car kill-ring))) nil t)
            (replace-match "" nil nil))
          (goto-char next-line))))))

;; ???
(put 'downcase-region 'disabled nil)

;; Perl mode
(defalias 'perl-mode 'cperl-mode)

;; Puppet mode
(autoload 'puppet-mode "puppet-mode" "Puppet Mode." t)
(add-to-list 'auto-mode-alist '("\\.pp\\'" . puppet-mode))
(add-to-list 'interpreter-mode-alist '("puppet" . puppet-mode))

;; Python mode
(require 'python)
(autoload 'python-mode "python-mode" "Python Mode." t)
(add-to-list 'auto-mode-alist '("\\.py\\'" . python-mode))
(add-to-list 'interpreter-mode-alist '("python" . python-mode))

;; Anti-word
(autoload 'no-word "no-word" "word to txt" t)
(add-to-list 'auto-mode-alist '("\\.doc\\'" . no-word))

;; ODF
(autoload 'odw-mode "odf-mode" "Open Document Format" t)
(add-to-list 'auto-mode-alist '("\\.od.\\'" . odf-mode))

;; ERC
(require 'erc)
(erc-autojoin-mode t)
(setq erc-autojoin-channels-alist
  '((".*\\.freenode.net" "#puppet" "#theforeman")))
(erc-track-mode t)
(setq erc-track-exclude-types '("JOIN" "NICK" "PART" "QUIT" "MODE"
                                 "324" "329" "332" "333" "353" "477"))
;; don't show any of this
(setq erc-hide-list '("JOIN" "PART" "QUIT" "NICK"))
;; Function to start erc
(defun djcb-erc-start-or-switch ()
  "Connect to ERC, or switch to last active buffer"
  (interactive)
  (if (get-buffer "irc.freenode.net:6667") ;; ERC already active?
    (erc-track-switch-buffer 1) ;; yes: switch to last active
    (when (y-or-n-p "Start ERC? ") ;; no: maybe start ERC
      (erc :server "irc.freenode.net" :port 6667 :nick "mynick" :full-name "myname" :password "mypass"))))
;; TODO move passwd information to a separate file.
;; ERC Alias
(global-set-key (kbd "C-c e") 'djcb-erc-start-or-switch)
;; ERC logging
(setq erc-log-channels-directory "~/.emacs.d/erc/logs/")
(setq erc-save-buffer-on-part t)
(setq erc-log-insert-log-on-open nil)
;; ERC Auto-saving log
(add-hook 'erc-insert-post-hook 'erc-save-buffer-in-logs)
;; ERC EA Alias
(global-set-key (kbd "C-c a") 'ea-irc-erc)

;; ELIM - Purple connector
(add-to-list 'load-path "~/.emacs.d/elisp/elim")
(autoload 'garak "garak" nil t)

(custom-set-variables
  ;; custom-set-variables was added by Custom.
  ;; If you edit it by hand, you could mess it up, so be careful.
  ;; Your init file should contain only one such instance.
  ;; If there is more than one, they won't work right.
 '(erc-modules (quote (autoaway autojoin button completion fill irccontrols list log match menu move-to-prompt netsplit networks noncommands notify readonly ring sound stamp track))))

;; Identi.ca mode
;; TODO move passwords to diff file.
;(require 'identica-mode)
;(setq identica-username "myusern")
;(setq identica-password "mypass")

;; Identi.ca keybindings
;(global-set-key "\C-cis" 'identica-mode)
;(global-set-key "\C-cip" 'identica-update-status-interactive)
;(global-set-key "\C-cid" 'identica-direct-message-interactive)

;; TODO Add autocomplete.
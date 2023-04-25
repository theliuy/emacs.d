;;; package --- Summary: init.el --- Load the full configuration -*- lexical-binding: t -*-
;;; Commentary: Ummm

;;; Code:
(when (version< emacs-version "26.1")
  (message "Your Emacs is old, and some functionality in this config will be disabled. Please upgrade if possible."))

(package-initialize)

(setq package-archives '(("gnu" . "https://elpa.gnu.org/packages/")
                         ("org" . "https://orgmode.org/elpa/")
                         ("melpa" . "http://melpa.org/packages/")))

(add-to-list 'load-path (expand-file-name "lisp" user-emacs-directory))

(defconst *spell-check-support-enabled* nil)
(defconst *is-a-mac* (eq system-type 'darwin))

;;----------------------------------------------------------------------------
;; Adjust garbage collection thresholds during startup, and thereafter
;;----------------------------------------------------------------------------
(let ((normal-gc-cons-threshold (* 20 1024 1024))
      (init-gc-cons-threshold (* 128 1024 1024)))
  (setq gc-cons-threshold init-gc-cons-threshold)
  (add-hook 'emacs-startup-hook
            (lambda () (setq gc-cons-threshold normal-gc-cons-threshold))))

(require 'init-utils)
(require 'init-site-lisp) ;; Must come before elpa, as it may provide package.el
;; Calls (package-initialize)
(require 'init-elpa)      ;; Machinery for installing required packages
(require 'init-exec-path) ;; Set up $PATH

;;----------------------------------------------------------------------------
;; Load configs for specific features and modes
;;----------------------------------------------------------------------------

(require-package 'diminish)
(maybe-require-package 'scratch)
(require-package 'command-log-mode)

;; UI
(require 'init-themes)
(require 'init-frame-hooks)
(require 'init-xterm)
(require 'init-osx-keys)
(require 'init-gui-frames)

;; searching
(require 'init-ace-window)
(require 'init-dired)
(require 'init-isearch)
(require 'init-grep)
(require 'init-uniquify)
(require 'init-ibuffer)
(require 'init-flycheck)

(require 'init-benchmarking)
(require 'init-recentf)
(require 'init-smex)
(require 'init-ivy)
(require 'init-hippie-expand)
(require 'init-company)
(require 'init-windows)
(require 'init-sessions)
(require 'init-mmm)

(require 'init-editing-utils)
(require 'init-whitespace)
(require 'init-paredit)

;; svn
(require 'init-vc)
(require 'init-darcs)
(require 'init-git)

;; projects
(require 'init-projectile)

(require 'init-compile)
(require 'init-textile)

;; languages
(require 'init-golang)
(require 'init-markdown)
(require 'init-sql)
(require 'init-lisp)
(require 'init-common-lisp)
(require 'init-thrift)

;; misc
(require 'init-misc)
(require 'init-folding)
(require 'init-dash)

(require 'init-ledger)
;; Extra packages which don't require any configuration

(require-package 'gnuplot)
(require-package 'lua-mode)
(require-package 'htmlize)
(require-package 'dsvn)

(when *is-a-mac*
  (require-package 'osx-location))
(unless (eq system-type 'windows-nt)
  (maybe-require-package 'daemons))
(maybe-require-package 'dotenv-mode)

(when (maybe-require-package 'uptimes)
  (setq-default uptimes-keep-count 200)
  (add-hook 'after-init-hook (lambda () (require 'uptimes))))

(when (fboundp 'global-eldoc-mode)
  (add-hook 'after-init-hook 'global-eldoc-mode))

;;----------------------------------------------------------------------------
;; Allow access from emacsclient
;;----------------------------------------------------------------------------
(add-hook 'after-init-hook
          (lambda ()
            (require 'server)
            (unless (server-running-p)
              (server-start))))

(provide 'init)
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(org-agenda-files
   (quote
    ("~/dev/notes/texas.org" "~/dev/notes/pico.org" "~/dev/notes/work.org")))
 '(package-selected-packages
   (quote
    (org-gtd ob-go ob-http org-bullets org helm-lsp lsp-treemacs yasnippet company-lsp lsp-ui lsp-mode zenburn-theme whole-line-or-region whitespace-cleanup-mode which-key wgrep vlf vc-darcs uptimes unfill textile-mode symbol-overlay switch-window sqlformat smex session scratch regex-tool rainbow-mode rainbow-delimiters paredit page-break-lines osx-location origami ns-auto-titlebar multiple-cursors move-dup mode-line-bell mmm-mode markdown-mode magit-todos macrostep lua-mode list-unicode-display ledger-mode ivy-xref ipretty info-colors immortal-scratch ibuffer-vc ibuffer-projectile htmlize highlight-quoted highlight-escape-sequences goto-line-preview gnuplot gnu-elpa-keyring-update gitignore-mode gitconfig-mode git-timemachine git-blamed fullframe flycheck-package flycheck-ledger flycheck-color-mode-line expand-region exec-path-from-shell elisp-slime-nav dsvn dotenv-mode disable-mouse diredfl dimmer diminish diff-hl default-text-scale dash-at-point darcsum daemons counsel company-quickhelp command-log-mode color-theme-sanityinc-tomorrow color-theme-sanityinc-solarized cmd-to-echo cl-libify cl-lib-highlight cask-mode browse-kill-ring browse-at-remote beacon avy auto-compile anzu alert aggressive-indent)))
 '(session-use-package t nil (session)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

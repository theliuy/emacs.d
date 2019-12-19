;;; init-golang.el --- Configure golang -*- lexical-binding: t -*-
;;; Commentary:
;;; Code:

(require 'package)

(require-package 'go-mode)
(require-package 'go-imports)
(require-package 'lsp-mode)
(require-package 'lsp-ui)
(require-package 'company)
(require-package 'company-lsp)
(require-package 'yasnippet)

(defun lsp-go-install-save-hooks ()
  (setq tab-width 4)
  (setq indent-tabs-mode 1)
  (setq gofmt-command "goimports")
  (add-hook 'before-save-hook 'gofmt-before-save)
  )

(add-hook 'go-mode-hook 'lsp-go-install-save-hooks)
(add-hook 'go-mode-hook #'lsp)
(add-hook 'go-mode-hook #'lsp-deferred)

(lsp-ui-mode t)
(company-lsp t)

(lsp-register-custom-settings
 '(("gopls.completeUnimported" t t)
   ("gopls.staticcheck" t t)))

(provide 'init-golang)
;;; init-golang.el ends here

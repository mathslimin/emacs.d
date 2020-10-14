(put 'erase-buffer 'disabled nil)
;g~/.emacs.d/projs/myelpa/go-mode/go-mode.elo mode
(add-to-list 'load-path "~/.emacs.d/projs/myelpa/go-mode/")
(autoload 'go-mode "go-mode" nil t)
(add-to-list 'auto-mode-alist '("\\.go\\'" . go-mode))
(require 'go-guru)
(add-hook 'before-save-hook 'gofmt-before-save)
(add-hook 'go-mode-hook '(lambda ()
               (local-set-key (kbd "C-c C-r") 'go-remove-unused-imports)))
(add-hook 'go-mode-hook '(lambda ()
               (local-set-key (kbd "C-c C-g") 'go-goto-imports)))
(add-hook 'go-mode-hook '(lambda ()
               (local-set-key (kbd "C-c C-f") 'gofmt)))
(add-hook 'go-mode-hook '(lambda ()
               (local-set-key (kbd "C-c C-k") 'godoc)))
(add-hook 'before-save-hook 'gofmt-before-save)
(add-to-list 'load-path "~/.emacs.d/projs/myelpa/auto-complete-20201011.1341/")
(require 'auto-complete)
(add-to-list 'load-path "~/.emacs.d/projs/myelpa/gocode/")
(require 'go-autocomplete)
(require 'auto-complete-config)
(ac-config-default)
;; Godef jump key binding
;(local-set-key (kbd "M-,") 'godef-jump)
;(local-set-key (kbd "M-.") 'pop-tag-mark)
(global-set-key (kbd "C-c C-b") 'pop-tag-mark)
(go-guru-hl-identifier-mode)
;pkg-info
(add-to-list 'load-path "~/.emacs.d/projs/myelpa/epl-20180205.2049")
(require 'epl)
(add-to-list 'load-path "~/.emacs.d/projs/myelpa/pkg-info-20150517.1143")
(require 'pkg-info)
;flycheck
(add-to-list 'load-path "~/.emacs.d/projs/myelpa/flycheck-20200820.1403")
(require 'flycheck)
(setq-default flycheck-temp-prefix ".")
(setq flycheck-eslintrc "~/.emacs.d/js/eslintrc")
;; Enable eslint checker for web-mode
(flycheck-add-mode 'javascript-eslint 'web-mode)
(flycheck-add-mode 'javascript-eslint 'js-mode)
(flycheck-add-mode 'javascript-eslint 'js2-mode)
(flycheck-add-mode 'javascript-eslint 'web-mode)
(flycheck-add-mode 'javascript-eslint 'rjsx-mode)
(flycheck-add-mode 'javascript-eslint 'typescript-mode)
(add-hook 'after-init-hook #'global-flycheck-mode)

;prettier-js
(add-to-list 'load-path "~/.emacs.d/projs/myelpa/prettier-js-20180109.726")
(require 'prettier-js)
(add-hook 'js2-mode-hook 'prettier-js-mode)
(add-hook 'web-mode-hook 'prettier-js-mode)

;indent setting
(setq-default indent-tabs-mode nil)
(setq-default c-basic-offset 4)
(setq-default cperl-indent-level 4)
(setq-default coffee-tab-width 4)
(setq-default javascript-indent-level 4)
(setq-default typescript-indent-level 4)
(setq-default js-indent-level 4)
(setq-default js2-indent-level 4)
(setq-default web-mode-markup-indent-offset 4)
(setq-default web-mode-css-indent-offset 4)
(setq-default web-mode-code-indent-offset 4)
(setq-default css-indent-offset 4)
(setq-default sgml-basic-offset 4)

;(load-theme 'granger t)
;(load-theme 'molokai t)
;(load-theme 'spacemacs-dark t)
(load-theme 'vscode-dark-plus t)
(add-auto-mode 'rjsx-mode "\\.jsx\\'")
(add-auto-mode 'rjsx-mode "\\.js\\'")
(add-auto-mode 'web-mode "\\.tsx\\'")

;ctags start
(local-require 'counsel-etags)
(defun my-setup-develop-environment ()
  "Set up my develop environment."
  (interactive)
  (unless (is-buffer-file-temp)
	(add-hook 'after-save-hook 'counsel-etags-virtual-update-tags 'append 'local)))
(add-hook 'prog-mode-hook 'my-setup-develop-environment)
(global-set-key (kbd "C-]") 'counsel-etags-find-tag-at-point)

;ctags end

;lsp-mode run `M-x lsp` to start lsp client and server

(with-eval-after-load 'lsp-mode
;; enable log only for debug
(setq lsp-log-io nil)
;; use `evil-matchit' instead
(setq lsp-enable-folding nil)
;; no real time syntax check
(setq lsp-diagnostic-package :none)
;; handle yasnippet by myself
(setq lsp-enable-snippet nil)
;; use `company-ctags' only.
;; Please note `company-lsp' is automatically enabled if it's installed
(setq lsp-enable-completion-at-point nil)
;; turn off for better performance
(setq lsp-enable-symbol-highlighting nil)
;; use find-fine-in-project instead
(setq lsp-enable-links nil)
;; auto restart lsp
(setq lsp-restart 'auto-restart)
;; don't watch 3rd party javascript libraries
(push "[/\\\\][^/\\\\]*\\.\\(json\\|html\\|jade\\)$" lsp-file-watch-ignored)
;; don't ping LSP lanaguage server too frequently
(defvar lsp-on-touch-time 0)
(defun my-lsp-on-change-hack (orig-fun &rest args)
;; do NOT run `lsp-on-change' too frequently
(when (> (- (float-time (current-time))
lsp-on-touch-time) 120) ;; 2 mins
(setq lsp-on-touch-time (float-time (current-time)))
(apply orig-fun args)))
(advice-add 'lsp-on-change :around #'my-lsp-on-change-hack))
;lsp-mode end

;increase the interal of check
(with-eval-after-load 'wucuo
;; 4 second
(setq wucuo-update-interval 400))
(with-eval-after-load 'lazyflymake
;; 2 seconds
(setq lazyflymake-update-interval 300))

;disable warning
;(setq warning-minimum-level :emergency)


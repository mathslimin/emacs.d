(put 'erase-buffer 'disabled nil)
;go mode
(add-to-list 'load-path "~/.emacs.d/projs/myelpa/go-mode/go-mode.el")
(autoload 'go-mode "go-mode" nil t)
(add-to-list 'auto-mode-alist '("\\.go\\'" . go-mode))
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
(setq tab-width 4) ; or any other preferred value
(defvaralias 'c-basic-offset 'tab-width)
(defvaralias 'cperl-indent-level 'tab-width)
(defvaralias 'coffee-tab-width 'tab-width)
(defvaralias 'javascript-indent-level 'tab-width)
(defvaralias 'typescript-indent-level 'tab-width)
(defvaralias 'js-indent-level 'tab-width)
(defvaralias 'js2-indent-level 'tab-width)
(defvaralias 'web-mode-markup-indent-offset 'tab-width)
(defvaralias 'web-mode-css-indent-offset 'tab-width)
(defvaralias 'web-mode-code-indent-offset 'tab-width)
(defvaralias 'css-indent-offset 'tab-width)
(defvaralias 'sgml-basic-offset 'tab-width)

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
(setq warning-minimum-level :emergency)


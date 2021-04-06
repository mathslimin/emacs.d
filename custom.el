(put 'erase-buffer 'disabled nil)
;g~/.emacs.d/projs/myelpa/go-mode/go-mode.elo mode
(add-to-list 'load-path "~/.emacs.d/projs/myelpa/go-mode/")
(autoload 'go-mode "go-mode" nil t)
(add-to-list 'auto-mode-alist '("\\.go\\'" . go-mode))
(require 'go-guru)
(add-hook 'go-mode-hook '(lambda ()
               (local-set-key (kbd "C-c C-r") 'go-remove-unused-imports)))
(add-hook 'go-mode-hook '(lambda ()
               (local-set-key (kbd "C-c C-g") 'go-goto-imports)))
(add-hook 'go-mode-hook '(lambda ()
               (local-set-key (kbd "C-c C-f") 'gofmt)))
(add-hook 'go-mode-hook '(lambda ()
               (local-set-key (kbd "C-c C-k") 'godoc)))
;(add-hook 'go-mode-hook 'lsp-deferred)
;gofmt before save
;(add-hook 'before-save-hook 'gofmt-before-save)
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
;(add-to-list 'load-path "~/.emacs.d/projs/myelpa/prettier-js-20180109.726")
;(require 'prettier-js)
;(add-hook 'js2-mode-hook 'prettier-js-mode)
;(add-hook 'web-mode-hook 'prettier-js-mode)
;(add-hook 'typescript-mode-hook 'prettier-js-mode)

;indent setting
(setq-default tab-width 4)
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
;(load-theme 'vscode-dark-plus t)
(load-theme 'moe-dark t)
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

(add-to-list 'load-path "~/.emacs.d/projs/myelpa/language-id-20200929.1339/")
(require 'language-id)
(add-to-list 'load-path "~/.emacs.d/projs/myelpa/format-all-20201016.1041/")
(require 'format-all)
;(format-all-mode)
(add-hook 'java-mode-hook (lambda ()
  (format-all-mode)
))
(add-hook 'go-mode-hook (lambda ()
  (format-all-mode)
))
(add-hook 'c++-mode-hook (lambda ()
  (format-all-mode)
))
(add-hook 'c-mode-hook (lambda ()
  (format-all-mode)
))


;; 编码设置 begin
(set-language-environment 'Chinese-GB)

;; default-buffer-file-coding-system变量在emacs23.2之后已被废弃，使用buffer-file-coding-system代替
(set-default buffer-file-coding-system 'utf-8-unix)
(set-default-coding-systems 'utf-8-unix)
(setq-default pathname-coding-system 'euc-cn)
(setq file-name-coding-system 'euc-cn)

;; 另外建议按下面的先后顺序来设置中文编码识别方式。
;; 重要提示:写在最后一行的，实际上最优先使用; 最前面一行，反而放到最后才识别。
;; utf-16le-with-signature 相当于 Windows 下的 Unicode 编码，这里也可写成
;; utf-16 (utf-16 实际上还细分为 utf-16le, utf-16be, utf-16le-with-signature等多种)
(prefer-coding-system 'cp950)
(prefer-coding-system 'gb2312)
(prefer-coding-system 'cp936)
(prefer-coding-system 'gb18030)

;(prefer-coding-system 'utf-16le-with-signature)
(prefer-coding-system 'utf-16)

;; 新建文件使用utf-8-unix方式
;; 如果不写下面两句，只写
;; (prefer-coding-system 'utf-8)
;; 这一句的话，新建文件以utf-8编码，行末结束符平台相关
(prefer-coding-system 'utf-8-dos)
(prefer-coding-system 'utf-8-unix)
;; 编码设置 end

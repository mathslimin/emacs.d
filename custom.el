(put 'erase-buffer 'disabled nil)
(add-to-list 'load-path "~/.emacs.d/site-lisp/go-mode.el")
(autoload 'go-mode "go-mode" nil t)
(add-to-list 'auto-mode-alist '("\\.go\\'" . go-mode))
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



;;; Code:
(require-package 'cmake-ide)
(require-package 'function-args)
(require-package 'helm-gtags)
(require-package 'helm-swoop)
(require-package 'helm-projectile)
(require 'helm-gtags)
(require 'setup-helm)

(setq
 helm-gtags-ignore-case t
 helm-gtags-auto-update t
 helm-gtags-use-input-at-cursor t
 helm-gtags-pulse-at-cursor t
 helm-gtags-prefix-key "\C-cg"
 helm-gtags-suggested-key-mapping t
 )

;; Enable helm-gtags-mode
(add-hook 'dired-mode-hook 'helm-gtags-mode)
(add-hook 'eshell-mode-hook 'helm-gtags-mode)
(add-hook 'c-mode-hook 'helm-gtags-mode)
(add-hook 'c++-mode-hook 'helm-gtags-mode)
(add-hook 'asm-mode-hook 'helm-gtags-mode)

(define-key helm-gtags-mode-map (kbd "C-c g a") 'helm-gtags-tags-in-this-function)
(define-key helm-gtags-mode-map (kbd "C-j") 'helm-gtags-select)
(define-key helm-gtags-mode-map (kbd "M-.") 'helm-gtags-dwim)
(define-key helm-gtags-mode-map (kbd "M-,") 'helm-gtags-pop-stack)
(define-key helm-gtags-mode-map (kbd "C-c <") 'helm-gtags-previous-history)
(define-key helm-gtags-mode-map (kbd "C-c >") 'helm-gtags-next-history)

(global-set-key (kbd "<f5>") (lambda ()
                               (interactive)
                               (setq-local compilation-read-command nil)
                               (call-interactively 'compile)))
(setq compile-command "make install")

(setq-default cursor-type 'bar)

(setq indent-tabs-mode 1)
(setq default-tab-width 8)
(setq c-basic-offset 8)

(require 'cc-mode)
(require 'semantic)

(global-semanticdb-minor-mode 1)
(global-semantic-idle-scheduler-mode 1)

(semantic-mode 1)

(require 'function-args)
(fa-config-default)
(define-key c-mode-map  [(control tab)] 'moo-complete)
(define-key c++-mode-map  [(control tab)] 'moo-complete)
(define-key c-mode-map (kbd "M-o")  'fa-show)
(define-key c++-mode-map (kbd "M-o")  'fa-show)

(require 'ede)
(global-ede-mode)

(projectile-global-mode)
(setq projectile-completion-system 'helm)
(helm-projectile-on)

(defun remove-dos-eol ()
  ;; "Do not show ^M in files containing mixed UNIX and DOS line endings."
  ;;(interactive)
  ;;(setq buffer-display-table (make-display-table))
  ;;(aset buffer-display-table ?\^M [])
  "Replace DOS eolns CR LF with Unix eolns CR"
  (interactive)
  (goto-char (point-min))
  (while (search-forward "\r" nil t) (replace-match ""))
  )

(add-hook 'c-mode-hook 'remove-dos-eol)
(add-hook 'c++-mode-hook 'remove-dos-eol)
(add-hook 'c-mode-hook '(lambda () (c-toggle-hungry-state 1)))
(add-hook 'c++-mode-hook '(lambda () (c-toggle-hungry-state 1)))

;;(global-linum-mode)
(setq large-file-warning-threshold 100000000)
(if (eq system-type 'darwin) (set-default-font "Monaco-12" nil t ) (set-default-font "Consolas-12"))

(when (eq system-type 'windows-nt)
  (set-default-font "Consolas-12"))

(cmake-ide-setup)

;;;(add-to-list 'load-path (concat myoptdir "AC"))
;;;(require 'auto-complete-config)
;;;(add-to-list 'ac-dictionary-directories (concat myoptdir "AC/ac-dict"))

;; (require 'auto-complete-clang)

;; (setq ac-auto-start nil)
;; (setq ac-quick-help-delay 0.5)
;; ;; (ac-set-trigger-key "TAB")
;; ;; (define-key ac-mode-map  [(control tab)] 'auto-complete)
;; (define-key ac-mode-map  [(control tab)] 'auto-complete)
;; (defun my-ac-config ()
;;   (setq-default ac-sources '(ac-source-abbrev ac-source-dictionary ac-source-words-in-same-mode-buffers))
;;   (add-hook 'emacs-lisp-mode-hook 'ac-emacs-lisp-mode-setup)
;;   ;; (add-hook 'c-mode-common-hook 'ac-cc-mode-setup)
;;   (add-hook 'ruby-mode-hook 'ac-ruby-mode-setup)
;;   (add-hook 'css-mode-hook 'ac-css-mode-setup)
;;   (add-hook 'auto-complete-mode-hook 'ac-common-setup)
;;   (global-auto-complete-mode t))
;; (defun my-ac-cc-mode-setup ()
;;   (setq ac-sources (append '(ac-source-clang ac-source-yasnippet) ac-sources)))
;; (add-hook 'c-mode-common-hook 'my-ac-cc-mode-setup)
;; ;; ac-source-gtags
;; (my-ac-config)

;;(require 'cedet-projects)
;; (setq tab-width 4)
;; (setq tab-stop-list ())
;; (loop for x downfrom 40 to 1 do
;;       (setq tab-stop-list (cons (* x 4) tab-stop-list)))

;; (defconst my-c-style
;;   '((c-tab-always-indent        . t)
;;     (c-comment-only-line-offset . 4)
;;     (c-hanging-braces-alist     . ((substatement-open after)
;;                                    (brace-list-open)))
;;     (c-hanging-colons-alist     . ((member-init-intro before)
;;                                    (inher-intro)
;;                                    (case-label after)
;;                                    (label after)
;;                                    (access-label after)))
;;     (c-cleanup-list             . (scope-operator
;;                                    empty-defun-braces
;;                                    defun-close-semi))
;;     (c-offsets-alist            . ((arglist-close . c-lineup-arglist)
;;                                    (substatement-open . 0)
;;                                    (case-label        . 4)
;;                                    (block-open        . 0)
;;                                    (knr-argdecl-intro . -)))
;;     (c-echo-syntactic-information-p . t)
;;     )
;;   "My C Programming Style")

;; ;; offset customizations not in my-c-style
;; (setq c-offsets-alist '((member-init-intro . ++)))

;; ;; Customizations for all modes in CC Mode.
;; (defun my-c-mode-common-hook ()
;;   ;; add my personal style and set it for the current buffer
;;   (c-add-style "PERSONAL" my-c-style t)
;;   ;; other customizations
;;   (setq tab-width 4
;;         ;; this will make sure spaces are used instead of tabs
;;         indent-tabs-mode nil)
;;   ;; we like auto-newline and hungry-delete
;;   (c-toggle-auto-hungry-state 1)
;;   ;; key bindings for all supported languages.  We can put these in
;;   ;; c-mode-base-map because c-mode-map, c++-mode-map, objc-mode-map,
;;   ;; java-mode-map, idl-mode-map, and pike-mode-map inherit from it.
;;   (define-key c-mode-base-map "/C-m" 'c-context-line-break)
;;   )

;; (add-hook 'c-mode-common-hook 'my-c-mode-common-hook)

;; (setq default-mode-line-format
;;       (list ""
;;             'mode-line-modified
;;             " "
;;             "%[("
;;             'mode-name
;;             'minor-mode-list
;;             "%n"
;;             'mode-line-process
;;             ")%]--"
;;             "Line %l--"
;;             '(-3 . "%P")
;;             '(:eval (when nyan-mode (list (nyan-create))));;注意添加此句到你的format配置列表中
;;             " "
;;             'default-directory
;;             ))
;; (nyan-mode t);;启动nyan-mode
;; (nyan-start-animation);;开始舞动吧（会耗cpu资源）

(provide 'init-local)
;;; init-local

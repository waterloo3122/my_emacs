(when (>= emacs-major-version 24)
  (require 'package)
  (package-initialize)
	;;;(add-to-list 'package-archives '("melpa" . "http://melpa.org/packages/") t)
  (setq package-archives '(("gnu"   . "http://elpa.zilongshanren.com/gnu/")
                         ("melpa" . "http://elpa.zilongshanren.com/melpa/")))
  )

(require 'cl)
(defvar pp/packages '(
		      company
		      monokai-theme
		      hungry-delete
		      swiper
		      counsel
		      smartparens
		      js2-mode
		      nodejs-repl
		      php-mode
		      flycheck
		      popwin
		      web-mode
		      ac-php
		      js2-refactor
		      expand-region
		      iedit
		      org-pomodoro
		      helm-ag
		      auto-yasnippet
		      evil
		      switch-window
		      window-numbering
		      magit
		      elfeed
		      evil
		      evil-leader
		      which-key
		      evil-nerd-commenter
		      evil-surround
		      ) "Default packages")

(defun pp/packages-installed-p ()
  (loop for pkg in pp/packages
	when (not (package-installed-p pkg)) do (return nil)
	finally (return t)))
(unless (pp/packages-installed-p)
  (message "%s" "Refreshing package database...")
  (package-refresh-contents)
  (dolist (pkg pp/packages)
    (when (not (package-installed-p pkg))
      (package-install pkg))))

(global-hungry-delete-mode)

(ivy-mode 1)
(setq ivy-use-virtual-buffers t)

;;config smart
;;;(require 'smartparens-config)
(smartparens-global-mode t)
(sp-local-pair 'emacs-lisp-mode "'" nil :actions nil)
(sp-local-pair 'lisp-interaction-mode "'" nil :actions nil)

;; config for js files
(setq auto-mode-alist
      (append '(("\\.js\\'" . js2-mode))
              auto-mode-alist))

;;(require 'cl)
;;(require 'php-mode)
;;(add-hook 'php-mode-hook
;;            '(lambda ()
;;               (auto-complete-mode t)
;;               (require 'ac-php)
;;               (setq ac-sources  '(ac-source-php ) )
;;             (yas-global-mode 1)
;;               (define-key php-mode-map  (kbd "C-]") 'ac-php-find-symbol-at-point)   ;goto define
;;               (define-key php-mode-map  (kbd "C-t") 'ac-php-location-stack-back   ) ;go back
;;               ))

(setq auto-mode-alist
      (append '(("\\.php\\'" . php-mode))
	      auto-mode-alist))

(setq auto-mode-alist
      (append '(("\\.html\\'" . web-mode))
	      auto-mode-alist))
    

(global-company-mode t)

(load-theme 'monokai t)

(require 'popwin)
(popwin-mode t)

(require 'nodejs-repl)

(global-flycheck-mode)
;;(add-hook 'js2-mode-hook 'flycheck-mode)

;;;config for web mode
(defun my-web-mode-indent-setup ()
  (setq web-mode-markup-indent-offset 2)
  (setq web-mode-css-indent-offset 2)
  (setq web-mode-code-indent-offset 2)
  )
(add-hook 'web-mode-hook 'my-web-mode-indent-setup)

(defun my-toggle-web-indent ()
  (interactive)
  ;;web develop
  (if (or (eq major-mode 'js-mode) (eq major-mode 'js2-mode))
      (progn
	(setq js-indent-level (if (= js-indent-level 2) 4 2))
	(setq js2-basic-offset (if (= js2-basic-offset 2) 4 2))))
  
  (if (eq major-mode 'web-mode)
      (progn
	(setq web-mode-markup-indent-offset (if (= web-mode-markup-indent-offset 2) 4 2))
	(setq web-mode-css-indent-offset    (if (= web-mode-css-indent-offset    2) 4 2))
	(setq web-mode-code-indent-offset   (if (= web-mode-code-indent-offset   2) 4 2))))
  
  (if (eq major-mode 'css-mode)
      (setq css-indent-offset (if (= css-indent-offset 2) 4 2)))
  
  (setq indent-tabs-mode nil)
  (message "change indent success"))

(global-set-key (kbd "C-c t i") 'my-toggle-web-indent)

;;;config js2-refactor-mode
(add-hook 'js2-mode-hook #'js2-refactor-mode)
(js2r-add-keybindings-with-prefix "C-c C-m")

(defun js2-imenu-make-index ()
      (interactive)
      (save-excursion
        ;; (setq imenu-generic-expression '((nil "describe\\(\"\\(.+\\)\"" 1)))
        (imenu--generic-function '(("describe" "\\s-*describe\\s-*(\\s-*[\"']\\(.+\\)[\"']\\s-*,.*" 1)
                                   ("it" "\\s-*it\\s-*(\\s-*[\"']\\(.+\\)[\"']\\s-*,.*" 1)
                                   ("test" "\\s-*test\\s-*(\\s-*[\"']\\(.+\\)[\"']\\s-*,.*" 1)
                                   ("before" "\\s-*before\\s-*(\\s-*[\"']\\(.+\\)[\"']\\s-*,.*" 1)
                                   ("after" "\\s-*after\\s-*(\\s-*[\"']\\(.+\\)[\"']\\s-*,.*" 1)
                                   ("Function" "function[ \t]+\\([a-zA-Z0-9_$.]+\\)[ \t]*(" 1)
                                   ("Function" "^[ \t]*\\([a-zA-Z0-9_$.]+\\)[ \t]*=[ \t]*function[ \t]*(" 1)
                                   ("Function" "^var[ \t]*\\([a-zA-Z0-9_$.]+\\)[ \t]*=[ \t]*function[ \t]*(" 1)
                                   ("Function" "^[ \t]*\\([a-zA-Z0-9_$.]+\\)[ \t]*()[ \t]*{" 1)
                                   ("Function" "^[ \t]*\\([a-zA-Z0-9_$.]+\\)[ \t]*:[ \t]*function[ \t]*(" 1)
                                   ("Task" "[. \t]task([ \t]*['\"]\\([^'\"]+\\)" 1)))))
(add-hook 'js2-mode-hook
              (lambda ()
                (setq imenu-create-index-function 'js2-imenu-make-index)))


(global-set-key (kbd "M-s i") 'counsel-imenu)

;;;config expand region
(global-set-key (kbd "C-=") 'er/expand-region)

(global-set-key (kbd "M-s e") 'iedit-mode)

(require 'yasnippet)
(yas-reload-all)
(add-hook 'prog-mode-hook #'yas-minor-mode)

;;;config switch-window
;;;(require 'switch-window)
;;;(global-set-key (kbd "C-x o") 'switch-window)

;;;set window-numbering
(window-numbering-mode)
(setq window-numbering-assign-func
      (lambda () (when (equal (buffer-name) "*Calculator*") 9)))


;;;config magit
(global-set-key (kbd "C-x g") 'magit-status)

;;;config elfeed
(global-set-key (kbd "C-x w") 'elfeed)
(setq elfeed-feeds
      '(("http://oremacs.com/atom" blog emacs)
	("http://pragmaticemacs.com/feed/atom/" blog emacs)
	("http://planet.emacsen.org/atom" blog emacs)))


;;; config evil
(evil-mode t)
(setcdr evil-insert-state-map nil)
(define-key evil-insert-state-map [escape] 'evil-normal-state)
;;;(setq evil-want-C-u-scroll t)

;;;config evil-leader
(global-evil-leader-mode)
 

(evil-leader/set-key
 "ff" 'find-file
 "fr" 'recentf-open-files
 "bb" 'switch-to-buffer
 "bk" 'kill-buffer
 "pf" 'counsel-git
 "ps" 'helm-do-ag-project-root
 "1" 'select-window-1
 "2" 'select-window-2
 "3" 'select-window-3
 "4" 'select-window-4
 "0" 'select-window-0
 "w/" 'split-window-right
 "w-" 'split-window-below
 ";" 'counsel-M-x
 "wm" 'delete-other-windows
 "qq" 'save-buffers-kill-terminal
  )
 
;;; config evil-surround
(require 'evil-surround)
(global-evil-surround-mode t)

;;; config evil-nerd-commenter
(define-key evil-normal-state-map (kbd ",/") 'evilnc-comment-or-uncomment-lines)
(define-key evil-visual-state-map (kbd ",/") 'evilnc-comment-or-uncomment-lines)
(evilnc-default-hotkeys)

(dolist (mode '(ag-mode
               flycheck-error-list-mode
               git-rebase-mode
               occur-mode))
  (add-to-list 'evil-emacs-state-modes mode))

(add-hook 'occur-mode-hook
         (lambda ()
           (evil-add-hjkl-bindings occur-mode-map 'emacs
             (kbd "/") 'evil-search-forward
             (kbd "n") 'evil-search-next
             (kbd "N") 'evil-search-previous
             (kbd "C-d") 'evil-scroll-down
             (kbd "C-u") 'evil-scroll-up
             )))

;;; config which-key
(which-key-mode)
(setq which-key-side-window-location 'right)

(provide 'init-packages)

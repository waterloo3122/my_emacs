(when (>= emacs-major-version 24)
  (require 'package)
  (package-initialize)
  (add-to-list 'package-archives '("melpa" . "http://melpa.org/packages/") t)
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

(provide 'init-packages)

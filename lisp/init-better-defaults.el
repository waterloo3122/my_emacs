(setq ring-bell-function 'ignore)

(global-linum-mode t)

(abbrev-mode t)
(define-abbrev-table 'global-abbrev-table '(
					    ("pp" "waterloopan")
					    ("ppm" "waterloopan@qq.com")
					    ))

(setq auto-save-default nil)

;;;(setq backup-directory-alist `(("." . "~/.saves")))
(setq make-backup-files nil)



(require 'recentf)
(recentf-mode 1)
(setq recentf-max-saved-items 25)

(add-hook 'emacs-lisp-mode-hook 'show-paren-mode)

(add-hook 'emacs-lisp-mode-hook 'smartparens-mode)

(delete-selection-mode 1)

(defun indent-buffer ()
     "Indent the currently vistited buffer."
  (interactive)
  (indent-region (point-min) (point-max)))

(defun indent-region-or-buffer ()
  "Indent a region if selected, otherwise the whole buffer"
  (interactive)
  (save-excursion 
    (if (region-active-p)
	(progn
	  (indent-region (region-beginning) (region-end))
	  (message "Indented selected region."))
      (progn
	(indent-buffer)
	(message "Indented buffer.")))))

(setq hippie-expand-try-functions-list '(try-expand-dabbrev
					 try-expand-dabbrev-all-buffers
					 try-expand-dabbrev-from-kill
					 try-complete-file-name-partially
					 try-complete-file-name
					 try-expand-all-abbrevs
					 try-expand-list
					 try-expand-line
					 try-complete-lisp-symbol-partially
					 try-complete-lisp-symbol					 
					 ))


(fset 'yes-or-no-p 'y-or-n-p)

(setq dired-recursive-copies 'always)
(setq dired-recursive-deletes 'always)
(put 'dired-find-alternate-file 'disabled nil)
(require 'dired)
(define-key dired-mode-map (kbd "RET") 'dired-find-alternate-file)
(require 'dired-x)
(setq dired-dwim-target t)

(defun hidden-dos-eol ()
  "Do not show ^M in files containing mixed UNIX and DOS line endings"
  (interactive)
  (setq buffer-display-table (make-display-table))
  (aset buffer-display-table ?\^M []))

(defun remove-dos-eol ()
  "Replace Dos eolns CR LF with Unix eolns CR"
  (interactive)
  (goto-char (point-min))
  (while (search-forward "\r" nil t) (replace-match "")))

;;(define-advice show-paren-function (:around (fn) fix-show-paren-function)
;;  "Highlight enclosing parens."
;;  (cond ((looking-at-p "\\s(") (funcall fn))
;;	(t (save-excursion
;;	     (ignore-errors (backward-up-list))
;;	     (funcall fn)))))
(defadvice show-paren-function (around fix-show-paren-function activate)
  (cond ((looking-at-p "\\s(") ad-do-it)
	(t (save-excursion
	     (ignore-errors (backward-up-list))
	     ad-do-it))))
;; dwin = do what i mean
(defun occur-dwin ()
  "Call occur with a sane default"
  (interactive)
  (push (if (region-active-p)
	    (buffer-substring-no-properties (region-beginning) (region-end))
	  (let ((sym (thing-at-point 'symbol)))
	    (when (stringp sym) 
	      (regexp-quote sym))))
	regexp-history)
  (call-interactively 'occur))
  
(global-set-key (kbd "M-s o") 'occur-dwin)

(global-set-key (kbd "C-w") 'backward-kill-word)

(set-language-environment "UTF-8")
(provide 'init-better-defaults)

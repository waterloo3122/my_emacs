;;; init --- Summary

;;; code:
(package-initialize) ;;; this is a comment

(add-to-list 'load-path "~/.emacs.d/lisp")

;;; Open my init file
(defun open-my-init-file()
  (interactive)
  (find-file "~/.emacs.d/init.el"))

(require 'init-packages)
(require 'init-ui)
(require 'init-better-defaults)
(require 'init-org)
(require 'init-keybindings)

(setq custom-file (expand-file-name "lisp/custom.el" user-emacs-directory))
(load-file custom-file)

;;(setq php-manual-path "~/doc/php-chunked-xhtml")

(my-maximized)
;;; init.el ends here

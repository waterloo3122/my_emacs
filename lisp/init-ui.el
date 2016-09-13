(display-time)  
(tool-bar-mode -1)
(scroll-bar-mode -1)

(setq inhibit-splash-screen t)
(setq-default cursor-type 'bar) 
;;;(global-hl-line-mode t)
;;;(set-default-font "Monospace Regular 14")
;;(set-frame-font "Monospace Regular-14:antialias=1")
(set-default-font "-apple-Monaco-normal-normal-normal-*-18-*-*-*-*-0-iso10646-1")


(global-set-key [f11] 'my-fullscreen)

;全屏
(defun my-fullscreen ()
  (interactive)
  (x-send-client-message
   nil 0 nil "_NET_WM_STATE" 32
   '(2 "_NET_WM_STATE_FULLSCREEN" 0))
)

;该函数用于最大化,状态值为1说明最大化后不会被还原
;因为这里有两次最大化 (分别是水平和垂直)
(defun my-maximized ()
  (interactive)
  (x-send-client-message
   nil 0 nil "_NET_WM_STATE" 32
   '(1 "_NET_WM_STATE_MAXIMIZED_HORZ" 0))
  (interactive)
  (x-send-client-message
   nil 0 nil "_NET_WM_STATE" 32
   '(1 "_NET_WM_STATE_MAXIMIZED_VERT" 0)))



(provide 'init-ui)

(defun widen-neo-window ()
  (interactive)
  (message "width %d" neo-window-width)
  (if (> neo-window-width 65)
      (progn
	(message "max width %d" neo-window-width)
	(setq neo-window-width 25)
    	(message "new width %d" neo-window-width))
    (setq neo-window-width (+ neo-window-width 10)))
  (neotree-hide)
  (neotree))

(defun shrink-neo-window ()
  (interactive)
  (if (<= neo-window-width 25)
      (setq new-window-width 25)
    (setq neo-window-width (- neo-window-width 10)))
  (neotree-hide)
  (neotree))

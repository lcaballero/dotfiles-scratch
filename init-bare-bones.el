;; The default is 800 kilobytes.  Measured in bytes.
(setq gc-cons-threshold (* 50 1000 1000))

;; Profile emacs startup
(add-hook 'emacs-startup-hook
          (lambda ()
            (message "Emacs loaded in %s with %d garbage collections."
                     (emacs-init-time)
                     gcs-done)))

(setq package-enable-at-startup nil)
(setq inhibit-splash-screen t)
(setq inhibit-startup-message t)
(setq visible-bell t)
(setq vc-follow-symlinks t)
(setq make-backup-files nil)

(display-time-mode t)
(fset 'yes-or-no-p 'y-or-n-p)

;; taking care of where the system writes house-keeping files
(setq backup-directory-alist '((".*" . "~/tmp/emacs/backups")))
(setq auto-save-file-name-transforms '((".*" "~/tmp/emacs/backups" t)))
(setq save-place-file "~/tmp/emacs/saveplace")
(setq custom-file (concat user-emacs-directory "custom.el"))


;; when not in a windowing system turn off some of the UI
(if (not window-system)
    (progn
      (menu-bar-mode -1)))

;; in a windowing system turn off the point-and-click UI
(if window-system
    (progn
      (scroll-bar-mode -1)
      (tool-bar-mode -1)
      (tool-tip-mode -1)
      (set-fringe-mode 10)))

(load-theme 'tango-dark)


(defvar bootstrap-version)
(let ((bootstrap-file
       (expand-file-name "straight/repos/straight.el/bootstrap.el"
			 user-emacs-directory))
      (bootstrap-version 5))
  (unless (file-exists-p bootstrap-file)
    (with-current-buffer
        (url-retrieve-synchronously
         "https://raw.githubusercontent.com/raxod502/straight.el/develop/install.el"
         'silent 'inhibit-cookies)
      (goto-char (point-max))
      (eval-print-last-sexp)))
  (load bootstrap-file nil 'nomessage))


(global-set-key (kbd "C-_") 'undo)
(global-set-key (kbd "M-o") '(lambda () (interactive) (other-window -1)))
(global-set-key (kbd "C-o") 'other-window)
(global-set-key (kbd "C-c |") 'split-window-horizontally)
(global-set-key (kbd "C-c -") 'split-window-vertically)

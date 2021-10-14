;; The default is 800 kilobytes.  Measured in bytes.
(setq gc-cons-threshold (* 50 1000 1000))

;; using emacs version >= 27 all the time, so turning this off
(setq package-enable-at-startup nil)

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
(setq-default truncate-lines 1)

(display-time-mode t)
(fset 'yes-or-no-p 'y-or-n-p)

;; taking care of where the system writes house-keeping files
(setq backup-directory-alist '((".*" . "~/tmp/emacs/backups")))
(setq auto-save-list-file-name "~/tmp/emacs/auto-save-list")
(setq auto-save-file-name-transforms '((".*" "~/tmp/emacs/autosaves" t)))
(setq save-place-file "~/tmp/emacs/saveplace")

;; this file needs to exist, even if empty
(setq custom-file (concat user-emacs-directory "custom.el"))
(load custom-file)

(global-unset-key (kbd "M-i"))
(global-unset-key (kbd "M-l"))
(global-unset-key (kbd "M-u"))

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

(setq straight-recipe-overrides nil)
(setq straight-use-package-by-default t)
(setq straight-host-username '((github . "lcaballero")))

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


(straight-use-package 'use-package)

(straight-override-recipe
 `(paredit :url "https://github.com/lcaballero/my-el-mirror"
	   :fetcher git
	   :repo "https://github.com/lcaballero/my-el-mirror"
	   :files ("paredit/paredit.el")))

(use-package expand-region
  :straight t
  :bind ("M-." . er/expand-region))

(use-package ht)
(use-package f)
(use-package dash)
(use-package swiper)
(use-package diminish)
(use-package rainbow-mode)
(use-package editorconfig)
(use-package counsel)
(use-package ivy)
(use-package dockerfile-mode)
(use-package ace-jump-mode)

;(use-package sh-mode)
(use-package json-mode)
(use-package markdown-mode)
(use-package git-link)
(use-package bm
  :config
  (setq bm-cycle-all-buffers t)
  (setq bm-repository-file "~/.emacs.d/bm-repository")
  :hook
  (add-hook 'after-init-hook 'bm-repository-load)
  :bind
  (("C-c b m" . bm-toggle)
   ("C-c b n" . bm-next)
   ("C-c b p" . bm-previous)
   ("M-m" . bm-toggle)
   ("M-l" . bm-next)
   ("M-h" . bm-previous)
   ("<f10>" . bm-toggle)
   ("<f12>" . bm-next)
   ("<f11>" . bm.previous)))

(use-package ws-butler
  :hook ((text-mode . ws-butler-mode)
         (prog-mode . ws-butler-mode)))

(use-package rainbow-delimiters
  :hook (prog-mode . rainbow-delimiters-mode))
(use-package paredit
  :diminish
  :hook ((lisp-mode emacs-lisp-mode) . paredit-mode))

(use-package neotree
  :init
  (load "~/.emacs.d/my-neotree.el")
  :bind
  ("M-1" . neotree)
  (:map neotree-mode-map
	("M-1" . neotree-hide)
	("l" . widen-neo-window)
	("h" . shrink-neo-window)
	("j" . neotree-next-line)
	("k" . neotree-previous-line)
	("m" . neotree-quick-look)
	("u" . neotree-select-up-node)
	("d" . neotree-select-down-node)
	("o" . other-window)))



(defun sh-key ()
  (interactive)
  (message "From sh-key"))

(defun sh/loading ()
  (message "From a hook via: sh/loading")
  (message "Mode: %s" major-mode)
  (keymapp sh-mode-map)
  (define-key sh-mode-map (kbd "C-c k") 'sh-key))

(add-to-list 'auto-mode-alist '("\\.sh\\'" . sh-mode))
(add-hook 'sh-mode-hook 'sh/loading)

(global-set-key (kbd "C-_") 'undo)
(global-set-key (kbd "M-o") '(lambda () (interactive) (other-window -1)))
(global-set-key (kbd "C-o") 'other-window)
(global-set-key (kbd "C-c |") 'split-window-horizontally)
(global-set-key (kbd "C-c -") 'split-window-vertically)
(global-set-key (kbd "M-k") 'kill-this-buffer)
(global-set-key (kbd "M-p") 'previous-buffer)
(global-set-key (kbd "M-n") 'next-buffer)

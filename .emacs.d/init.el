;;; init.el --- init config
;;; Commentary:
;;; this is demo config is still actively develop
;;; so visit my GitHub for current version of it <3

;; disable backup files
;;; Code:
(setq make-backup-files nil)

;; Set font and its size
;;(set-frame-font "Hack Nerd Font 13" nil t) ;; emacsclient zoomed out
(add-to-list 'default-frame-alist '(font . "Hack Nerd Font 13"))

;; display line numbers
(global-display-line-numbers-mode 1)
(setq display-line-numbers-type 'relative)

;; disable lines for some modes
(dolist (mode '(org-mode-hook
		vterm-mode-hook
		term-mode-hook
		eshell-mode-hook))
  (add-hook mode (lambda () (display-line-numbers-mode 0))))

;; Just cleaning up an interface
(menu-bar-mode -1)
(scroll-bar-mode -1)
(tool-bar-mode -1)

;; opacity
;; (set-frame-parameter (selected-frame) 'alpha '(95 . 50))
;; (add-to-list 'default-frame-alist '(alpha . (95 . 50)))

;; smooth scrolling
(setq redisplay-dont-pause t
  scroll-margin 1
  scroll-step 1
  scroll-conservatively 10000
  scroll-preserve-screen-position 1)

;; straight.el initialization
(defvar bootstrap-version)
(let ((bootstrap-file
       (expand-file-name "straight/repos/straight.el/bootstrap.el" user-emacs-directory))
      (bootstrap-version 6))
  (unless (file-exists-p bootstrap-file)
    (with-current-buffer
        (url-retrieve-synchronously
         "https://raw.githubusercontent.com/radian-software/straight.el/develop/install.el"
         'silent 'inhibit-cookies)
      (goto-char (point-max))
      (eval-print-last-sexp)))
  (load bootstrap-file nil 'nomessage))

;; said to set before loading doom-modeline
(setq doom-modeline-support-imenu t)

;; staright.el packages
(straight-use-package 'evil)
(straight-use-package 'projectile)
(straight-use-package 'treemacs)
(straight-use-package 'pdf-tools)
(straight-use-package 'lsp-mode)
(straight-use-package 'magit)
(straight-use-package 'rainbow-delimiters)
(straight-use-package 'minimap)
(straight-use-package 'flycheck)
(straight-use-package 'vim-empty-lines-mode)
(straight-use-package 'smartparens)
(straight-use-package 'ivy)
(straight-use-package 'counsel)
(straight-use-package 'swiper)
(straight-use-package 'doom-modeline)
(straight-use-package 'doom-themes)
(straight-use-package 'vterm)
(straight-use-package 'which-key)
(straight-use-package 'ivy-rich)
(straight-use-package 'helpful)
;; for the first-time usage run
;; M-x all-the-icons-install-fonts
(straight-use-package 'all-the-icons)
(straight-use-package 'company-box)
(straight-use-package 'lsp-ivy)
(straight-use-package 'clang-format)
(straight-use-package 'beacon)
(straight-use-package 'general)
(straight-use-package 'cmake-ide)
(straight-use-package 'rtags)
(straight-use-package 'irony)
(straight-use-package 'auto-complete-clang)
(straight-use-package 'vterm-toggle)


;; rtags
(load-file "/home/floatfoo/rtags/src/rtags.el")

;; irony
(add-hook 'c++-mode-hook 'irony-mode)
(add-hook 'c-mode-hook 'irony-mode)
(add-hook 'objc-mode-hook 'irony-mode)

(add-hook 'irony-mode-hook 'irony-cdb-autosetup-compile-options)

;; cmake ide setup
(cmake-ide-setup)

;; beacon
(beacon-mode t)

;; autocompletion
(company-box-mode t)
(global-company-mode t)

;; flycheck
(global-flycheck-mode 1)

;; ivy-rich mode
(ivy-rich-mode t)

;; which-key config
(which-key-mode 1)

;; enable vim tildas
(global-vim-empty-lines-mode)

;; smartparens global-mode
(smartparens-global-mode t)

;; doom-modeline init
(doom-modeline-mode 1)

;; theme
(load-theme 'doom-dracula t)

;; projectile
(projectile-mode t)

;; ENTER key parents autoinden
(defun indent-between-pair (&rest _ignored)
  (newline)
  (indent-according-to-mode)
  (forward-line -1)
  (indent-according-to-mode))

(sp-local-pair 'prog-mode "{" nil :post-handlers '((indent-between-pair "RET")))
(sp-local-pair 'prog-mode "[" nil :post-handlers '((indent-between-pair "RET")))
(sp-local-pair 'prog-mode "(" nil :post-handlers '((indent-between-pair "RET")))

;; doom-modeline setup
(setq doom-modeline-height 25)
(setq doom-modeline-bar-width 4)
(setq doom-modeline-project-detection 'auto)
(setq doom-modeline-icon t)
(setq doom-modeline-major-mode-icon t)
(setq doom-modeline-major-mode-color-icon t)

(require 'evil)
(evil-mode 1)
(ivy-mode 1)
(counsel-mode 1)
(projectile-mode +1)

;; key settings
(global-set-key
 (kbd "C-x w d")
 'delete-window
 )

(global-set-key
 (kbd "C-s")
 'swiper
 )

(global-set-key
 (kbd "<escape>")
 'keyboard-escape-quit
 )

;; windows
(general-define-key
 :prefix "SPC w"
 :keymaps 'normal

 ;; windows switching
 "h" 'windmove-left
 "j" 'windmove-down
 "k" 'windmove-up
 "l" 'windmove-right

 ;; spawn/delete window
 "V" 'split-window-vertically
 ">" 'split-window-horizontally
 "d" 'delete-window
 )


;; projectile
(general-define-key
 :prefix "SPC"
 :keymaps 'normal
 "p p" 'projectile-switch-project)

;; vterm
(general-define-key
 :prefix "SPC"
 :keymaps 'normal
 "o t" 'vterm-toggle-cd)
(setq vterm-toggle-fullscreen-p nil)

;; vterm bottom side
(add-to-list 'display-buffer-alist
             '((lambda (buffer-or-name _)
                   (let ((buffer (get-buffer buffer-or-name)))
                     (with-current-buffer buffer
                       (or (equal major-mode 'vterm-mode)
                           (string-prefix-p vterm-buffer-name (buffer-name buffer))))))
                (display-buffer-reuse-window display-buffer-at-bottom)
                ;;(display-buffer-reuse-window display-buffer-in-direction)
                ;;display-buffer-in-direction/direction/dedicated is added in emacs27
                ;;(direction . bottom)
                ;;(dedicated . t) ;dedicated is supported in emacs27
                (reusable-frames . visible)
                (window-height . 0.3)))

;; treemacs
(general-define-key
 :prefix "SPC"
 :keymaps 'normal
 "o p" 'treemacs)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes
   '("631c52620e2953e744f2b56d102eae503017047fb43d65ce028e88ef5846ea3b" "944d52450c57b7cbba08f9b3d08095eb7a5541b0ecfb3a0a9ecd4a18f3c28948" "2f8eadc12bf60b581674a41ddc319a40ed373dd4a7c577933acaff15d2bf7cc6" "7a424478cb77a96af2c0f50cfb4e2a88647b3ccca225f8c650ed45b7f50d9525" "aec7b55f2a13307a55517fdf08438863d694550565dee23181d2ebd973ebd6b8" "2dd4951e967990396142ec54d376cced3f135810b2b69920e77103e0bcedfba9" "49acd691c89118c0768c4fb9a333af33e3d2dca48e6f79787478757071d64e68" "2e05569868dc11a52b08926b4c1a27da77580daa9321773d92822f7a639956ce" "bf948e3f55a8cd1f420373410911d0a50be5a04a8886cabe8d8e471ad8fdba8e" default)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )''

;; Tab 4 spaces
(setq c-default-style "google"
      c-basic-offset 4)

;; LSP config
;; Python
(setq lsp-pylsp-server-command "/home/floatfoo/.local/bin/pylsp")


;;; ORG section

;; set file for org-agenda
(setq org-agenda-files '("~/org/agenda/"))

;; set org-agenda binding
(general-define-key
 :prefix "SPC o"
 :keymaps 'normal
 "a" 'org-agenda)

;; insert date from org calendar
(general-define-key
 :prefix "SPC"
 :keymaps 'normal
 "m d t" 'org-time-stamp)


;;; init.el ends here

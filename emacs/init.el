;; Set default zoom level
(set-face-attribute 'default nil :height 150)

;; Set minibuffer save-history mode
(savehist-mode +1)
(setq savehist-additional-variables
      '(kill-ring
	search-ring
	regexp-search-ring))

;; Disable startup screen
(setq inhibit-startup-message t)

;; Initial Scratch message
(setq initial-scratch-message
      ";; ### Scratch file ###\n")

;; Relative line numbers
(setq display-line-numbers 'relative)

;; Disable popups
(setq use-dialog-box nil)

;; Disable the menu bar
(menu-bar-mode -1)

;; Disable the tool bar
(tool-bar-mode -1)

;; Disable scroll bars
(scroll-bar-mode -1)

;; Display line numbers everywhere
(global-display-line-numbers-mode 1)

;; Set font family
(set-frame-font "Iosevka")

;; Set color theme
(load-theme 'gruber-darker t)

;; Show column number
(column-number-mode +1)

;; Enable link access
(global-goto-address-mode +1)

;; Default line wrapping
(global-visual-line-mode +1)

;; Replace selected text by typing
(delete-selection-mode +1)

;; Recent files
(recentf-mode 1)

;; Initial window size
(setq initial-frame-alist'((top . 10)
			   (left . 10)
			   (width . 160)
			   (height . 50)))

;; Save cursor location in every file
(save-place-mode +1)
(global-set-key "\C-x\ \C-r" 'recentf-open-files)

;; use-package
(eval-when-compile
  (add-to-list 'load-path "/home/anshai/Self/dotfiles/emacs/.emcs.d/use-package")
  (require 'use-package))

;; packages directory
(add-to-list 'load-path "/home/anshai/.emcs.d/Packages")

;; set default directory
(setq default-directory "/home/anshai/")

;; Melpa
(require 'package)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)
(package-initialize)
(setq package-check-signature nil)

;; Backups
;; URL: https://sachachua.com/dotemacs/index.html
(setq backup-directory-alist '(("." . "~/.emacs.d/backups")))
(setq delete-old-versions -1)
(setq version-control t)
(setq vc-make-backup-file t)
(setq auto-save-file-name-transforms '((".*" "~/.emacs.d/auto-save-list/" t)))

;; Global paths for files
(global-set-key (kbd "C-c d")
		(lambda()
		  (interactive)
		  (find-file "~/.emacs")))

;; Global keys
(global-set-key (kbd "C-1") 'kill-this-buffer)
(global-set-key (kbd "C-<down>") (kbd "C-u 1 C-v"))
(global-set-key (kbd "C-<up>") (kbd "C-u 1 M-v"))
(global-set-key [C-tab] 'other-window)
(global-set-key (kbd "C-c c") 'calendar)
(global-set-key (kbd "C-x C-b") 'ibuffer)
(global-set-key (kbd "M-/") #'hippie-expand)
(global-set-key (kbd "C-x C-j") 'dired-jump)

;; Gruber color theme
(use-package gruber-darker-theme
  :ensure t)

;; Magit
(use-package magit
  :ensure t)

;; flycheck for syntax checking
(use-package flycheck
  :ensure t
  :hook ((after-init . global-flycheck-mode)))

;; typescript-mode for typescript
(use-package typescript-mode
  :ensure t
  :after (flycheck)
  :config
  (add-to-list 'auto-mode-alist '("\\.tsx\\'" . typescript-mode)))

;; Add node_modules to PATH
(use-package add-node-modules-path
  :ensure t
  :hook ((typescript-mode . add-node-modules-path)))

(use-package undo-tree
  :ensure t
  :init
  (global-undo-tree-mode))

;; Show keybindings
(use-package which-key
  :ensure t
  :config (which-key-mode))

;; More visible highlight for the cursor line while scrolling
(use-package beacon
  :ensure t
  :config
  (beacon-mode 1))

;; Delete all whitespace once
(use-package hungry-delete
  :ensure t
  :config
  (global-hungry-delete-mode))

;; Aggresive indent
(use-package aggressive-indent
  :ensure t
  :config
  (global-aggressive-indent-mode 1))

;; Expand selection
(use-package expand-region
  :ensure t
  :config
  (global-set-key (kbd "C-=") 'er/expand-region))

;; IEdit
(use-package iedit
  :ensure t)

;; Delay for showing the keybindings
(setq which-key-idle-delay 0)

(defun setup-tide-mode ()
  (interactive)
  (tide-setup)
  (flycheck-mode +1)
  (setq flycheck-check-syntax-automatically '(save mode-enabled))
  (eldoc-mode +1)
  (tide-hl-identifier-mode +1)
  ;; company is an optional dependency. You have to
  ;; install it separately via package-install
  ;; `M-x package-install [ret] company`
  (company-mode +1))

;; aligns annotation to the right hand side
(setq company-tooltip-align-annotations t)

;; formats the buffer before saving
(add-hook 'before-save-hook 'tide-format-before-save)

;; if you use typescript-mode
(add-hook 'typescript-mode-hook #'setup-tide-mode)
;; if you use treesitter based typescript-ts-mode (emacs 29+)
(add-hook 'typescript-ts-mode-hook #'setup-tide-mode)
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   '(iedit expand-region aggressive-indent aggresive-indent hungry-delete beacon undo-tree ng2-mode which-key try magit tide gruber-darker-theme add-node-modules-path)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
(put 'narrow-to-region 'disabled nil)

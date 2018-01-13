;; lista de packetes que instalaremos
(setq package-list '(dracula-theme auto-complete emmet-mode web-mode ac-html multiple-cursors smartparens flx-ido git-gutter yasnippet ag helm-ag helm-projectile neotree undo-tree which-key js2-mode use-package elpy flycheck xclip rainbow-mode markdown-mode json-mode php-mode ac-php))
;; lista de repositorios que contienen nuestros paquetes

(setq package-archives '(("melpa-stable" . "https://stable.melpa.org/packages/")
                         ("gnu" . "http://elpa.gnu.org/packages/")))
;;                         ("melpa" . "http://melpa.org/packages/")))
;; (require 'package) ;; You might already have this line
;; (let* ((no-ssl (and (memq system-type '(windows-nt ms-dos))
;;                     (not (gnutls-available-p))))
;;        (url (concat (if no-ssl "http" "https") "://melpa.org/packages/")))
;;   (add-to-list 'package-archives (cons "melpa" url) t))
;; (when (< emacs-major-version 24)
;;   ;; For important compatibility libraries like cl-lib
;;   (add-to-list 'package-archives '("gnu" . "http://elpa.gnu.org/packages/"))
;;   (add-to-list 'package-archives
;;                '("melpa-stable" . "https://stable.melpa.org/packages/")))

(package-initialize)


(unless package-archive-contents
  (package-refresh-contents))

;;install los paquetes perdidos
(dolist (package package-list)
  (unless (package-installed-p package)
    (package-install package)))
;; luego vemos que se instala

;;------------------------------------tema------------------------
(load-theme 'dracula t)
(add-to-list 'default-frame-alist '(background-color . "#000000"))

;;------------------------------------autocomplete------------------------
(global-auto-complete-mode)


;;------------------------------------web-mode------------------------
(add-to-list 'auto-mode-alist '("\\.phtml\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.tpl\\.php\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.[agj]sp\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.as[cp]x\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.erb\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.mustache\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.djhtml\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.html?\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.html\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.blade\\.php\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.vue\\'" . web-mode))

;; Customizations
(setq web-mode-markup-indent-offset 2)
(setq web-mode-css-indent-offset 2)
(setq web-mode-code-indent-offset 2)
(setq web-mode-disable-autocompletion t)
(local-set-key (kbd "RET") 'newline-and-indent)

;;------------------------------------emmet------------------------
(add-hook 'web-mode-hook 'emmet-mode) ;; Auto-start on any markup modes
(add-hook 'css-mode-hook 'emmet-mode) ;; enable Emmet's css abbreviation.

;;------------------------------------ac-html------------------------
(add-hook 'web-mode-hook 'ac-html-enable)

;;------------------------------------ac-php------------------------
(add-hook 'php-mode-hook 'ac-php-mode)


;;------------------------------------multiple-cursors------------------------
(global-set-key (kbd "C-^") 'mc/mark-next-like-this)

;;------------------------------------smartparens------------------------
(smartparens-global-mode 1)

;;------------------------------------duplicate-thing-line-or ------------------------
;;(global-set-key (kbd "M-c") 'duplicate-thing)
(defun duplicate-current-line-or-region (arg)
  (interactive "p")
  (let (beg end (origin (point)))
    (if (and mark-active (> (point) (mark)))
        (exchange-point-and-mark))
    (setq beg (line-beginning-position))
    (if mark-active
        (exchange-point-and-mark))
    (setq end (line-end-position))
    (let ((region (buffer-substring-no-properties beg end)))
      (dotimes (i arg)
        (goto-char end)
        (newline)
        (insert region)
        (setq end (point)))
      (goto-char (+ origin (* (length region) arg) arg)))))

(global-set-key (kbd "M-c") 'duplicate-current-line-or-region)
;;------------------------------------flx-ido ------------------------
(ido-mode 1)
(ido-everywhere 1)
(flx-ido-mode 1)
(setq ido-enable-flex-matching t)
(setq ido-use-faces nil)

;;------------------------------------git-gutter-------------------------
(global-git-gutter-mode t)

(global-set-key (kbd "C-x C-g") 'git-gutter)
(global-set-key (kbd "C-x v =") 'git-gutter:popup-hunk)

;; Jump to next/previous hunk
(global-set-key (kbd "C-x p") 'git-gutter:previous-hunk)
(global-set-key (kbd "C-x n") 'git-gutter:next-hunk)

;; Stage current hunk
(global-set-key (kbd "C-x v s") 'git-gutter:stage-hunk)

;; Revert current hunk
(global-set-key (kbd "C-x v r") 'git-gutter:revert-hunk)

;; Mark current hunk
(global-set-key (kbd "C-x v SPC") #'git-gutter:mark-hunk)

;;------------------------------------yasnipets------------------------
(add-to-list 'load-path
             "~/.emacs.d/elpa/yasnippet-0.12.2/snippets")
(yas-global-mode 1)

;;------------------------------------restclient------------------------
;;solo utilizarlo segun el tutorial ya viene instalado aqui

;;------------------------------------neotree------------------------
(global-set-key [f8] 'neotree-toggle)
(setq neo-theme (if (display-graphic-p) 'icons 'arrow))

;;------------------------------------undo-tree------------------------
(global-undo-tree-mode)

;;-------------------------------------which-key-----------------------
(which-key-mode)

;;-------------------------------------config javascript-----------------------
;; (use-package js2-mode :ensure t :defer t
;;   :mode (("\\.js\\'" . js2-mode)
;;          ("\\.json\\'" . javascript-mode))
;;   :commands js2-mode
;;   :init (progn
;;           (setq-default js2-basic-offset 2
;;                         js2-indent-switch-body t
;;                         js2-auto-indent-p t
;;                         js2-global-externs '("angular")
;;                         js2-indent-on-enter-key t
;;                         flycheck-disabled-checkers '(javascript-jshint)
;;                         flycheck-checkers '(javascript-eslint)
;;                         flycheck-eslintrc "~/.eslintrc"))
;;           (add-to-list 'interpreter-mode-alist (cons "node" 'js2-mode))
;;           ;; (add-to-list 'js2-mode-hook 'flycheck-mode)
;;           )

(defun my/use-eslint-from-node-modules ()
  (let* ((root (locate-dominating-file
                (or (buffer-file-name) default-directory)
                "node_modules"))
         (eslint (and root
                      (expand-file-name "node_modules/eslint/bin/eslint.js"
                                        root))))
    (when (and eslint (file-executable-p eslint))
      (setq-local flycheck-javascript-eslint-executable eslint))))

(add-hook 'flycheck-mode-hook #'my/use-eslint-from-node-modules)
(setq js-indent-level 2)


;;------------------------------------helm-projectile-ag------------------------
(global-set-key (kbd "C-x a") 'helm-projectile-ag)

;;------------------------------------elpy------------------------
(elpy-enable)

;;------------------------------------flycheck------------------------
(global-flycheck-mode)

;;------------------------------------xclip------------------------
;; copiar y pegar desde console
(xclip-mode 1)

;;------------------------------------xclip------------------------
(helm-projectile-on)
(global-set-key (kbd "C-x f") 'helm-projectile-find-file)

;;------------------------------------hlinum------------------------
;;(hlinum-activate)
(global-hl-line-mode t)
(set-face-background 'hl-line "#4e4e4e")

;;------------------------------------ac-php------------------------
(add-hook 'php-mode-hook
            '(lambda ()
               (auto-complete-mode t)
               (require 'ac-php)
               (setq ac-sources  '(ac-source-php ) )
               (yas-global-mode 1)

               (ac-php-core-eldoc-setup ) ;; enable eldoc
               (define-key php-mode-map  (kbd "C-]") 'ac-php-find-symbol-at-point)   ;goto define
               (define-key php-mode-map  (kbd "C-t") 'ac-php-location-stack-back)    ;go back
               ))

;;----------------------------------------configuracion para vue -----------
(add-hook 'web-mode-hook #'(lambda () (yas-activate-extra-mode 'js-mode)))
(add-hook 'web-mode-hook #'(lambda () (yas-activate-extra-mode 'js2-mode)))


;;------------------------------------configuracion editor------------------------
(setq-default indent-tabs-mode nil)
(setq-default tab-width 2)
(setq indent-line-function 'insert-tab)
(setq make-backup-files nil)
(defun revert-buffer-no-confirm ()
  (interactive)
  (revert-buffer :ignore-auto :noconfirm))
;;javascript 2 espacios
;;(setq js-indet-level 2)
(add-hook 'js2-mode-hook (lambda () (setq js2-basic-offset 2)))

;;parentesis
(show-paren-mode 1)
;;(require 'paren)
;;(set-face-background 'show-paren-match  "#8a8aff")
(set-face-foreground 'show-paren-match "#def")
(set-face-attribute 'show-paren-match nil :weight 'extra-bold :foreground "#ff5")
;;revert automatico
(global-auto-revert-mode 1)
(xterm-mouse-mode t)

(global-set-key (kbd "M-p") 'previous-buffer)
(global-set-key (kbd "M-n") 'next-buffer)

;;ignorando archivos silversearch
(add-to-list 'projectile-globally-ignored-directories "node_modules")



;;Siguiente



;;Creado por Roy

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   (quote
    (ac-html-bootstrap ac-php php-mode json-mode markdown-mode rainbow-mode xclip flycheck elpy use-package js2-mode which-key undo-tree neotree helm-ag ag yasnippet git-gutter smartparens multiple-cursors ac-html web-mode emmet-mode auto-complete dracula-theme helm-projectile flx-ido dash-functional dash))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

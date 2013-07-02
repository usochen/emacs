;;; ======================================================================
;;; common config
;;; ======================================================================
;; ------------------------- Refresh -------------------------
(defun refresh-file ()
(interactive)
(revert-buffer t t t)
)
(global-set-key [f5] 'refresh-file)

;; Setting English Font
(set-face-attribute
  'default nil :font "Monaco 11")

;; Chinese Font
(dolist (charset '(kana han symbol cjk-misc bopomofo))
    (set-fontset-font (frame-parameter nil 'font)
                      charset
                      (font-spec :family "Heiti SC" :size 14)))

;; ------------------------- Settings -------------------------
(define-key global-map "\C-t" 'goto-line);;自定义快速跳转到某行
(define-key global-map "\C-c\C-v" 'ansi-term);;开启终端
;;整体格式化
(defun indent-whole ()
  (interactive)
  (indent-region (point-min) (point-max))
  (message "format successfully"))
;;绑定到F7键
(global-set-key [f7] 'indent-whole)
;; settings
(global-linum-mode 1) ; always show line numbers
(setq inhibit-startup-message t);; 关闭启动时闪屏
(setq visible-bell t) ;关闭出错时的提示声
(blink-cursor-mode -1);指针不闪
(setq make-backup-files nil) ;不产生备份文件
(setq default-major-mode 'text-mode) ;一打开就起用 text 模式
(global-font-lock-mode t) ;语法高亮
(auto-image-file-mode t) ;打开图片显示功能
(fset 'yes-or-no-p 'y-or-n-p) ;以 y/n代表 yes/no
(column-number-mode t) ;显示列号
(show-paren-mode t) ;显示括号匹配
(display-time-mode 1) ;显示时间，格式如下
(setq display-time-24hr-format t)
(setq display-time-day-and-date t)
(tool-bar-mode nil) ;去掉那个大大的工具栏
;;(scroll-bar-mode nil) ;去掉滚动条
(mouse-avoidance-mode 'animate);光标靠近鼠标指针时，让鼠标指针自动让开
(setq mouse-yank-at-point t) ;支持中键粘贴
(transient-mark-mode t) ;允许临时设置标记
(setq x-select-enable-clipboard t) ;支持emacs和外部程序的粘贴
(setq frame-title-format '("" buffer-file-name "@emacs" )) ;在标题栏显示buffer名称
(setq default-fill-column 80) ;默认显示 80列就换行
(setq bookmark-save-flag 1) ;保存书签
(add-hook 'before-save-hook 'delete-trailing-whitespace)  ;; 删除行尾部空格
(put 'upcase-region 'disabled nil)

;; ------------------ 整行 mode ------------------
;;;; C-w 如果没有选中区域则删除整行
;;;; M-w 如果没有选中区域则复制整行
(defadvice kill-ring-save (before slickcopy activate compile)
"When called interactively with no active region, copy a single line instead."
(interactive
(if mark-active (list (region-beginning) (region-end))
(list (line-beginning-position)
(line-beginning-position 2)))))
(defadvice kill-region (before slickcut activate compile)
"When called interactively with no active region, kill a single line instead."
(interactive
(if mark-active (list (region-beginning) (region-end))
(list (line-beginning-position)
(line-beginning-position 2)))))

;; session
(setq load-path (cons "~/.emacs.d/lisp" load-path))
(require 'session)
(require 'slim-mode)
(require 'ruby-electric)
(require 'caml-font)
(require 'coffee-mode)
(require 'feature-mode)
(require 'haml-mode)
(require 'inf-caml)
(require 'markdown-mode)
(require 'ocaml)
(require 'sass-mode)
(require 'session)
(require 'slim-mode)
(require 'yaml-mode)
(require 'easy-after-load)
(add-hook 'after-init-hook 'session-initialize)

; after-loads/after-ruby-mode.el
(add-hook 'ruby-mode 'yard-mode) ; shameless plug: https://github.com/pd/yard-mode.el
(add-hook 'ruby-mode 'eldoc-mode)
(easy-auto-mode
  '((ruby-mode "\\.rake$" "Rakefile$" "Guardfile$" "Gemfile$"
               "\\.gemspec$" "\\.?irbrc$" "\\.rabl$" "\\.ru$" )
    (markdown-mode "\\.md$" "\\.markdown$")))

(load "desktop")
(desktop-save-mode)

;; ido
(require 'ido)
(ido-mode t)

;; ibuffer
(require 'ibuffer)
(global-set-key (kbd "C-x C-b") 'ibuffer)



;; hippie-expand
(global-set-key [(meta ?/)] 'hippie-expand)
(setq hippie-expand-try-functions-list
      '(try-expand-dabbrev
	try-expand-dabbrev-visible
	try-expand-dabbrev-all-buffers
	try-expand-dabbrev-from-kill
	try-complete-file-name-partially
	try-complete-file-name
	try-expand-all-abbrevs
	try-expand-list
	try-expand-line
	try-complete-lisp-symbol-partially
	try-complete-lisp-symbol))


;;; package manager
(require 'package)
;; Add the original Emacs Lisp Package Archive
(add-to-list 'package-archives
             '("elpa" . "http://tromey.com/elpa/"))
;; Add the user-contributed repository
(add-to-list 'package-archives
             '("marmalade" . "http://marmalade-repo.org/packages/"))


;;; undo_tree
(require 'undo-tree)
(global-undo-tree-mode)

;;yasnippet
(add-to-list 'load-path
              "~/.emacs.d/lisp/yasnippet")
(require 'yasnippet)
(yas-global-mode 1)




;;自己安装的auto-complete 自动补全
(add-to-list 'load-path "~/.emacs.d")
(require 'auto-complete-config)
(require 'popup)

(setq ac-quick-help-prefer-pos-tip t)   ;default is t
(add-to-list 'ac-dictionary-directories "~/.emacs.d/ac-dict")
(ac-config-default)


; Show 0.01 second later
(setq ac-auto-show-menu 0.01)
(setq ac-use-menu-map t)
;; Default settings
(define-key ac-menu-map "\C-n" 'ac-next)
(define-key ac-menu-map "\C-p" 'ac-previous)
(setq ac-ignore-case 'smart)

;(setq load-path (cons "~/.emacs.d/color-theme-6.6.0" load-path))
;(require 'color-theme)
(setq load-path (cons "~/.emacs.d/theme" load-path))
(require 'tango-dark-theme)

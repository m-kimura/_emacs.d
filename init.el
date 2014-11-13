;;
;;似たような設定をOSごとに行うときも基本的にここで
;;


;; LOAD-PATHとしてDropboxのelispディレクトリを読み込む
(setq load-path (cons (concat dropbox-emacs-dir "/elisp") load-path))


;;テーマの設定
(load-theme 'deeper-blue t)

;;パッケージの追加
(require 'package)
(setq package-user-dir "~/Dropbox/_emacs.d/elisp")
(add-to-list 'package-archives '("melpa" . "http://melpa.milkbox.net/packages/") t)
(add-to-list 'package-archives '("marmalade" . "http://marmalade-repo.org/packages/"))
(package-initialize)


;;スタートの非表示
(setq inhibit-startup-screen t)

;pathを引き継ぐ
(exec-path-from-shell-initialize)

;; 行番号表示
(require 'linum)
(global-linum-mode)

;自動改行のoff
(setq text-mode-hook 'turn-off-auto-fill)

;; ; マウスホイールの設定
;; ;; マウスホイールでのスクロール速度の設定
(setq mouse-wheel-scroll-amount '(3 ((shift) . 10) ((control) . nil)))
;; ;; マウスホイールでのスクロールの加速をするかどうか
(setq mouse-wheel-progressive-speed nil)

;undo-tree
(require 'undo-tree)
(global-undo-tree-mode t)
(global-set-key (kbd "M-/") 'undo-tree-redo)


;;auto-complete
(require 'auto-complete)
(require 'auto-complete-config)
(global-auto-complete-mode t)
(add-to-list 'ac-modes 'text-mode)      ;; text-modeでも自動的に有効にする

;; Auto Complete LaTeX の設定
  (require 'auto-complete-latex)
  (setq ac-l-dict-directory "~/Dropbox/_emacs.d/elisp/ac-l-dict/")
  (add-to-list 'ac-modes 'latex-mode)
  (add-hook 'latex-mode-hook 'ac-l-setup)
    ;; for YaTeX
          (when (require 'auto-complete-latex nil t)
            (setq ac-l-dict-directory "~/Dropbox/_emacs.d/elisp/ac-l-dict/")
            (add-to-list 'ac-modes 'yatex-mode)
            (add-hook 'yatex-mode-hook 'ac-l-setup))



;;
;; YaTeX
;;
(setq load-path (cons (concat dropbox-emacs-dir "/elisp/yatex") load-path))
(setq auto-mode-alist
      (cons (cons "\\.tex$" 'yatex-mode) auto-mode-alist))
(autoload 'yatex-mode "yatex" "Yet Another LaTeX mode" t)
(setq YaTeX-kanji-code nil)
(setq YaTeX-latex-message-code 'utf-8)
(setq bibtex-command "upbibtex")
(setq bibtex-command "biber --bblencoding=utf8 -u -U --output_safechars")
;(setq tex-command "~/Dropbox/_emacs.d/elisp/yatex/tex2pdf")
(setq tex-command "~/Dropbox/_emacs.d/elisp/yatex/platex2pdf")
;(setq tex-command "platex")

(cond 
 ((string-match "apple-darwin" system-configuration)  ;; Mac
  (setq dvi2-command "open -a Preview"))              ;; プレビューで
 ((string-match "linux" system-configuration)         ;; Linux
  (setq dvi2-command "evince"))                       ;; evince で PDF を閲覧
; ((string-match "freebsd" system-configuration)      ;; FreeBSD
;  ( XXX ))
; ((string-match "mingw" system-configuration)        ;; Windows
;  ( XXX ))
)
(setq bibtex-command "pbibtex")
;;RefTex
(add-hook 'yatex-mode-hook 'turn-on-reftex)



;;C言語周り
;インデント設定
(add-hook 'c-mode-common-hook
          '(lambda ()
             ;; センテンスの終了である ';' を入力したら、自動改行+インデント
             ;(c-toggle-auto-hungry-state 1)
             ;; RET キーで自動改行+インデント
             (define-key c-mode-base-map "\C-m" 'newline-and-indent)
))

;スペルチェッカ
(add-hook 'c-mode-common-hook
          '(lambda ()
             ;; flyspell-prog-mode をオンにする
             (flyspell-prog-mode)
))

;; C-c c で compile コマンドを呼び出す
(define-key mode-specific-map "c" 'compile)
;; C-c C-z で shell コマンドを呼び出す
(define-key mode-specific-map "z" 'shell)
;; Thanks to "http://www.namazu.org/~tsuchiya/elisp/#shell-command-with-completion"
(shell-command-completion-mode)

;;汎用機の SPF (mule みたいなやつ) には
;;画面を 2 分割したときの 上下を入れ替える swap screen
;;というのが PF 何番かにわりあてられていました。
(defun swap-screen()
  "Swap two screen,leaving cursor at current window."
  (interactive)
  (let ((thiswin (selected-window))
        (nextbuf (window-buffer (next-window))))
    (set-window-buffer (next-window) (window-buffer))
    (set-window-buffer thiswin nextbuf)))
(defun swap-screen-with-cursor()
  "Swap two screen,with cursor in same buffer."
  (interactive)
  (let ((thiswin (selected-window))
        (thisbuf (window-buffer)))
    (other-window 1)
    (set-window-buffer thiswin (window-buffer))
    (set-window-buffer (selected-window) thisbuf)))
(global-set-key [f2] 'swap-screen)
(global-set-key [S-f2] 'swap-screen-with-cursor)


;; OSごとに異なる設定ファイルを読み込む
;;基本的には使わない
;;最後に上書き
(cond 
 ((string-match "apple-darwin" system-configuration) ;; Mac
  (load (concat dropbox-emacs-dir "/init-OSX")))
 ((string-match "linux" system-configuration)        ;; Linux
  (load (concat dropbox-emacs-dir "/init-Linux")))
; ((string-match "freebsd" system-configuration)      ;; FreeBSD
;  (setq os-type 'bsd))
; ((string-match "mingw" system-configuration)        ;; Windows
;  (setq os-type 'win))
)



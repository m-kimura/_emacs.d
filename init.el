;;
;;似たような設定をOSごとに行うときも基本的にここで
;;


;; LOAD-PATHとしてDropboxのelispディレクトリを読み込む
(setq load-path (cons (concat dropbox-emacs-dir "/elisp") load-path))
 

;; OSごとに異なる設定ファイルを読み込む
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

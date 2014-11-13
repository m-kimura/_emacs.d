;;macでのフォントを調節

; 英語
(set-face-attribute 'default nil
           :family "Menlo" ;; font
           :height 150)    ;; font size
 
;; 日本語
(set-fontset-font
 nil 'japanese-jisx0208
;; (font-spec :family "Hiragino Mincho Pro")) ;; font
  (font-spec :family "Hiragino Kaku Gothic ProN")) ;; font
 
;; 半角と全角の比を1:2に
(setq face-font-rescale-alist
      '((".*Hiragino_Mincho_pro.*" . 1.2)))

;;スペルチェッカ
(setq ispell-program-name "/usr/local/bin/aspell")

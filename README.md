_emacs.d
========

For copy to DropBox

このファイルをDropBoxfileにおき、
ローカルのinit.elには


;; Dropboxの共有ディレクトリにおいた.emacs.dのパスを定義
(setq dropbox-emacs-dir "~/Dropbox/_emacs.d")

;; Dropboxのinit.elを読み込む
(load (concat dropbox-emacs-dir "/init.el"))

以上のように記述してください。
ただし、ファイルの中身について絶対パス指定がある部分は相対パスへの書き換え、各自環境に合わせた記述をお願いします。


====================================
Tiarra さんのつかいかた(for Windows)
====================================
(rev.002 2008/05/31) (ja.sjis)

... 目次 ...
1. ActivePerl をいれる.
2. 設定ファイルの準備.
3. tiarraさんの起動.
4. IRC クライアントからつなげる.
5. ブラウザからつなげる.
6. 設定をいじる.

1. ActivePerl をいれる.
-----------------------

1-1. 動作に必要なツールなのでいれます.
     配布元はこちら.(英語のサイトだけど＞＜。)
       http://www.activestate.com/Products/activeperl/
     (ぐーぐるさんにきいていれるのもありb)
1-2. 『Get ActivePerl』のリンクを進む
1-3. 『Download』のリンクを進む(購入(Purchase)のお隣にあるけどきにせず)
1-4. 『Contact Details』いれてねってあるけれど、
     項目は入れなくてもOK(These fields are optional)なので
     気にせず『Continue』
1-5. ダウンロードページにくるので、
     Download ActivePerl 5.8.8.822 for Windows (x86):
     をダウンロード。
     AS package と MSI はどちらかでOK。
     インストーラの形が違うだけで中身は一緒。

1-6. 普通にダブルクリックでインストールをすすめる。
1-7. 多分普通に終わると思う.
     途中ちょっと時間かかるかも.
     (インストールの途中経過はあとで書く…かもしれない)

2. 設定ファイルの準備.
----------------------

2-1. tiarra-r<rev>.zip を展開.
     (==> tiarra-r<rev> というフォルダができます)
     (数字の部分は新しくなると増えます)
2-2. これを C:\tiarra にリネーム.
     (割とどこでもいいけれど空白を含まない場所がいいかも)
2-3. mini.conf を tiarra.conf にリネーム.
     これが設定ファイルになります.

2-4. tiarra.conf をエディタ(メモ帳とか)で開く.
     先頭の方にある
       # ユーザー情報。省略不能です。
       nick: tiarra
       user: tiarra
       name: Tiarra the "Aeon"
     っていうところをそれっぽくかきかえ.
     nick が普段見える名前.
     (user/nameはwhoisしたときに見える部分)

2-5. IRCクライアント接続パスワードの生成.
     (2-4)で書いたすぐしたに, コメントに埋もれて
       tiarra-password: sqPX2TZEectPk
     という行があります.
     make-password.bat をダブルクリックすると
       Please enter raw password:
     と聞かれるので入力してエンター.
       XXXXXXXXXXXXX is your encoded password.
       Use this for the general/tiarra-password entry.
       cleanup TerminateManager...done.
       続行するには何かキーを押してください . . .
     といった感じに出力出るので,
       tiarra-password: XXXXXXXXXXXXX
     というふうに設定ファイルを書き換えます.

     注意) このパスワードでは8文字より長い部分は無視されます.

2-6. Webブラウザ接続パスワード.
     + System::WebClient ブロック内(120行目)に
     auth: :basic ircweb ircpass
     という行があります.
     auth: :basic <ユーザ名> <パスワード>
     という形式で適当なユーザ名及びパスワードに変更してください.
     (この行ではmake-password.batを使う必要はありません)
     (make-password.batを使った場合には {CRYPT}XXXX と記述すれば利用できます)

2-7. 忘れずに保存して設定完了.

3. tiarraさんの起動
-------------------
3-1. run-tiarra.bat をダブルクリックで起動します.
3-2. 起動すると
       C:\tiarra>perl tiarra  >> tiarra.log 2>&1
     とだけ表示されます(固まってるぽくてもOK).

3-3. 実行のログが tiarra.log に出力されます.

     ファイルの最後の方に,
       [pid:1896 2008/04/08 01:37:06] Tiarra started listening 6667/tcp. (IPv4)
     みたいな行がでていればきっと大丈夫です.

(エラー診断1)
  画面に
    プロセスはファイルにアクセスできません。別のプロセスが使用中です。
  と出ていたら, もう起動済みっぽいです.
  解決方法:
    もう起動してるからそれ以上起動しなくていいはづ.
    エディタによってはログファイルを開いてたらこれがでるかもしれません.

(エラー診断2)
    C:\tiarra>pause
    続行するには何かキーを押してください . . .
  と出たら, 何か起動に失敗しています.
  tiarra.log を確認してみてください.
  解決方法(1):
      Usage: tiarra [--config=config-file] [options]
    とか
      cleanup TerminateManager...done.
    みたいな行があれば, mini.conf を tiarra.conf にコピーするのを
    わすれています.
  解決方法(2):
      'perl' は、内部コマンドまたは外部コマンド、
      操作可能なプログラムまたはバッチ ファイルとして認識されていません。
    みたな行があったら, ActivePerl のインストールに失敗してるっぽいです.
    入れ直したらなおるかも？


4. IRC クライアントからつなげる.
--------------------------------
4-1. 普通のircサーバの代わりに,
       server: localhost
       port:   6667
     につなげます.
4-2. 繋がればOK.
     あとは普通と一緒.

(エラー診断1)
  * 繋がらない.
  解決方法:
    (あとでかく)

5. ブラウザからつなげる.
------------------------
5-0. mini.conf を使った場合デフォルトでこの設定が入っています.
     それ以外の場合には System::WebClient を適切に設定してください.
5-1. ブラウザで
       http://127.0.0.1:8668/irc/
     を開く.
     パスワードはmini.confのままだと
       user: ircweb
       pass: ircpass
     2-6 で変更した場合はそれ.

(エラー診断1)
  * 繋がらない.
  解決方法:
    (あとでかく)
    とりあえず + Sytem::WebClient のなかで
      debug: 1
    をいれると tiarra.log にいろいろでてきます.


6. 設定をいじる.
----------------
6-1. tiarra.conf を適当にいじります.
6-2. でも普通のWindows/Macユーザには優しくないです＞＜。
     (テキスト形式の設定ファイルを直接いじれる程度の能力が必要)
6-3. モジュール(追加機能)の一覧は
      http://svn.coderepos.org/share/lang/perl/tiarra/trunk/doc/module-toc.html
     にあるので参考に(日本語サイト).
6-4. sample.conf とか all.conf も参考になるかも？
     (書いてあることは一応一緒だけど)
6-5. おすすめのモジュールは
     + Log::Channel   チャンネルやprivのログを取るモジュール。
     + Auto::Oper     特定の文字列を発言した人を+oする。
     + Auto::Reply    特定の発言に反応して発言をします。
     あたり.
     設定を変えた後の反映方法は
     + System::Reload
     を参照( /load ってうつだけだけど).

6-6. 注意事項
     モジュールの更新と設定の変更を同時に行った場合,
     モジュールの更新が行われません.
     (内部実装の変更を検討中)
     この場合モジュールの解除/再登録を行うか, ファイルのタイムスタンプを
     更新するかする必要があります.

     モジュールの解除/再登録は, モジュールの名前が Sample::Module だったとすると
     1. tiarra.conf で + Sample::Module { を - Sample Module { 
        にしてリロード(/load)
     2. tiarra.conf で - Sample::Module { を + Sample Module { 
        に戻して再度リロード(/load)
     で行えます.

更新履歴.
rev.002 2008/05/31 微妙に調整.
rev.001 2008/04/08 初版
[EOF]

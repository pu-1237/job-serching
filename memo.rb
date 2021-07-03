npm
npmは、JavaScript（正確にはNode.jsモジュール）のパッケージマネージャです。
言ってみれば、JavaScript世界におけるRubygemです。

Yarn
yarnは、npmより新しいパッケージマネージャです。
yarnはnpmのリポジトリからパッケージを取得する点は同じですが、その他の機能もあります。
yarn.lockというファイルを自動生成し、必要なバージョンのnpmパッケージをそのファイルでロックします。
RubyのGemfile.lockと同じようなものです。
npmよりずっと高速です。

Node.js
JavaScriptをサーバーサイドで使うための環境のこと。
パフォーマンス向上に役立つ場合があることから近年注目を浴びている。

webpack
JSのモジュールをまとめるモジュールバインドです。
参照↓
https://qiita.com/jesus_isao/items/1f519b2c6d53f336cadd

Webpacker
Ruby on Rails上でwebpackを扱うためのgemパッケージ です。
Rails6.0より、webpackerが標準実装になりました。

Rails6にJQueryとBootstrapを導入
Rails6ではcssは引き続きSprocketsで、jsはWebpackerで扱う。
ネット記事ではcssをWebpacker配下に配置して全てWebpackerで管理してしまう対処があるがこれは奇妙な配置である。
参考↓
https://knmts.com/become-engineer-4/

credentials.yml.enc を 編集する📝
$ EDITOR="vi" bin/rails credentials:edit

herokuにcssが適用されない原因
webpacker.ymlの  extract_css: false (CSSファイルを別に設定する)がtrueになっていると反映されない

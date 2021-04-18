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



User
has_many :events, dependent: :destroy　#Userは複数のイベントを持つ
has_many :event_applicants, foreign_key: 'applicant_id'　#Userは複数の申し込みを持つ

Event
belongs_to :user　  #EventはUser属する
has_many :event_applicants, dependent: :destroy　#Eventは複数の申し込みを持つ
has_many :applicants, through: :event_applicants, dependent: :destroy　#イベントは申し込みを通して、複数の申し込み者(User)を持つ

EventApplicant    
belongs_to :applicant, class_name: 'User', foreign_key: 'applicant_id'　#申し込みは申し込み者(User)に属する。
validates_uniqueness_of :event_id, scope: :applicant_id　#イベントidと申し込み者idで申し込みは一意である。

event_applicants = current_user.event_applicants.map(&:event_id)


class ApplicationRecord < ActiveRecord::Base
  # Railsでデータベースを操作するための強力な機能を持つActiveRecord::Baseを継承
  # ApplicationRecordクラスを作成

  # これは設定用のベースクラスであって、application_recordというテーブルは存在しないと宣言
  # 複数のデータベースを扱う場合に、このクラスがメインのデータベース接続の基準になることを示す
  primary_abstract_class
end

class MicropostSerializer < ActiveModel::Serializer
  # JSONで返却するカラムを指定
  attributes :id, :content, :created_at, :updated_at, :user
  # レスポンス内の項目をuser_serializerで定義した項目を返却するようにする
  belongs_to :user
end

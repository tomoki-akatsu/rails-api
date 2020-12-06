class MicropostSerializer < ActiveModel::Serializer
  # JSONで返却するカラムを指定
  attributes :id, :content, :created_at, :updated_at, :user
end

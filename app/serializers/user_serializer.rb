class UserSerializer < ActiveModel::Serializer
  # JSONで返却するカラムを指定
  attributes :id, :name, :email
end

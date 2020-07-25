# jsonのフォーマットを指定するための設定
# 未設定時はルートキーなしでjsonレスポンスを作成する
# :json指定時はルートキーを含める
# :json_api指定時は下記URLのフォーマットに従う
# https://jsonapi.org/format/
ActiveModelSerializers.config.adapter = :json

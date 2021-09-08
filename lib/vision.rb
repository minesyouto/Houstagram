require 'base64'
require 'json'
require 'net/https'

module Vision
  class << self
    def get_image_data(image_file)
      # APIのURL作成
      api_url = "https://vision.googleapis.com/v1/images:annotate?key=#{ENV['GOOGLE_API_KEY']}"

      # 画像をbase64にエンコード
      #base64_imageはしっかりエンコードされて変数に代入されていた
      #APIに渡すデータは問題ない？
      base64_image = Base64.encode64(open("#{Rails.root}/public/uploads/#{image_file.post_image_id}").read)

      # APIリクエスト用のJSONパラメータ
      params = {
        requests: [{
          image: {
            content: base64_image
          },
          features: [
            {
              type: 'LABEL_DETECTION'
            }
          ]
        }]
      }.to_json

      # Google Cloud Vision APIにリクエスト
      uri = URI.parse(api_url)
      https = Net::HTTP.new(uri.host, uri.port)
      https.use_ssl = true
      request = Net::HTTP::Post.new(uri.request_uri)
      request['Content-Type'] = 'application/json'
      response = https.request(request, params)
      response_body = JSON.parse(response.body)
      # APIレスポンス出力
      puts response_body
      #response_bodyも問題ない。タグも返ってきているが以下の処理でresponse_bodyがnilと言われている？
      response_body['response']['labelAnnotations'].pluck('description').take(3)
    end
  end
end
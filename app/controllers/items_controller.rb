class ItemsController < ApplicationController
    
    def search
        @items = []
        @keyword = params[:keyword]
        if @keyword.present?
            #ここでresultsに楽天APIから取得したデータ(jsonデータ)を格納する
            #今回は商品名を検索して一致するデータを格納するように設定
            results = RakutenWebService::Ichiba::Item.search(keyword: @keyword)
            #次にここで@itemsに取得したjsonデータのうち最初の10件を格納する
            results.first(10).each do |result|
                item = Item.new(read(result))
                @items << item
            end
        end
        #ここで@items内のデータを保存する
        #すでに保存済みのデータを除外するためにunlessを使う
        @items.each do |item|
            unless Item.all.include?(item)
                item.save
            end
        end
    end
    
    def update
        @item = Item.find(params[:id])
        render 'posts/item'
    end
    #質問事項
    #@itemsという空の配列を用意して、その中にアイテムを追加していきたい
    #このItemと投稿を紐付けたい
    
    
    private
    #楽天APIのデータから必要なデータを絞り込む、且つ対応するカラムにデータを格納するメソッドを設定
    def read(result)
        name = result["itemName"]
        code = result["itemCode"]
        price = result["itemPrice"]
        url = result["itemUrl"]
        imageflag = result["imageFlag"]
        image = result['mediumImageUrls'].first.gsub('?_ex=128x128', '')
        {
            name: name,
            code: code,
            price: price,
            url: url,
            imageflag: imageflag,
            image: image
        }
    end
    
    
end
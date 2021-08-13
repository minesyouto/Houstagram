class ItemsController < ApplicationController
    
    def search
        @items = []
        @keyword = params[:keyword]
        if @keyword.present?
            #ここでresultsに楽天APIから取得したデータ(jsonデータ)を格納する
            #今回は商品名を検索して一致するデータを格納するように設定
            results = RakutenWebService::Ichiba::Item.search(keyword: params[:keyword])
            #次にここで@itemsに取得したjsonデータのうち最初の10件を格納する
            results.first(10).each do |results|
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
    
    private
    #楽天APIのデータから必要なデータを絞り込む、且つ対応するカラムにデータを格納するメソッドを設定
    def read(result)
        itemname = result["itemName"]
        itemcode = result["itemCode"]
        itemprice = result["itemPrice"]
        itemurl = result["itemUrl"]
        imageflag = result["imageFlag"]
        mediumimageurls = result["mediumImageUrls"]
        {
            itemname: itemname,
            itemcode: itemcode,
            itemprice: itemprice,
            itemurl: itemurl,
            imageflag: imageflag,
            mediumimageurls: mediumimageurls
        }
    end
    
    
end
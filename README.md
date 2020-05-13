## チームメンバー

高澤、佐藤、月野木


## 課題

http://devtesting.jp/tddbc/?TDDBC%E5%A4%A7%E9%98%AA3.0%2F%E8%AA%B2%E9%A1%8C


## 使い方

````
# teamA_vending_machineディレクトリ上で実行
$ irb

# ファイルを読み込み
> require './lib/vending_machine.rb'

# 自動販売機の作成
> machine = VendingMachine.new # => #<VendingMachine:0x00007fa1242829a0 @total=0, @sale_amount=0, @drink_stock={:cola=>{:price=>120, :stock=>5}, :redbull=>{:price=>200, :stock=>5}, :water=>{:price=>100, :stock=>5}}>


# ドリンクを補充
> machine.drink_store(Drink.new(:tea,500)) # =>"teaを1本追加しました"

# ドリンクの在庫確認
> machine.drink_stock # => {:cola=>{:price=>120, :stock=>5}, :redbull=>{:price=>200, :stock=>5}, :water=>{:price=>100, :stock=>5}, :tea=>{:price=>500, :stock=>1}}

# お金の投入
> machine.insert(1) # => "1円は使えません"
> machine.insert(100) # => 100
> machine.insert(50) # => 150

# 投入額の確認
> machine.total # => 150

# 投入額の払い戻し
> machine.refund # => "150円を払い戻し"
> machine.total # => 0
> machine.refund # => "払い戻すお金はありません"

# お金の投入→購入できるドリンクの確認→ドリンクの購入
> machine.insert(1000) # => 1000
> machine.purchasable_drink # => [:cola, :redbull, :water, :tea]
> machine.purchase(:tea) # => "購入した飲み物：tea,購入金額：500円" => "500円を払い戻し"

# 売上合計額の確認
> machine.sale_amount # => 100

# ドリンク購入後:ドリンクの購入→投入額→ドリンクの在庫→購入できるドリンクの情報
> machine.purchase(:tea) # => "売り切れ＆お金が足りません"
> machine.total # => 0
> machine.drink_stock # => {:cola=>{:price=>120, :stock=>5}, :redbull=>{:price=>200, :stock=>5}, :water=>{:price=>100, :stock=>5}, :tea=>{:price=>500, :stock=>0}}
> machine.purchasable_drink # => []

# ドリンクの値段を変える
> machine.drink_stock # => {:cola=>{:price=>120, :stock=>5}, :redbull=>{:price=>200, :stock=>5}, :water=>{:price=>100, :stock=>5}, :tea=>{:price=>500, :stock=>0}}
> machine.drink_store(Drink.new(:cola,200)) # =>"colaを1本追加しました"
> machine.drink_stock # => {:cola=>{:price=>200, :stock=>6}, :redbull=>{:price=>200, :stock=>5}, :water=>{:price=>100, :stock=>5}, :tea=>{:price=>500, :stock=>0}}
````


## Rspecインストール時の参考資料

https://qiita.com/luckypool/items/e3662170033347510c3c
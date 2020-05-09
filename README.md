##課題
    http://devtesting.jp/tddbc/?TDDBC%E5%A4%A7%E9%98%AA3.0%2F%E8%AA%B2%E9%A1%8C

##使い方

````
$ irb

# ファイルを読み込み
> require '../lib/vending_machine.rb'

# 自動販売機の作成
> machine = VendingMachine.new

# ドリンクを補充
> machine.drink_stock(Drink.new(:tea,500)) # =>"teaを1本追加しました"

# ドリンクの在庫確認
> machine.drink_table # => {:cola=>{:price=>120, :stock=>6}, :redbull=>{:price=>200, :stock=>5}, :water=>{:price=>100, :stock=>5}, :tea=>{:price=>500, :stock=>1}}

# お金の投入
> machine.insert(1) # => "1円は使えません"
> machine.insert(100) # => 100
> machine.insert(50) # => 50

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
> machine.purchase(:tea) # => "購入できません"
> machine.total # => 0
> machine.drink_table # => {:cola=>{:price=>120, :stock=>5}, :redbull=>{:price=>200, :stock=>5}, :water=>{:price=>100, :stock=>5}, :tea=>{:price=>500, :stock=>0}}
> machine.purchasable_drink # => []
````
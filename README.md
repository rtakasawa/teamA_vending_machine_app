##課題
http://devtesting.jp/tddbc/?TDDBC%E5%A4%A7%E9%98%AA3.0%2F%E8%AA%B2%E9%A1%8C

##使い方
````
$ irb
> require '../lib/vending_machine.rb'
> machine = VendingMachine.new
> machine.drink_stock Drink.new(:tea,500) # =>"teaを1本追加しました"
> machine.drink_table # => {:cola=>{:price=>120, :stock=>6}, :redbull=>{:price=>200, :stock=>5}, :water=>{:price=>100, :stock=>5}, :tea=>{:price=>500, :stock=>1}}
> machine.insert 1 # => "1円は使えません"
> machine.insert 100 # => 100
> machine.insert 50 # => 50
> machine.total # => 150
> machine.refund # => "150円を払い戻し"
> machine.total # => 0
> machine.refund # => "払い戻すお金はありません"
> machine.insert 1000 # => 1000
> machine.total # => 1000
> machine.purchasable_drink # => => [:cola, :redbull, :water, :tea]
> machine.purchase :tea # => "購入した飲み物：tea,購入金額：500円" => "500円を払い戻し"
> machine.purchase :tea # => "購入できません"
> machine.total # => 0
> machine.sale_amount=> 100
> machine.drink_table # => {:cola=>{:price=>120, :stock=>5}, :redbull=>{:price=>200, :stock=>5}, :water=>{:price=>100, :stock=>5}}
> machine.purchasable_drink  # => []
> exit
````
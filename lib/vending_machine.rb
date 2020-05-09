require '../lib/drink.rb'
require "pry"

class VendingMachine

  # 利用できるお金を定義
  AVAILABLE_MONEY = [10, 50, 100, 500, 1000].freeze

  # これで投入合計額、売上金額、ドリンクの情報をメソッドで呼び出せる。
  attr_reader :total,:sale_amount,:drink_table

  # 初期設定でコーラ、レッドブル、水を5本ずつ追加
  def initialize
    @total = 0 # 投入合計額
    @sale_amount = 0 # 売上合計額
    @drink_table = {} # ドリンクの格納庫
    5.times { drink_stock(Drink.new(:cola,120)) }
    5.times { drink_stock(Drink.new(:redbull,200)) }
    5.times { drink_stock(Drink.new(:water,100)) }
  end

  # 飲み物の補充
  def drink_stock(drink)
    # 新しいドリンクを格納する場合
    unless @drink_table.has_key?(drink.name)
      @drink_table.store(drink.name,{price: drink.price,stock: 1})
      "#{drink.name}を1本追加しました"
    else
      @drink_table[drink.name][:price] = drink.price # price変更の可能性もあるため追記
      @drink_table[drink.name][:stock] += 1
      "#{drink.name}を1本追加しました"
    end
  end

  # お金の投入
  def insert(money)
    if VendingMachine::AVAILABLE_MONEY.include?(money)
      @total += money
      money
    else
      "#{money}円は使えません"
    end
  end

  # お金の払い戻し
  def refund
    if @total == 0
      "払い戻すお金はありません"
    else
      refund_money = @total
      @total = 0
      "#{refund_money}円を払い戻し"
    end
  end

  # 購入できる飲み物の名前を取得する
  def purchasable_drink
    # selectで条件に合うハッシュを取り出し、keysでキー（ドリンクネーム）を取り出し
    @drink_table.select{| drink, price_and_stock |
      price_and_stock[:price] <= @total && price_and_stock[:stock] > 0 }.keys
  end

  # 飲み物の購入
  def purchase(drink_name)
    if purchasable_drink.include?(drink_name)
      @drink_table[drink_name][:stock] -= 1
      @sale_amount += @drink_table[drink_name][:price]
      # @total -= @drink_table[drink_name][:price] # 都度refundしているため、コメントアウト
      drink_price = @drink_table[drink_name][:price]
      p "購入した飲み物：#{drink_name},購入金額：#{drink_price}円"
      refund
    else
      "購入できません"
    end
  end
end
require '../lib/drink.rb'
require "pry"

class VendingMachine
  AVAILABLE_MONEY = [10, 50, 100, 500, 1000].freeze

  # これで投入合計額、売上金額をメソッドで呼び出せる。
  attr_reader :total,:sale_amount,:drink_table

  # 初期設定でコーラ、レッドブル、水を5本ずつ追加
  def initialize
    @total = 0
    @sale_amount = 0
    @drink_table = {}
    5.times { drink_stock(Drink.cola) }
    5.times { drink_stock(Drink.redbull) }
    5.times { drink_stock(Drink.water) }
  end

  # 飲み物の補充
  def drink_stock(drink)
    unless @drink_table.has_key?(drink.name)
      @drink_table.store(drink.name,{price: drink.price,stock: 1})
    else
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

  # 購入できる飲み物の情報を取得する
  def purchasable_drink
    @drink_table.select{| drink, price_and_stock | price_and_stock[:price] <= @total && price_and_stock[:stock] > 0 }.keys
  end

  def purchase_money_check(drink)
    @total > @drink_table[drink.name][:price]
  end

  def purchase_stock_check(drink)
    @drink_table[drink.name][:stock] > 0
  end

  # 飲み物の購入
  def purchase(drink)
    if purchase_stock_check(drink) && purchase_money_check(drink)
      @drink_table[drink.name][:stock] -= 1
      @sale_amount += @drink_table[drink.name][:price]
      @total -= @drink_table[drink.name][:price]
      p "購入した飲み物：#{drink.name},購入金額：#{drink.price}円"
      refund
    else
      "購入できません"
    end
  end
end
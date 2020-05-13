require './lib/drink.rb'
require "pry"

class VendingMachine

  # 利用できるお金を定義
  AVAILABLE_MONEY = [10, 50, 100, 500, 1000].freeze

  # これで投入合計額、売上金額、ドリンクの情報をメソッドで呼び出せる。
  attr_reader :total,:sale_amount,:drink_stock

  # 初期設定でコーラ、レッドブル、水を5本ずつ追加
  def initialize
    @total = 0 # 投入合計額
    @sale_amount = 0 # 売上合計額
    @drink_stock = {} # ドリンクの格納庫
    drink_store(Drink.new(:cola,120,5))
    drink_store(Drink.new(:redbull,200,5))
    drink_store(Drink.new(:water,100,5))
  end

  # 飲み物の格納
  def drink_store(drink)
    unless @drink_stock.has_key?(drink.name)
      @drink_stock.store(drink.name,{price: drink.price,stock: drink.stock})
      "#{drink.name}を#{drink.stock}本追加しました"
    else
      @drink_stock[drink.name][:price] = drink.price
      @drink_stock[drink.name][:stock] += drink.stock
      "#{drink.name}を#{drink.stock}本追加しました"
    end
  end

  # お金の投入
  def insert(money)
    if VendingMachine::AVAILABLE_MONEY.include?(money)
      @total += money
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
    @drink_stock.select{| drink, price_and_stock | price_and_stock[:price] <= @total && price_and_stock[:stock] > 0 }.keys
  end

  # 飲み物の購入
  def purchase(drink_name)
    return "そのような飲み物は存在しない" unless @drink_stock.include?(drink_name)
    unless purchasable_drink.include?(drink_name)
      if @drink_stock[drink_name][:stock] == 0 && @drink_stock[drink_name][:price] > @total
        return "売り切れ＆お金が足りません"
      elsif @drink_stock[drink_name][:stock] == 0
        return "売り切れです。"
      else
        return "お金が足りません"
      end
    else
      @drink_stock[drink_name][:stock] -= 1
      @sale_amount += @drink_stock[drink_name][:price]
      @total -= @drink_stock[drink_name][:price]
      p "購入した飲み物：#{drink_name},購入金額：#{@drink_stock[drink_name][:price]}円"
      refund
    end
  end
end
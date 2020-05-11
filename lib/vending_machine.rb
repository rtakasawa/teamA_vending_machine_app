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
    drink_stock(Drink.new(:cola,120,5))
    drink_stock(Drink.new(:redbull,200,5))
    drink_stock(Drink.new(:water,100,5))
  end

  # 飲み物の補充
  def drink_stock(drink)
    # 新しいドリンクを格納する場合
    unless @drink_table.has_key?(drink.name)
      @drink_table.store(drink.name,{price: drink.price,stock: drink.stock})
      "#{drink.name}を#{drink.stock}本追加しました"
    else
      @drink_table[drink.name][:price] = drink.price # price変更の可能性もあるため追記
      @drink_table[drink.name][:stock] += drink.stock
      "#{drink.name}を#{drink.stock}本追加しました"
    end
  end

  # お金の投入
  def insert(money)
    if VendingMachine::AVAILABLE_MONEY.include?(money)
      @total += money # totalの結果を出力
      # money
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
    drink_name = @drink_table.select{| drink, price_and_stock | price_and_stock[:price] <= @total && price_and_stock[:stock] > 0 }.keys
    if drink_name == []
      "購入できる飲み物はありません"
    else
      drink_name
    end
  end

  def purchase(drink_name)
    return "そのような飲み物はありません" unless @drink_table.include?(drink_name)
    if purchasable_drink == "購入できる飲み物はありません"
      if @drink_table[drink_name][:stock] == 0 && @drink_table[drink_name][:price] >= @total
        return "売り切れ＆お金が足りません"
      elsif @drink_table[drink_name][:stock] == 0
        return "売り切れです。"
      else
        return "お金が足りません"
      end
    end
    @drink_table[drink_name][:stock] -= 1
    @sale_amount += @drink_table[drink_name][:price]
    @total -= @drink_table[drink_name][:price]
    # drink_price = @drink_table[drink_name][:price]
    p "購入した飲み物：#{drink_name},購入金額：#{@drink_table[drink_name][:price]}円"
    refund
  end
end

# # 購入できる飲み物の名前を取得する（実装確認済み）1
# def purchasable_drink
#   # selectで条件に合うハッシュを取り出し、keysでキー（ドリンクネーム）を取り出し
#   @drink_table.select{| drink, price_and_stock |
#     price_and_stock[:price] <= @total && price_and_stock[:stock] > 0 }.keys
# end

# # 飲み物の購入１
# def purchase(drink_name)
#   return "購入できません" unless purchasable_drink.include?(drink_name)
#   @drink_table[drink_name][:stock] -= 1
#   @sale_amount += @drink_table[drink_name][:price]
#   @total -= @drink_table[drink_name][:price]
#   drink_price = @drink_table[drink_name][:price]
#   p "購入した飲み物：#{drink_name},購入金額：#{drink_price}円"
#   refund
# end
#
# # 飲み物の購入２
# # 購入できない時のメッセージを分けてる
# # どちらもない時のメッセージがない。メッソドで分ける必要あり。
# def purchase_two(drink_name)
#   unless purchasable_drink.include?(drink_name)
#     if @drink_table[drink_name][:stock] == 0 && @drink_table[drink_name][:price] >= @total
#       return "売り切れです。お金が足りません"
#     elsif @drink_table[drink_name][:stock] == 0
#       return "売り切れです。"
#     elsif @drink_table[drink_name][:price] >= @total
#       return "お金が足りません"
#     else
#       return "そのような飲み物はありません"
#     end
#   end
#   @drink_table[drink_name][:stock] -= 1
#   @sale_amount += @drink_table[drink_name][:price]
#   drink_price = @drink_table[drink_name][:price]
#   p "購入した飲み物：#{drink_name},購入金額：#{drink_price}円"
#   refund
# end
#
#   def purchase(drink_name)
#     unless purchasable_drink.include?(drink_name)
#       if @drink_table.include?(drink_name)
#         return "そのような飲み物ないので、動作しない"
#       elsif @drink_table[drink_name][:stock] == 0 && @drink_table[drink_name][:price] >= @total
#         return "売り切れです。お金が足りません"
#       elsif @drink_table[drink_name][:stock] == 0
#         return "売り切れです。"
#       else
#         return "お金が足りません"
#       end
#     end
#     @drink_table[drink_name][:stock] -= 1
#     @sale_amount += @drink_table[drink_name][:price]
#     @total -= @drink_table[drink_name][:price]
#     # drink_price = @drink_table[drink_name][:price]
#     p "購入した飲み物：#{drink_name},購入金額：#{@drink_table[drink_name][:price]}円"
#     refund
#   end
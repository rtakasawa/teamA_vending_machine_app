# require 'spec_helper'
require 'vending_machine'

describe VendingMachine do
  before do
    @machine = VendingMachine.new
  end

  describe "お金の投入" do
    context "お金を投入した場合" do
      it "利用できるお金の場合、投入した金額の合計額を出力する" do
        expect(@machine.insert(10)).to eq 10
        expect(@machine.insert(50)).to eq 60
        expect(@machine.insert(100)).to eq 160
        expect(@machine.insert(500)).to eq 660
        expect(@machine.insert(1000)).to eq 1660
      end
      it "利用できないお金の場合、使えない旨のメッセージを出力する" do
        expect(@machine.insert(1)).to eq "1円は使えません"
      end
    end
  end

  describe "お金の払い戻し" do
    context "お金の払い戻し処理を選択した場合" do
      it "払い戻すお金が０円の場合は、その旨のメッセージを出力する" do
        expect(@machine.refund).to eq "払い戻すお金はありません"
      end
      it "払い戻すお金がある場合は、投入額を０円にし、投入額を払い戻す" do
        @machine.insert(10)
        expect(@machine.refund).to eq "10円を払い戻し"
        expect(@machine.total).to eq 0
      end
    end
  end

  describe "飲み物の格納" do
    context "飲み物を格納する場合" do
      it "指定のドリンクの名前、価格、本数を格納できる" do
        expect(@machine.drink_store(Drink.new(:tea,100,5))).to eq "teaを5本追加しました"
        expect(@machine.drink_stock).to include :tea => {:price=>100, :stock=>5}
      end
      it "格納したドリンクの値段を変更できる" do
        @machine.drink_store(Drink.new(:tea,100,5))
        @machine.drink_store(Drink.new(:tea,500,1))
        expect(@machine.drink_stock).to include :tea => {:price=>500, :stock=>6}
      end
    end
  end

  describe "購入できる飲み物の確認" do
    context "購入できる飲み物を確認した場合" do
      it "購入できる飲み物がない場合は、[]を表示する" do
        expect(@machine.purchasable_drink).to eq []
      end
      it "購入できる飲み物がある場合は、その飲み物の名前を表示する" do
        @machine.insert(100)
        expect(@machine.purchasable_drink).to include :water
      end
    end
  end

  describe "飲み物の購入" do
    context "飲み物を購入する場合" do
      it "格納されたことがない飲み物を指定した場合、買えない旨を表示する" do
        expect(@machine.purchase(:pepusi)).to eq "そのような飲み物は存在しない"
      end
      it "指定した飲み物が売り切れ、かつ投入額が足りない場合、買えない理由を表示する" do
        @machine.drink_store(Drink.new(:tea,100,1))
        @machine.insert(100)
        @machine.purchase(:tea)
        expect(@machine.purchase(:tea)).to eq "売り切れ＆お金が足りません"
      end
      it "指定した飲み物が売り切れの場合、売り切れと表示する" do
        @machine.drink_store(Drink.new(:tea,100,1))
        @machine.insert(100)
        @machine.purchase(:tea)
        @machine.insert(100)
        expect(@machine.purchase(:tea)).to eq "売り切れです。"
      end
      it "投入額が足りない場合、お金が足りないと表示する" do
        @machine.insert(10)
        expect(@machine.purchase(:cola)).to eq "お金が足りません"
      end
      it "購入できる場合、お金の払い戻し、売上金額の計上、本数の減少がされる" do
        @machine.insert(500)
        expect(@machine.purchase(:cola)).to eq "380円を払い戻し"
        expect(@machine.total).to eq 0
        expect(@machine.sale_amount).to eq 120
        expect(@machine.drink_stock).to include :cola => {:price=>120, :stock=>4}
      end
    end
  end
end
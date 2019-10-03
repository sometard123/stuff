package ninjakiwi.monkeyTown.btdModule.premium
{
   import assets.premium.DoubleCash;
   import assets.premium.DoubleHealth;
   import assets.premium.DoubleRanga;
   import assets.premium.Dreadnaught;
   import assets.premium.MegaMonkeyEverythingPack;
   import assets.premium.MonkeyMoneyInvestment;
   import assets.premium.MoreMonkeyMoney;
   import assets.premium.SplodeyDarts;
   
   public class PremiumSaleFactory
   {
       
      
      public var premiumItems:Vector.<ShopItemDef>;
      
      public function PremiumSaleFactory()
      {
         this.premiumItems = new Vector.<ShopItemDef>();
         super();
         this.premiumItems.push(new ShopItemDef().Id(1).Name("Small Energy Potion (50)").Description("Restores 50 Energy to your energy bar. The regular sized combo of energy nom nom nom.").MynkID(562).Thumb(MegaMonkeyEverythingPack).Price(5),new ShopItemDef().Id(2).Name("Large Energy Potion (100)").Description("Restores 100 Energy to your energy bar. Upsize your energy combo for those extra hungry gamers.").MynkID(563).Thumb(MoreMonkeyMoney).Price(10),new ShopItemDef().Id(3).Name("Tasty Energy Potion (500)").Description("Restores 500 Energy to your energy bar. Supersize sir? Yes please!").MynkID(564).Thumb(MoreMonkeyMoney).Price(45),new ShopItemDef().Id(4).Name("Powerful Energy Potion (1000)").Description("Restores 1000 Energy to your energy bar. There\'s not a combo on this planet as big as this one!").MynkID(565).Thumb(MonkeyMoneyInvestment).Price(80),new ShopItemDef().Id(5).Name("Limited Stamina Potion (10)").Description("Perminately increases Max Energy by 10. Can only be bought 10 times.").Thumb(MonkeyMoneyInvestment).Price(200).Currency(ShopItemDef.CURRENCY_MEDALLIONS).UseLimit(10),new ShopItemDef().Id(6).Name("Stamina Potion (10)").Description("Perminately increases Max Energy by 10. A thorough workout can extend the amount of energy you have for every day activities").MynkID(566).Thumb(MonkeyMoneyInvestment).Price(10),new ShopItemDef().Id(7).Name("Massive Stamina Potion (500)").Description("Perminately increases Max Energy by 500. A personal trainer destroys your ass for a whole year leading you to have the energy compacity of champions!").MynkID(568).Thumb(DoubleCash).Price(450),new ShopItemDef().Id(8).Name("Handful of Medallions (100)").Description("Adds 100 Medallions to your treasury. Thanks for the NK coins, heres a handful of Medallions and I have big hands.").MynkID(569).Thumb(DoubleHealth).Price(5),new ShopItemDef().Id(9).Name("Bag of Medallions (500)").Description("Adds 500 Medallions to your treasury. I got sick of using my hands so I put the Medallions in this bag, I think you get more this way.").MynkID(571).Thumb(DoubleRanga).Price(23),new ShopItemDef().Id(10).Name("Chest of Medallions (2000)").Description("Adds 2000 Medallion to your treasury. All the bags tore after awhile so I put them in this big as chest, there\'s heaps in there, enjoy!").MynkID(572).Thumb(Dreadnaught).Price(90),new ShopItemDef().Id(11).Name("Big Book of Knowledge").Description("Unlocks all towers and their teir 4 upgrades. This Big Book of Knowledge will make you the master expert in the arts of Monkey tower construction.").MynkID(573).Thumb(SplodeyDarts).Price(50));
      }
   }
}

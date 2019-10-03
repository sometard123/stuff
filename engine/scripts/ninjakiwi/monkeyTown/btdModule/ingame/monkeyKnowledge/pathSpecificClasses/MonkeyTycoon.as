package ninjakiwi.monkeyTown.btdModule.ingame.monkeyKnowledge.pathSpecificClasses
{
   import ninjakiwi.monkeyTown.btdModule.ingame.monkeyKnowledge.BuffManager;
   import ninjakiwi.monkeyTown.btdModule.ingame.monkeyKnowledge.buffMethodModules.AreaDiscountAdd;
   import ninjakiwi.monkeyTown.btdModule.ingame.monkeyKnowledge.buffMethodModules.BananaCashScale;
   import ninjakiwi.monkeyTown.btdModule.ingame.monkeyKnowledge.buffMethodModules.BaseTowersCostScale;
   import ninjakiwi.monkeyTown.btdModule.ingame.monkeyKnowledge.buffMethodModules.TowerSellRefundPercentSet;
   import ninjakiwi.monkeyTown.btdModule.ingame.monkeyKnowledge.buffMethodModules.UpgradesCostScale;
   
   public class MonkeyTycoon
   {
      
      public static const instance:MonkeyTycoon = new MonkeyTycoon();
      
      private static const MONKEY_TYCOON_ID:String = "MonkeyTycoon";
       
      
      public function MonkeyTycoon()
      {
         super();
      }
      
      public function activateBuffs() : void
      {
         BuffManager.instance.activateBuffsOfMethodInPath(BananaCashScale,MONKEY_TYCOON_ID);
         BuffManager.instance.activateBuffsOfMethodInPath(TowerSellRefundPercentSet,MONKEY_TYCOON_ID);
         BuffManager.instance.activateBuffsOfMethodInPath(BaseTowersCostScale,MONKEY_TYCOON_ID);
         BuffManager.instance.activateBuffsOfMethodInPath(UpgradesCostScale,MONKEY_TYCOON_ID);
         BuffManager.instance.activateBuffsOfMethodInPath(AreaDiscountAdd,MONKEY_TYCOON_ID);
      }
   }
}

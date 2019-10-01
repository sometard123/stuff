package ninjakiwi.monkeyTown.btdModule.ingame.monkeyKnowledge.buffMethodModules
{
   import ninjakiwi.monkeyTown.btdModule.ingame.monkeyKnowledge.Buff;
   
   public class TowerSellRefundPercentSet implements IBuffMethodModule
   {
       
      
      public function TowerSellRefundPercentSet()
      {
         super();
      }
      
      public function invoke(param1:Buff) : void
      {
         if(Main.instance.game.inGameMenu.sellScale < param1.buffValue)
         {
            Main.instance.game.inGameMenu.sellScale = param1.buffValue;
         }
      }
   }
}

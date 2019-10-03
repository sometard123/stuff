package ninjakiwi.monkeyTown.btdModule.abilities
{
   import flash.events.Event;
   import ninjakiwi.monkeyTown.btdModule.towers.Tower;
   import ninjakiwi.monkeyTown.btdModule.towers.upgrades.UpgradeDef;
   import ninjakiwi.monkeyTown.btdModule.utils.GameSpeedTimer;
   
   public class TempUpgradeInstance
   {
       
      
      public var tower:Tower = null;
      
      private var timer:GameSpeedTimer = null;
      
      private var upgrade:UpgradeDef;
      
      public function TempUpgradeInstance(param1:Tower, param2:UpgradeDef, param3:Number)
      {
         super();
         this.tower = param1;
         this.upgrade = param2;
         param1.addUpgrade(param2);
         this.timer = new GameSpeedTimer(param3);
         this.timer.addEventListener(GameSpeedTimer.COMPLETE,this.timeUp);
      }
      
      public function timeUp(param1:Event) : void
      {
         this.tower.removeUpgrade(this.upgrade);
      }
   }
}

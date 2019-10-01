package ninjakiwi.monkeyTown.btdModule.events
{
   import flash.events.Event;
   import ninjakiwi.monkeyTown.btdModule.bloons.Bloon;
   import ninjakiwi.monkeyTown.btdModule.towers.Tower;
   
   public class BloonEvent extends Event
   {
      
      public static const POP:String = "pop";
      
      public static const PRE_DEGRADE:String = "predegrade";
      
      public static const REMOVE:String = "remove";
      
      public static const ADD:String = "add";
      
      public static const ATTACK:String = "attack";
      
      public static const DAMAGE:String = "damage";
      
      public static const DAMAGE_SHIELD:String = "damage_shield";
      
      public static const BOSS_DESTROYED:String = "boss_destroyed";
       
      
      public var tower:Tower = null;
      
      public var bloon:Bloon;
      
      public var layers:int = 1;
      
      public var moneyEarned:int = 0;
      
      public function BloonEvent(param1:String, param2:Bloon, param3:int = 1, param4:int = 0, param5:Tower = null)
      {
         super(param1);
         this.bloon = param2;
         this.layers = param3;
         this.moneyEarned = param4;
         this.tower = param5;
      }
   }
}

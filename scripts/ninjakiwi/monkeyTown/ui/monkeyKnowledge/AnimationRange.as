package ninjakiwi.monkeyTown.ui.monkeyKnowledge
{
   import flash.events.MouseEvent;
   import flash.utils.getTimer;
   import ninjakiwi.monkeyTown.pvp.PvPSignals;
   import ninjakiwi.monkeyTown.town.ui.TownUI;
   import ninjakiwi.monkeyTown.town.ui.helpFromFriends.FriendCrateInfoBox;
   
   public class AnimationRange
   {
       
      
      public var low:int;
      
      public var high:int;
      
      public var key:String;
      
      public function AnimationRange(param1:int = 0, param2:int = 0, param3:String = "default")
      {
         super();
         this.low = param1;
         this.high = param2;
         this.key = param3;
      }
      
      public function valueIsInRange(param1:Number) : Boolean
      {
         return param1 >= this.low && param1 <= this.high;
      }
      
      public function getRandomKey() : String
      {
         var _loc1_:int = this.high - this.low + 1;
         return this.key + (this.low + int(Math.random() * _loc1_));
      }
   }
}

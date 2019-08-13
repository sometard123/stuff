package ninjakiwi.monkeyTown.town.quests.task
{
   import ninjakiwi.monkeyTown.common.btdModule.definitions.BloonWeightsDefinition;
   import ninjakiwi.monkeyTown.display.tileSystem.Tile;
   import ninjakiwi.monkeyTown.system.MonkeySystem;
   import ninjakiwi.monkeyTown.town.bmcEvents.GameSignals;
   import ninjakiwi.monkeyTown.town.townMap.TownMap;
   import ninjakiwi.monkeyTown.town.townMap.bloonPredictor.BloonPredictor;
   import ninjakiwi.monkeyTown.utils.ErrorReporter;
   
   public class QuestCapture extends Quest
   {
       
      
      protected var _capturedCount:int = 1;
      
      protected var _strongestIDList:Vector.<String> = null;
      
      public function QuestCapture(param1:int = 1, param2:Vector.<String> = null)
      {
         super();
         this._capturedCount = param1;
         this._strongestIDList = param2;
         symbolFrame = 9;
         AchieveSignal(GameSignals.TILE_CAPTURED_SIGNAL);
      }
      
      override public function checkPreAchieved() : Boolean
      {
         if(this.checkCount(MonkeySystem.getInstance().map))
         {
            return true;
         }
         return super.checkPreAchieved();
      }
      
      override protected function checkAchieveConditions(... rest) : void
      {
         var _loc2_:TownMap = null;
         var _loc3_:Tile = null;
         if(rest != null && rest.length > 1 && rest[1] != null)
         {
            _loc2_ = TownMap(rest[1]);
         }
         if(_loc2_ == null)
         {
            ErrorReporter.error("QuestCapture::checkAchieveConditions - map cannot be null");
         }
         if(rest != null && rest.length > 0 && rest[0] != null)
         {
            _loc3_ = Tile(rest[0]);
         }
         if(this.checkCount(_loc2_,_loc3_))
         {
            achieved();
         }
      }
      
      protected function checkCount(param1:TownMap, param2:Tile = null) : Boolean
      {
         var _loc3_:int = 0;
         var _loc4_:BloonWeightsDefinition = null;
         var _loc5_:int = 0;
         if(param1 != null && param1.totalCapturedCount() >= this._capturedCount)
         {
            if(this._strongestIDList == null)
            {
               return true;
            }
            if(param2 != null && !param2.isUnderPvPAttack)
            {
               _loc3_ = param1.getDifficultyAtLocationPoint(param2.positionTilespace);
               _loc4_ = BloonPredictor.getWeightsDefinition(_loc3_,true,param2.variantHint);
               _loc5_ = 0;
               while(_loc5_ < this._strongestIDList.length)
               {
                  if(_loc4_ != null && this._strongestIDList[_loc5_] == _loc4_.strongestBloonType)
                  {
                     return true;
                  }
                  _loc5_++;
               }
            }
         }
         return false;
      }
   }
}

package ninjakiwi.monkeyTown.btdModule.specialTrack.tracks
{
   import ninjakiwi.monkeyTown.common.Constants;
   import ninjakiwi.monkeyTown.common.btdModule.definitions.BTDGameRequest;
   
   public class SpecialTrack
   {
       
      
      public function SpecialTrack()
      {
         super();
      }
      
      public function setSpecialTrack(param1:BTDGameRequest) : void
      {
         var _loc3_:* = null;
         param1.Difficulty(Constants.MINIMUM_SPECIAL_MISSION_DIFFICULTY);
         param1.isCamoTile = false;
         param1.isRegenTile = false;
         var _loc2_:Object = param1.availableTowers;
         if(_loc2_ != null)
         {
            for(_loc3_ in _loc2_)
            {
               _loc2_[_loc3_].allowed = true;
               _loc2_[_loc3_].costModifier = 1;
            }
         }
      }
      
      public function applySpecialTrack(param1:BTDGameRequest) : void
      {
      }
      
      public function clearSpecialTrack() : void
      {
      }
      
      public function update(param1:Number) : void
      {
      }
   }
}

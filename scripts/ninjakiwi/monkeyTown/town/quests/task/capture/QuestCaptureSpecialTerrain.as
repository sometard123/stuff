package ninjakiwi.monkeyTown.town.quests.task.capture
{
   import ninjakiwi.monkeyTown.display.tileSystem.Tile;
   import ninjakiwi.monkeyTown.town.bmcEvents.GameSignals;
   import ninjakiwi.monkeyTown.town.data.definitions.FirstTimeTriggerDefinition;
   import ninjakiwi.monkeyTown.town.quests.task.QuestCapture;
   import ninjakiwi.monkeyTown.town.tile.TileDefinitions;
   import ninjakiwi.monkeyTown.utils.ErrorReporter;
   
   public class QuestCaptureSpecialTerrain extends QuestCapture
   {
       
      
      private var _specialTerrainID:String = null;
      
      public function QuestCaptureSpecialTerrain(param1:String = null)
      {
         super();
         this._specialTerrainID = param1;
      }
      
      override public function checkPreAchieved() : Boolean
      {
         return false;
      }
      
      override protected function checkAchieveConditions(... rest) : void
      {
         var _loc2_:Tile = null;
         if(rest != null && rest.length > 0 && rest[0] != null)
         {
            _loc2_ = Tile(rest[0]);
         }
         if(_loc2_ == null)
         {
            ErrorReporter.error("QuestCaptureSpecialTerrain::checkAchieveConditions - tile cannot be null");
         }
         if(_loc2_.terrainSpecialProperty != null)
         {
            if(TileDefinitions.getInstance().isSpecialTerrain(_loc2_))
            {
               if(this._specialTerrainID == null || _loc2_.terrainSpecialProperty.id == this._specialTerrainID)
               {
                  super.checkAchieveConditions(rest[0],rest[1]);
               }
            }
         }
      }
   }
}

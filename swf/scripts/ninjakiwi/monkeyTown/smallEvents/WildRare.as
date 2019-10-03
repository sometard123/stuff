package ninjakiwi.monkeyTown.smallEvents
{
   import assets.ui.DefendPanelClip;
   import flash.display.DisplayObjectContainer;
   import ninjakiwi.monkeyTown.data.ResourceStore;
   import ninjakiwi.monkeyTown.pvp.PvPSignals;
   import ninjakiwi.monkeyTown.town.quests.QuestCounter;
   import ninjakiwi.monkeyTown.town.ui.TerrainDetail;
   import ninjakiwi.monkeyTown.town.ui.attack.crates.CratesTickBoxes;
   import ninjakiwi.monkeyTown.town.ui.avatar.AvatarModule;
   import ninjakiwi.monkeyTown.town.ui.terrain.TerrainRestrictionModule;
   import ninjakiwi.monkeyTown.ui.buttons.TickBox;
   
   public class WildRare extends ModifierBase
   {
       
      
      public function WildRare()
      {
         super();
      }
      
      override public function get typeID() : String
      {
         return "wildRare";
      }
   }
}

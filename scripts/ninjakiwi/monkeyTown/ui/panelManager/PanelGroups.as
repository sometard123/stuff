package ninjakiwi.monkeyTown.ui.panelManager
{
   import flash.utils.Dictionary;
   
   public class PanelGroups
   {
      
      public static const GROUP_1:String = "group_1";
      
      public static const QUESTS:String = "quests";
      
      public static const LEVEL_UP_PANELS:String = "levelUpPanels";
      
      public static const CONTESTED_TERRITORY:String = "contestedTerritory";
       
      
      public function PanelGroups()
      {
         super();
      }
      
      public static function configureGroups(param1:PanelManager) : void
      {
         param1.configurePanelGroup(LEVEL_UP_PANELS,-11);
         param1.configurePanelGroup(QUESTS,-10);
         param1.configurePanelGroup(CONTESTED_TERRITORY,-9.5);
         param1.configurePanelGroup(GROUP_1,1);
      }
   }
}

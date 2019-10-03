package ninjakiwi.monkeyTown.btdModule.ingame.ingamestate
{
   import ninjakiwi.monkeyTown.btdModule.ingame.InGameMenu;
   import ninjakiwi.monkeyTown.btdModule.state.Message;
   import ninjakiwi.monkeyTown.btdModule.state.State;
   
   public class TowerNotSelectedState extends InGameMenuState
   {
       
      
      public function TowerNotSelectedState(param1:InGameMenu)
      {
         super(param1);
      }
      
      override public function enter(param1:Message) : void
      {
      }
      
      override public function message(param1:Message) : State
      {
         var _loc2_:GameStateMessage = GameStateMessage(param1);
         if(_loc2_.tower != null)
         {
            return inGameMenu.towerSelectedState;
         }
         return null;
      }
      
      override public function exit() : void
      {
      }
   }
}

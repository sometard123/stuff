package ninjakiwi.monkeyTown.btdModule.ingame.ingamestate
{
   import ninjakiwi.monkeyTown.btdModule.ingame.InGameMenu;
   import ninjakiwi.monkeyTown.btdModule.state.State;
   
   public class InGameMenuState extends State
   {
       
      
      protected var inGameMenu:InGameMenu;
      
      public function InGameMenuState(param1:InGameMenu)
      {
         super();
         this.inGameMenu = param1;
      }
   }
}

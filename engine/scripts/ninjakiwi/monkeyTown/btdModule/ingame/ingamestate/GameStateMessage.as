package ninjakiwi.monkeyTown.btdModule.ingame.ingamestate
{
   import ninjakiwi.monkeyTown.btdModule.ingame.TowerPickerDef;
   import ninjakiwi.monkeyTown.btdModule.state.Message;
   import ninjakiwi.monkeyTown.btdModule.towers.Tower;
   
   public class GameStateMessage extends Message
   {
      
      public static const CANCEL_MSG:uint = 0;
      
      public static const TOWERSELECTED_MSG:uint = 2;
      
      public static const TOWERNOTSELECTED_MSG:uint = 3;
      
      public static const TOWERPLACED_MSG:uint = 4;
      
      public static const TOWERPLACING_MSG:uint = 5;
       
      
      public var type:uint = 0;
      
      public var towerPickerDef:TowerPickerDef = null;
      
      public var tower:Tower = null;
      
      public var endOfRound:Boolean = false;
      
      public function GameStateMessage(param1:uint)
      {
         super();
         this.type = param1;
      }
   }
}

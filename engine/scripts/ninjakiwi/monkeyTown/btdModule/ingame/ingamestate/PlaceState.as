package ninjakiwi.monkeyTown.btdModule.ingame.ingamestate
{
   import ninjakiwi.monkeyTown.btdModule.game.Game;
   import ninjakiwi.monkeyTown.btdModule.ingame.InGameMenu;
   import ninjakiwi.monkeyTown.btdModule.ingame.TowerPickerDef;
   import ninjakiwi.monkeyTown.btdModule.state.Message;
   import ninjakiwi.monkeyTown.btdModule.state.State;
   import ninjakiwi.monkeyTown.btdModule.towers.TowerAvailabilityManager;
   import ninjakiwi.monkeyTown.btdModule.towers.TowerPlace;
   import ninjakiwi.monkeyTown.btdModule.utils.Pool;
   import ninjakiwi.monkeyTown.common.Constants;
   
   public class PlaceState extends InGameMenuState
   {
       
      
      private var towerPlace:TowerPlace = null;
      
      private var pickerDef:TowerPickerDef = null;
      
      public var gamea:Game;
      
      public function PlaceState(param1:InGameMenu)
      {
         this.gamea = Main.instance.game;
         super(param1);
      }
      
      override public function enter(param1:Message) : void
      {
         this.towerPlace = Pool.get(TowerPlace);
         this.towerPlace.initialise(GameStateMessage(param1).towerPickerDef.tower,GameStateMessage(param1).towerPickerDef);
         this.pickerDef = GameStateMessage(param1).towerPickerDef;
         this.gamea.level.addEntity(this.towerPlace);
         if(inGameMenu.goButton.isCancelEnabled)
         {
            inGameMenu.mc.cancel_btn.visible = true;
         }
      }
      
      override public function message(param1:Message) : State
      {
         var _loc2_:* = false;
         var _loc3_:GameStateMessage = null;
         if(GameStateMessage(param1).type == GameStateMessage.TOWERPLACED_MSG)
         {
            this.towerPlace = null;
            machine.changeState(inGameMenu.neutral,param1);
            if(GameStateMessage(param1).tower.def != null && inGameMenu.canSelect(GameStateMessage(param1).tower.def))
            {
               _loc3_ = new GameStateMessage(GameStateMessage.TOWERSELECTED_MSG);
               _loc3_.tower = GameStateMessage(param1).tower;
               machine.message(_loc3_);
            }
            _loc2_ = TowerAvailabilityManager.instance.getNumberOfAvailableTowers(this.pickerDef.tower.id) > 1;
            if(_loc2_ && (inGameMenu.shiftDown || this.pickerDef.tower.id == Constants.TOWER_ROADSPIKE || this.pickerDef.tower.id == Constants.TOWER_PINEAPPLE) || this.pickerDef.tower.id == Constants.TOWER_REDHOTSPIKES)
            {
               if(this.gamea.level.cash.value >= this.pickerDef.cost)
               {
                  inGameMenu.beginPlacingTower(this.pickerDef);
               }
            }
         }
         else
         {
            if(GameStateMessage(param1).type == GameStateMessage.TOWERPLACING_MSG)
            {
               return inGameMenu.placingState;
            }
            if(GameStateMessage(param1).type == GameStateMessage.CANCEL_MSG)
            {
               return inGameMenu.neutral;
            }
         }
         return null;
      }
      
      override public function exit() : void
      {
         if(this.towerPlace != null)
         {
            this.towerPlace.destroy();
            inGameMenu.cancelPlace();
            this.towerPlace = null;
         }
         inGameMenu.mc.cancel_btn.visible = false;
      }
   }
}

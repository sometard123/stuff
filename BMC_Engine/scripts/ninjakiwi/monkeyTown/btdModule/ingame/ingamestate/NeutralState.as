package ninjakiwi.monkeyTown.btdModule.ingame.ingamestate
{
   import assets.effects.Select;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   import ninjakiwi.monkeyTown.btdModule.game.Game;
   import ninjakiwi.monkeyTown.btdModule.ingame.InGameMenu;
   import ninjakiwi.monkeyTown.btdModule.state.Machine;
   import ninjakiwi.monkeyTown.btdModule.state.Message;
   import ninjakiwi.monkeyTown.btdModule.state.State;
   import ninjakiwi.monkeyTown.btdModule.towers.Tower;
   
   public class NeutralState extends InGameMenuState
   {
       
      
      private var minTower:Tower = null;
      
      private var selectEffect:MovieClip;
      
      public var childState:Machine;
      
      public var gamea:Game;
      
      public function NeutralState(param1:InGameMenu)
      {
         this.selectEffect = new Select();
         this.childState = new Machine();
         this.gamea = Main.instance.game;
         this.childState.changeState(param1.towerNotSelectedState,null);
         super(param1);
      }
      
      override public function enter(param1:Message) : void
      {
         if(param1 == null)
         {
            inGameMenu.mc.uiPanels.towerSelected.visible = false;
            inGameMenu.mc.uiPanels.specialAgentPanel.visible = true;
         }
         Main.instance.stage.addEventListener(MouseEvent.MOUSE_MOVE,this.hover);
         Main.instance.stage.addEventListener(MouseEvent.MOUSE_DOWN,this.click);
         Main.instance.stage.addEventListener(MouseEvent.MOUSE_UP,this.up);
      }
      
      override public function message(param1:Message) : State
      {
         if(GameStateMessage(param1).type == GameStateMessage.TOWERPLACING_MSG)
         {
            return inGameMenu.placingState;
         }
         this.childState.message(param1);
         return null;
      }
      
      override public function exit() : void
      {
         Main.instance.stage.removeEventListener(MouseEvent.MOUSE_MOVE,this.hover);
         Main.instance.stage.removeEventListener(MouseEvent.MOUSE_DOWN,this.click);
         Main.instance.stage.removeEventListener(MouseEvent.MOUSE_UP,this.up);
         if(this.minTower != null)
         {
            inGameMenu.towerHilight.setTower(null);
         }
      }
      
      public function up(param1:MouseEvent) : void
      {
      }
      
      public function click(param1:MouseEvent) : void
      {
         var _loc2_:GameStateMessage = null;
         if(inGameMenu.inPlayArea() == true)
         {
            if(inGameMenu.placingReticle)
            {
               inGameMenu.placeReticle();
            }
            else if(this.minTower != null)
            {
               _loc2_ = new GameStateMessage(GameStateMessage.TOWERSELECTED_MSG);
               _loc2_.tower = this.minTower;
               this.childState.message(_loc2_);
            }
            else
            {
               this.childState.message(new GameStateMessage(GameStateMessage.TOWERNOTSELECTED_MSG));
            }
         }
         else if(inGameMenu.inBottomUIArea() == false && inGameMenu.inRightUIArea() == false)
         {
            this.childState.message(new GameStateMessage(GameStateMessage.TOWERNOTSELECTED_MSG));
         }
      }
      
      public function hover(param1:MouseEvent) : void
      {
         var _loc4_:Tower = null;
         var _loc5_:Number = NaN;
         if(inGameMenu.inPlayArea() == false)
         {
            return;
         }
         if(this.minTower)
         {
            inGameMenu.towerHilight.setTower(null);
         }
         var _loc2_:MovieClip = Main.instance;
         var _loc3_:Number = 9999999;
         for each(_loc4_ in this.gamea.level.allTowers)
         {
            if(!(inGameMenu.towerSelectedState.tower == _loc4_ && inGameMenu.towerSelectedState.tower.def && inGameMenu.towerSelectedState.tower.def.isPlatform))
            {
               _loc5_ = Math.sqrt((_loc2_.mouseX - _loc4_.x) * (_loc2_.mouseX - _loc4_.x) + (_loc2_.mouseY - _loc4_.y) * (_loc2_.mouseY - _loc4_.y));
               if(_loc5_ < _loc3_)
               {
                  _loc3_ = _loc5_;
                  this.minTower = _loc4_;
               }
            }
         }
         if(_loc3_ < 50)
         {
            inGameMenu.towerHilight.setTower(this.minTower);
         }
         else
         {
            this.minTower = null;
         }
      }
   }
}

package ninjakiwi.monkeyTown.town.gameEvents.bloonBeacon.ui
{
   import assets.ui.BloonBeaconVictoryPanelBossClip;
   import flash.display.DisplayObjectContainer;
   import flash.display.MovieClip;
   import ninjakiwi.monkeyTown.town.gameEvents.GameEventManager;
   import ninjakiwi.monkeyTown.town.gameEvents.GameplayEvent;
   import ninjakiwi.monkeyTown.town.ui.TownUI;
   import ninjakiwi.monkeyTown.ui.HideRevealView;
   import ninjakiwi.monkeyTown.ui.buttons.ButtonControllerBase;
   import ninjakiwi.monkeyTown.ui.panelManager.PanelManager;
   
   public class BloonBeaconVictoryPanelBoss extends HideRevealView
   {
       
      
      private var _clip:BloonBeaconVictoryPanelBossClip;
      
      private var _closeButton:ButtonControllerBase;
      
      private var _fightBossButton:ButtonControllerBase;
      
      private var _bossIcon:MovieClip;
      
      public function BloonBeaconVictoryPanelBoss(param1:DisplayObjectContainer)
      {
         this._clip = new BloonBeaconVictoryPanelBossClip();
         this._closeButton = new ButtonControllerBase(this._clip.closeButton);
         this._fightBossButton = new ButtonControllerBase(this._clip.fightButton);
         this._bossIcon = this._clip.bossIcon;
         this._closeButton.setClickFunction(this.onClose);
         this._fightBossButton.setClickFunction(this.onFightBossButton);
         super(param1);
         addChild(this._clip);
      }
      
      override public function reveal(param1:Number = 0.2) : void
      {
         var _loc2_:Boolean = GameEventManager.getInstance().bossEventManager.bossIsActive;
         if(false == _loc2_)
         {
            return;
         }
         var _loc3_:GameplayEvent = GameEventManager.getInstance().bossEventManager.findCurrentEvent();
         switch(_loc3_.dataID)
         {
            default:
            case "bloonarius":
               this._bossIcon.gotoAndStop(1);
               break;
            case "vortex":
               this._bossIcon.gotoAndStop(2);
               break;
            case "dreadbloon":
               this._bossIcon.gotoAndStop(3);
               break;
            case "blastapopoulos":
               this._bossIcon.gotoAndStop(4);
         }
         super.reveal(param1);
      }
      
      private function onClose(... rest) : void
      {
         hide();
      }
      
      private function onFightBossButton(... rest) : void
      {
         hide();
         var _loc2_:Boolean = GameEventManager.getInstance().bossEventManager.bossIsActive;
         if(_loc2_)
         {
            PanelManager.getInstance().showFreePanel(TownUI.getInstance().bossBattleAttackPanel);
         }
      }
   }
}

package ninjakiwi.monkeyTown.town.ui
{
   import assets.ui.TerrainInfoPanelClip;
   import com.greensock.TweenLite;
   import flash.display.DisplayObjectContainer;
   import flash.display.Sprite;
   import flash.display.Stage;
   import flash.events.MouseEvent;
   import ninjakiwi.monkeyTown.display.tileSystem.Tile;
   import ninjakiwi.monkeyTown.system.MonkeySystem;
   import ninjakiwi.monkeyTown.town.monkeyCityMain.WorldView;
   import ninjakiwi.monkeyTown.town.specialMissions.SpecialMissionsManager;
   import ninjakiwi.monkeyTown.town.townMap.TownMap;
   import ninjakiwi.monkeyTown.ui.HideRevealViewPopup;
   import ninjakiwi.monkeyTown.ui.buttons.ButtonControllerBase;
   
   public class TerrainInfoPanel extends HideRevealViewPopup
   {
       
      
      private const _clip:TerrainInfoPanelClip = new TerrainInfoPanelClip();
      
      private const _details:TerrainDetail = new TerrainDetail(this._clip.detailPosition,TerrainDetail.TERRAIN_INFO | TerrainDetail.DIFFICULTY | TerrainDetail.ASSAULT);
      
      private const _closeButton:ButtonControllerBase = new ButtonControllerBase(this._clip.closeButton);
      
      private const _flashStage:Stage = MonkeySystem.getInstance().flashStage;
      
      private var _worldView:WorldView;
      
      private const _timerObjct:Sprite = new Sprite();
      
      private var _hoveredTile:Tile = null;
      
      private var _reserveX:Number = 0;
      
      private var _reserveY:Number = 0;
      
      private var _hideWithFadeOut:Boolean = false;
      
      public function TerrainInfoPanel(param1:DisplayObjectContainer, param2:WorldView, param3:* = null)
      {
         super(param1,param3);
         this._worldView = param2;
         this.addChild(this._clip);
         this._clip.closeButton.visible = false;
         this._details.swapRow(TerrainDetail.DIFFICULTY,TerrainDetail.TERRAIN_INFO);
      }
      
      private function unSelect() : void
      {
         if(this._hoveredTile != null)
         {
            this._hoveredTile.unlockHover();
            this._hoveredTile.unhover();
         }
      }
      
      public function setDetails(param1:TownMap, param2:Tile) : void
      {
         if(SpecialMissionsManager.getInstance().findSpecialMission(param2) == null)
         {
            if(param2.hasTreasureChest)
            {
               this._clip.bg.gotoAndStop(2);
               this._clip.gotoAndStop(2);
            }
            else
            {
               this._clip.bg.gotoAndStop(1);
               this._clip.gotoAndStop(1);
            }
            this._details.setDifficultyVisible(true);
         }
         else
         {
            this._clip.bg.gotoAndStop(1);
            this._clip.gotoAndStop(3);
            this._details.setDifficultyVisible(false);
         }
         this.unSelect();
         var _loc3_:int = param2.x - this._worldView.camera.x;
         var _loc4_:int = param2.y - this._worldView.camera.y;
         if(this._flashStage != null)
         {
            if(_loc3_ < this._flashStage.stageWidth * 0.5)
            {
               this._clip.bg.scaleX = 1;
               this._clip.bg.x = 0;
               _containerWrapper.x = _loc3_ + this._clip.bg.width * 0.5 + 70;
            }
            else
            {
               this._clip.bg.scaleX = -1;
               this._clip.bg.x = this._clip.bg.width - 40;
               _containerWrapper.x = _loc3_ - this._clip.bg.width * 0.5 + 40;
            }
            if(_loc4_ < this._flashStage.stageHeight * 0.5)
            {
               this._clip.bg.scaleY = -1;
               this._clip.bg.y = this._clip.bg.height - 10;
               _containerWrapper.y = _loc4_ + this._clip.bg.height;
               if(param2.hasTreasureChest)
               {
                  _containerWrapper.y = _containerWrapper.y + -53;
               }
            }
            else
            {
               this._clip.bg.scaleY = 1;
               this._clip.bg.y = -3;
               _containerWrapper.y = _loc4_ + 40;
               if(param2.hasTreasureChest)
               {
                  _containerWrapper.y = _containerWrapper.y + -13;
               }
            }
         }
         this._reserveX = _containerWrapper.x;
         this._reserveY = _containerWrapper.y;
         param2.hover();
         param2.lockHover();
         this._hoveredTile = param2;
         this._details.setDetails(param2);
      }
      
      override public function reveal(param1:Number = 0.2) : void
      {
         _containerWrapper.addChild(this);
         _containerWrapper.alpha = 1;
         if(_system.flashStage.hasEventListener(MouseEvent.MOUSE_DOWN))
         {
            _system.flashStage.removeEventListener(MouseEvent.MOUSE_DOWN,this.onMouseDown);
         }
         _system.flashStage.addEventListener(MouseEvent.MOUSE_DOWN,this.onMouseDown);
         TweenLite.killTweensOf(this._timerObjct);
         TweenLite.to(this._timerObjct,3,{"onComplete":this.hideWithFadeOut});
         if(isRevealed)
         {
            TweenLite.killTweensOf(_containerWrapper);
            _containerWrapper.scaleX = 1;
            _containerWrapper.scaleY = 1;
            isRevealed = false;
         }
         super.reveal(param1);
         _containerWrapper.x = this._reserveX;
         _containerWrapper.y = this._reserveY;
      }
      
      private function onMouseDown(param1:MouseEvent) : void
      {
         this._hideWithFadeOut = false;
         this.hide();
      }
      
      private function hideWithFadeOut() : void
      {
         this._hideWithFadeOut = true;
         this.hide();
      }
      
      override public function hide(param1:Number = 0.2) : void
      {
         if(this.isRevealed)
         {
            this.unSelect();
            if(_system.flashStage.hasEventListener(MouseEvent.MOUSE_DOWN))
            {
               _system.flashStage.removeEventListener(MouseEvent.MOUSE_DOWN,this.onMouseDown);
            }
            super.hide(param1);
         }
      }
      
      override protected function hideAnimation(param1:Number, param2:Function) : void
      {
         if(this._hideWithFadeOut)
         {
            TweenLite.to(_containerWrapper,param1,{"alpha":0});
            TweenLite.delayedCall(param1,param2);
         }
         else
         {
            super.hideAnimation(param1,param2);
         }
      }
      
      override protected function onHideComplete() : void
      {
         if(isRevealed == false)
         {
            super.onHideComplete();
         }
         if(_containerWrapper.contains(this))
         {
            _containerWrapper.removeChild(this);
         }
      }
   }
}

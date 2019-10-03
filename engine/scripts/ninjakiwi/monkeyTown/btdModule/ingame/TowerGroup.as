package ninjakiwi.monkeyTown.btdModule.ingame
{
   import assets.towerBtns.TowerButtonAvailableText;
   import assets.towerBtns.TowerButtonDamagedText;
   import assets.towerBtns.TowerButtonFreeText;
   import display.ui.Button;
   import flash.display.MovieClip;
   import flash.events.Event;
   import flash.events.KeyboardEvent;
   import flash.events.MouseEvent;
   import ninjakiwi.monkeyTown.btdModule.events.LevelEvent;
   import ninjakiwi.monkeyTown.btdModule.levels.Level;
   import ninjakiwi.monkeyTown.btdModule.towers.TowerAvailabilityManager;
   import ninjakiwi.monkeyTown.btdModule.towers.TowerPlace;
   import ninjakiwi.monkeyTown.common.Constants;
   import ninjakiwi.monkeyTown.ui.buttons.ButtonControllerBase;
   import org.osflash.signals.Signal;
   
   public class TowerGroup
   {
       
      
      private var buttons:Vector.<Button>;
      
      private var container:MovieClip = null;
      
      private var parentMC:MovieClip = null;
      
      private var buttonsByTowerID:Object;
      
      private var upArrow:ButtonControllerBase;
      
      private var downArrow:ButtonControllerBase;
      
      private var displayButtonsFrom:int = 0;
      
      private const ICON_HEIGHT:int = 55;
      
      private var _towersInMenu:Vector.<TowerPickerDef>;
      
      private var _roadSpikeHolder:MovieClip;
      
      private var _pineappleHolder:MovieClip;
      
      private var _enable:Boolean = false;
      
      private var _isUpButtonLocked:Boolean = false;
      
      private var _isDownButtonLocked:Boolean = false;
      
      private const _initX:int = 5;
      
      private const DISPLAY_COUNT:int = 10;
      
      public function TowerGroup()
      {
         this.buttonsByTowerID = {};
         super();
      }
      
      public function init(param1:MovieClip, param2:MovieClip, param3:MovieClip) : void
      {
         this.parentMC = param1;
         this.container = new MovieClip();
         this.parentMC.addChild(this.container);
         this.parentMC.bloonMask.visible = false;
         this.container.x = this.parentMC.bloonMask.x;
         this.container.y = this.parentMC.bloonMask.y;
         this.upArrow = new ButtonControllerBase(this.parentMC.upBtn);
         this.downArrow = new ButtonControllerBase(this.parentMC.downBtn);
         this.upArrow.setClickFunction(this.onUpArrowClicked);
         this.downArrow.setClickFunction(this.onDownArrowClicked);
         this.parentMC.upBtn.valid = false;
         this.parentMC.downBtn.valid = false;
         param2.visible = false;
         param3.visible = false;
         this._roadSpikeHolder = param2;
         this._pineappleHolder = param3;
         TowerPlace.towerPlacedSignal.add(this.onTowerCountChanged);
         Level.towerSoldSignal.add(this.onTowerCountChanged);
      }
      
      private function onMouseWheelMoved(param1:MouseEvent) : void
      {
         var _loc2_:Number = param1.delta;
         if(_loc2_ > 0)
         {
            if(this.parentMC.upBtn.visible && this._isUpButtonLocked == false)
            {
               this.onUpArrowClicked();
            }
         }
         else if(_loc2_ < 0)
         {
            if(this.parentMC.downBtn.visible && this._isDownButtonLocked == false)
            {
               this.onDownArrowClicked();
            }
         }
      }
      
      private function onUpArrowClicked() : void
      {
         if(!this._enable)
         {
            return;
         }
         this.displayButtonsFrom = this.displayButtonsFrom - 2;
         if(this.displayButtonsFrom < 0)
         {
            this.displayButtonsFrom = 0;
         }
         this.checkArrowButtonsValidity();
         this.layoutButtons();
      }
      
      private function onDownArrowClicked() : void
      {
         if(!this._enable)
         {
            return;
         }
         this.displayButtonsFrom = this.displayButtonsFrom + 2;
         var _loc1_:int = this.getTowerDisplayRange();
         if(_loc1_ % 2 == 1)
         {
            _loc1_ = _loc1_ + 1;
         }
         if(this.displayButtonsFrom >= _loc1_ - this.DISPLAY_COUNT)
         {
            this.displayButtonsFrom = _loc1_ - this.DISPLAY_COUNT;
         }
         this.checkArrowButtonsValidity();
         this.layoutButtons();
      }
      
      private function getTowerDisplayRange() : int
      {
         var _loc1_:int = this._towersInMenu.length;
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         while(_loc3_ < this._towersInMenu.length)
         {
            if(this._towersInMenu[_loc3_].tower.id == Constants.TOWER_PINEAPPLE || this._towersInMenu[_loc3_].tower.id == Constants.TOWER_ROADSPIKE)
            {
               _loc2_++;
            }
            _loc3_++;
         }
         if(_loc2_ > 2)
         {
            _loc2_ = 2;
         }
         _loc1_ = _loc1_ - _loc2_;
         return _loc1_;
      }
      
      private function checkArrowButtonsValidity() : void
      {
         this.upArrow.unlock();
         this.downArrow.unlock();
         this._isUpButtonLocked = false;
         this._isDownButtonLocked = false;
         if(this.displayButtonsFrom <= 0)
         {
            this.upArrow.lock(3);
            this._isUpButtonLocked = true;
         }
         var _loc1_:int = this.getTowerDisplayRange();
         if(this.displayButtonsFrom >= _loc1_ - this.DISPLAY_COUNT)
         {
            this.downArrow.lock(3);
            this._isDownButtonLocked = true;
         }
      }
      
      public function startGame(param1:Vector.<TowerPickerDef>) : void
      {
         this._enable = true;
         Button.enbaleTootip = true;
         Main.instance.stage.addEventListener(KeyboardEvent.KEY_DOWN,this.keyDownEvent);
         Main.instance.game.level.addEventListener(LevelEvent.CASH_CHANGE,this.checkButtonValidity);
         this._towersInMenu = param1;
         this.initButtons();
         this.checkButtonValidity(null);
         Main.instance.stage.addEventListener(MouseEvent.MOUSE_WHEEL,this.onMouseWheelMoved);
      }
      
      public function endGame() : void
      {
         this._enable = false;
         Button.enbaleTootip = false;
      }
      
      public function continueGame() : void
      {
         this._enable = true;
         Button.enbaleTootip = true;
      }
      
      public function exitGame() : void
      {
         this.endGame();
         Main.instance.stage.removeEventListener(KeyboardEvent.KEY_DOWN,this.keyDownEvent);
         Main.instance.game.level.removeEventListener(LevelEvent.CASH_CHANGE,this.checkButtonValidity);
         Main.instance.stage.removeEventListener(MouseEvent.MOUSE_WHEEL,this.onMouseWheelMoved);
      }
      
      private function initButtons() : void
      {
         var _loc1_:MovieClip = null;
         var _loc2_:TowerPickerDef = null;
         var _loc4_:int = 0;
         var _loc5_:Button = null;
         var _loc6_:int = 0;
         var _loc7_:Signal = null;
         var _loc8_:String = null;
         this.buttons = new Vector.<Button>();
         this.buttonsByTowerID = {};
         var _loc3_:int = 0;
         while(_loc3_ < this._towersInMenu.length)
         {
            _loc2_ = this._towersInMenu[_loc3_];
            _loc4_ = this._towersInMenu.indexOf(_loc2_);
            _loc5_ = new _loc2_.button() as Button;
            _loc6_ = TowerAvailabilityManager.instance.getNumberOfDamagedTowers(_loc2_.tower.id);
            _loc1_ = MovieClip(_loc5_);
            _loc1_.allDamaged.visible = false;
            _loc1_.towersAvailableText = new TowerButtonAvailableText();
            if(_loc6_ > 0)
            {
               _loc1_.towersAvailableText = new TowerButtonDamagedText();
               if(TowerAvailabilityManager.instance.getNumberOfAvailableTowers(_loc2_.tower.id) <= 0)
               {
                  _loc1_.allDamaged.visible = true;
               }
            }
            _loc1_.towersAvailableText.field.text = _loc2_.towersAvailable;
            _loc1_.addChild(_loc1_.towersAvailableText);
            _loc1_.freeText = new TowerButtonFreeText();
            _loc1_.addChild(_loc1_.freeText);
            this.setFreeCount(_loc1_,TowerAvailabilityManager.instance.getNumberOfFreeTowers(_loc2_.tower.id));
            _loc1_.lock_mc.visible = false;
            _loc1_.favouredTick.visible = false;
            _loc7_ = TowerAvailabilityManager.instance.getAvailabilityChangeSignal(_loc2_.tower.id);
            _loc7_.remove(this.onTowerAvailabilityChangeSignal);
            _loc7_.add(this.onTowerAvailabilityChangeSignal);
            if(_loc2_.tower.id != Constants.TOWER_ROADSPIKE && _loc2_.tower.id != Constants.TOWER_PINEAPPLE)
            {
               this.buttons.push(_loc5_);
            }
            _loc5_.extra = {
               "towerPicker":_loc2_,
               "description":_loc2_.tower.description
            };
            _loc8_ = String.fromCharCode(_loc2_.hotKey).toUpperCase();
            _loc5_.tooltip = "<font color=\'#E0CDB6\' face=\'Oetztype\'>" + _loc2_.tower.label + "\n$" + _loc2_.cost + "</font>\n" + _loc2_.tower.description + "\nHotkey: " + _loc8_;
            if(_loc6_ > 0)
            {
               _loc5_.tooltip = _loc5_.tooltip + ("\n<font color=\'#F73600\'>Damaged: " + _loc6_ + "</font>");
            }
            _loc5_.click = this.towerButtonClickedHandler;
            this.buttonsByTowerID[_loc2_.tower.id] = _loc5_;
            _loc3_++;
         }
         this.layoutButtons();
         this.checkArrowButtonsValidity();
      }
      
      public function refreshToolTip(param1:TowerPickerDef) : void
      {
         var _loc3_:int = 0;
         var _loc2_:String = String.fromCharCode(param1.hotKey).toUpperCase();
         if(this.buttonsByTowerID[param1.tower.id] != null)
         {
            this.buttonsByTowerID[param1.tower.id].tooltip = "<font color=\'#E0CDB6\' face=\'Oetztype\'>" + param1.tower.label + "\n$" + param1.cost + "</font>\n" + param1.tower.description + "\nHotkey: " + _loc2_;
            _loc3_ = TowerAvailabilityManager.instance.getNumberOfDamagedTowers(param1.tower.id);
            if(_loc3_ > 0)
            {
               this.buttonsByTowerID[param1.tower.id].tooltip;
               "\n<font color=\'#F73600\'>Damaged: " + _loc3_ + "</font>";
            }
         }
      }
      
      private function layoutButtons() : void
      {
         var _loc3_:MovieClip = null;
         while(this.container.numChildren > 0)
         {
            this.container.removeChildAt(0);
         }
         var _loc1_:Number = this.ICON_HEIGHT - 1.3;
         var _loc2_:int = 50;
         var _loc4_:int = this.buttons.length;
         if(_loc4_ > this.DISPLAY_COUNT)
         {
            _loc4_ = this.DISPLAY_COUNT;
         }
         var _loc5_:int = 0;
         while(_loc5_ < _loc4_)
         {
            if(_loc5_ + this.displayButtonsFrom < this.buttons.length)
            {
               _loc3_ = this.buttons[_loc5_ + this.displayButtonsFrom];
               if(_loc3_.extra.towerPicker.tower.id == Constants.TOWER_ROADSPIKE)
               {
                  _loc3_.x = this._initX;
                  _loc3_.y = this._roadSpikeHolder.y;
                  this.container.addChild(_loc3_);
               }
               else if(_loc3_.extra.towerPicker.tower.id == Constants.TOWER_PINEAPPLE)
               {
                  _loc3_.x = this._initX + _loc2_;
                  _loc3_.y = this._pineappleHolder.y;
                  this.container.addChild(_loc3_);
               }
               else
               {
                  _loc3_.y = int(_loc1_ * int(_loc5_ * 0.5) + 7);
                  _loc3_.x = this._initX;
                  if(_loc5_ % 2 == 1)
                  {
                     _loc3_.x = _loc3_.x + _loc2_;
                  }
                  this.container.addChild(_loc3_);
               }
            }
            _loc5_++;
         }
         if(this.buttons.length <= this.DISPLAY_COUNT)
         {
            this.deactivateArrowButtons();
         }
         else
         {
            this.activateArrowButtons();
         }
         if(this.buttonsByTowerID[Constants.TOWER_ROADSPIKE] != null)
         {
            _loc3_ = this.buttonsByTowerID[Constants.TOWER_ROADSPIKE];
            _loc3_.x = this._initX;
            _loc3_.y = this._roadSpikeHolder.y;
            this.container.addChild(_loc3_);
         }
         if(this.buttonsByTowerID[Constants.TOWER_PINEAPPLE] != null)
         {
            _loc3_ = this.buttonsByTowerID[Constants.TOWER_PINEAPPLE];
            _loc3_.x = this._initX + _loc2_;
            _loc3_.y = this._pineappleHolder.y;
            this.container.addChild(_loc3_);
         }
         this.checkButtonValidity();
      }
      
      private function activateArrowButtons() : void
      {
         this.parentMC.upBtn.visible = true;
         this.parentMC.downBtn.visible = true;
      }
      
      private function deactivateArrowButtons() : void
      {
         this.parentMC.upBtn.visible = false;
         this.parentMC.downBtn.visible = false;
      }
      
      private function onTowerAvailabilityChangeSignal(param1:String, param2:int, param3:int) : void
      {
         var _loc4_:MovieClip = MovieClip(this.buttonsByTowerID[param1]);
         if(_loc4_ === null)
         {
            return;
         }
         _loc4_.towersAvailableText.field.text = param2;
         this.setFreeCount(_loc4_,param3);
      }
      
      private function setFreeCount(param1:MovieClip, param2:int) : void
      {
         if(param1 == null)
         {
            return;
         }
         if(param2 > 0)
         {
            param1.freeText.field.text = param2;
            param1.freeText.visible = true;
         }
         else
         {
            param1.freeText.visible = false;
         }
      }
      
      private function towerButtonClickedHandler(param1:MouseEvent) : void
      {
         Main.instance.game.inGameMenu.beginPlacingTower((param1.target as Button).extra.towerPicker);
      }
      
      private function onTowerCountChanged(... rest) : void
      {
         this.checkButtonValidity();
      }
      
      public function getButtonByTowerID(param1:String) : Button
      {
         if(this.buttonsByTowerID[param1] != null)
         {
            return Button(this.buttonsByTowerID[param1]);
         }
         return null;
      }
      
      private function checkButtonValidity(param1:Event = null) : void
      {
         var _loc2_:* = null;
         var _loc3_:Button = null;
         var _loc4_:TowerPickerDef = null;
         var _loc5_:int = 0;
         for(_loc2_ in this.buttonsByTowerID)
         {
            _loc3_ = this.buttonsByTowerID[_loc2_];
            _loc4_ = _loc3_.extra.towerPicker as TowerPickerDef;
            _loc5_ = TowerAvailabilityManager.instance.getNumberOfFreeTowers(_loc4_.tower.id);
            if(Main.instance.game.level.cash.value < _loc4_.cost && _loc5_ <= 0 || TowerAvailabilityManager.instance.getNumberOfAvailableTowers(_loc4_.tower.id) <= 0)
            {
               _loc3_.valid = false;
            }
            else
            {
               _loc3_.valid = true;
            }
         }
      }
      
      public function syncTowerCounts() : void
      {
         var _loc1_:int = 0;
         while(_loc1_ < this.buttons.length)
         {
            MovieClip(this.buttons[_loc1_]).towersAvailableText.field.text = (this.buttons[_loc1_].extra.towerPicker as TowerPickerDef).towersAvailable;
            _loc1_++;
         }
         if(this.buttonsByTowerID[Constants.TOWER_ROADSPIKE] != null)
         {
            MovieClip(this.buttonsByTowerID[Constants.TOWER_ROADSPIKE]).towersAvailableText.field.text = (this.buttonsByTowerID[Constants.TOWER_ROADSPIKE].extra.towerPicker as TowerPickerDef).towersAvailable;
         }
         if(this.buttonsByTowerID[Constants.TOWER_PINEAPPLE] != null)
         {
            MovieClip(this.buttonsByTowerID[Constants.TOWER_PINEAPPLE]).towersAvailableText.field.text = (this.buttonsByTowerID[Constants.TOWER_PINEAPPLE].extra.towerPicker as TowerPickerDef).towersAvailable;
         }
         this.checkButtonValidity();
      }
      
      public function reset() : void
      {
         this.displayButtonsFrom = 0;
         this.layoutButtons();
         this.checkArrowButtonsValidity();
      }
      
      private function keyDownEvent(param1:KeyboardEvent) : void
      {
         var _loc2_:* = null;
         var _loc3_:Button = null;
         var _loc4_:TowerPickerDef = null;
         for(_loc2_ in this.buttonsByTowerID)
         {
            _loc3_ = this.buttonsByTowerID[_loc2_];
            _loc4_ = _loc3_.extra.towerPicker as TowerPickerDef;
            if(_loc3_.valid == true && param1.keyCode == _loc4_.hotKey)
            {
               Main.instance.game.inGameMenu.beginPlacingTower(_loc4_);
               break;
            }
         }
      }
      
      public function set x(param1:Number) : void
      {
      }
   }
}

package ninjakiwi.monkeyTown.btdModule.ingame.ingamestate
{
   import assets.sounds.Select;
   import assets.sounds.Upgrade;
   import assets.towers.BananaInvestmentsAdvisory;
   import assets.towers.MoneyBank;
   import display.ui.Button;
   import flash.display.MovieClip;
   import flash.events.Event;
   import flash.events.KeyboardEvent;
   import flash.events.MouseEvent;
   import flash.utils.getQualifiedClassName;
   import ninjakiwi.monkeyTown.btdModule.entities.AceAircraft;
   import ninjakiwi.monkeyTown.btdModule.events.LevelEvent;
   import ninjakiwi.monkeyTown.btdModule.events.PropertyModEvent;
   import ninjakiwi.monkeyTown.btdModule.game.Game;
   import ninjakiwi.monkeyTown.btdModule.ingame.InGameMenu;
   import ninjakiwi.monkeyTown.btdModule.profile.Profile;
   import ninjakiwi.monkeyTown.btdModule.sound.MaxSound;
   import ninjakiwi.monkeyTown.btdModule.state.Message;
   import ninjakiwi.monkeyTown.btdModule.state.State;
   import ninjakiwi.monkeyTown.btdModule.towers.Tower;
   import ninjakiwi.monkeyTown.btdModule.towers.behavior.roundStart.BananaEmitter;
   import ninjakiwi.monkeyTown.btdModule.towers.behavior.roundStart.DeployMonkeyAce;
   import ninjakiwi.monkeyTown.btdModule.towers.def.TowerDef;
   import ninjakiwi.monkeyTown.btdModule.towers.upgrades.UpgradeAvailabilityManager;
   import ninjakiwi.monkeyTown.btdModule.towers.upgrades.UpgradeDef;
   import ninjakiwi.monkeyTown.btdModule.towers.upgrades.UpgradePathDef;
   import ninjakiwi.monkeyTown.common.bridges.UpgradesBridge;
   import ninjakiwi.monkeyTown.ui.buttons.ButtonControllerBase;
   
   public class TowerSelectedState extends InGameMenuState
   {
      
      public static var selectSound:MaxSound = new MaxSound(Select);
       
      
      public var tower:Tower = null;
      
      public var keyIsDown:Boolean = false;
      
      public var game:Game;
      
      public var userProfile:Profile;
      
      private var msg:Message = null;
      
      private var _useButton:ButtonControllerBase;
      
      public function TowerSelectedState(param1:InGameMenu)
      {
         this.game = Main.instance.game;
         this.userProfile = Main.instance.profile;
         super(param1);
         param1.mc.uiPanels.towerSelected.useButton.gotoAndStop(1);
      }
      
      public function updateTower(param1:Event) : void
      {
         var e:Event = param1;
         if(this.tower.def == null)
         {
            machine.changeState(inGameMenu.towerNotSelectedState,null);
            return;
         }
         try
         {
            if(getQualifiedClassName(inGameMenu.mc.uiPanels.towerSelected.holder_mc.getChildAt(0)) != getQualifiedClassName(this.tower.def.detailSmall))
            {
               while(inGameMenu.mc.uiPanels.towerSelected.holder_mc.numChildren > 0)
               {
                  inGameMenu.mc.uiPanels.towerSelected.holder_mc.removeChildAt(0);
               }
               if(this.tower.def.detailSmall != null)
               {
                  inGameMenu.mc.uiPanels.towerSelected.holder_mc.addChild(new this.tower.def.detailSmall());
               }
            }
         }
         catch(e:Error)
         {
         }
         inGameMenu.mc.uiPanels.towerSelected.pops.text = String(this.tower.popCount);
         if(inGameMenu.mc.uiPanels.towerSelected.sell.sellLabel != null)
         {
            inGameMenu.mc.uiPanels.towerSelected.sell.sellLabel.text = "SELL FOR $" + String(int(this.tower.spentOn * inGameMenu.sellScale));
            inGameMenu.mc.uiPanels.towerSelected.label.text = this.tower.def.label;
         }
         inGameMenu.range.initialise(this.tower.def);
         inGameMenu.range.x = this.tower.x;
         inGameMenu.range.y = this.tower.y;
         inGameMenu.extendedRange.x = this.tower.x;
         inGameMenu.extendedRange.y = this.tower.y;
         inGameMenu.mc.uiPanels.towerSelected.balance_mc.visible = false;
         if(this.tower.def.display == MoneyBank || this.tower.def.display == BananaInvestmentsAdvisory)
         {
            inGameMenu.mc.uiPanels.towerSelected.balance_mc.visible = true;
            inGameMenu.mc.uiPanels.towerSelected.balance_mc.balance_txt.text = "$" + String((this.tower.def.behavior.roundStart as BananaEmitter).getBankedFunds(this.tower));
            inGameMenu.mc.uiPanels.towerSelected.balance_mc.extra = {
               "emitter":this.tower.def.behavior.roundStart as BananaEmitter,
               "tower":this.tower
            };
            inGameMenu.mc.uiPanels.towerSelected.balance_mc.click = function(param1:Event):void
            {
               (param1.target as Button).extra.emitter.collect((param1.target as Button).extra.tower);
            };
         }
      }
      
      private function setTargetPriority(param1:int) : void
      {
         this.game.level.setTowerTargetPriority(this.tower,param1);
         this.updateTowerSelectedPanel();
      }
      
      private function setAceFlightPath(param1:int) : void
      {
         this.game.level.setAceFlightPath(this.tower,param1);
         this.updateTowerSelectedPanel();
      }
      
      private function updateTowerSelectedPanel() : void
      {
         var prio:int = 0;
         if(this.tower.def != null && this.tower.def.canPriorityTarget)
         {
            inGameMenu.mc.uiPanels.towerSelected.first.visible = true;
            inGameMenu.mc.uiPanels.towerSelected.last.visible = true;
            inGameMenu.mc.uiPanels.towerSelected.close.visible = true;
            inGameMenu.mc.uiPanels.towerSelected.strong.visible = true;
         }
         else
         {
            inGameMenu.mc.uiPanels.towerSelected.first.visible = false;
            inGameMenu.mc.uiPanels.towerSelected.last.visible = false;
            inGameMenu.mc.uiPanels.towerSelected.close.visible = false;
            inGameMenu.mc.uiPanels.towerSelected.strong.visible = false;
         }
         inGameMenu.mc.uiPanels.towerSelected.first.valid = true;
         inGameMenu.mc.uiPanels.towerSelected.last.valid = true;
         inGameMenu.mc.uiPanels.towerSelected.close.valid = true;
         inGameMenu.mc.uiPanels.towerSelected.strong.valid = true;
         inGameMenu.mc.uiPanels.towerSelected.popCountTitle.visible = true;
         inGameMenu.mc.uiPanels.towerSelected.pops.visible = true;
         inGameMenu.mc.uiPanels.towerSelected.coolDownTimerClip.visible = false;
         inGameMenu.mc.uiPanels.towerSelected.useButton.visible = false;
         if(this.tower != null)
         {
            if(!this.tower.resellable)
            {
               inGameMenu.mc.uiPanels.towerSelected.sell.visible = false;
            }
            else
            {
               inGameMenu.mc.uiPanels.towerSelected.sell.visible = true;
            }
            if(this.tower.directUseAbilityButton != null)
            {
               inGameMenu.mc.uiPanels.towerSelected.useButton.visible = true;
            }
            if(!this.tower.hasPopCount)
            {
               inGameMenu.mc.uiPanels.towerSelected.popCountTitle.visible = false;
               inGameMenu.mc.uiPanels.towerSelected.pops.visible = false;
            }
            if(this.tower.coolDownTimerGuage != null)
            {
               inGameMenu.mc.uiPanels.towerSelected.coolDownTimerClip.visible = true;
            }
         }
         switch(this.tower.targetPriority)
         {
            case Tower.TARGET_FIRST:
               inGameMenu.mc.uiPanels.towerSelected.first.valid = false;
               break;
            case Tower.TARGET_LAST:
               inGameMenu.mc.uiPanels.towerSelected.last.valid = false;
               break;
            case Tower.TARGET_CLOSE:
               inGameMenu.mc.uiPanels.towerSelected.close.valid = false;
               break;
            case Tower.TARGET_STRONG:
               inGameMenu.mc.uiPanels.towerSelected.strong.valid = false;
         }
         inGameMenu.mc.uiPanels.towerSelected.flightPaths.visible = false;
         if(this.tower.rootID == "MonkeyAce" && DeployMonkeyAce.aces[this.tower])
         {
            inGameMenu.mc.uiPanels.towerSelected.flightPaths.visible = true;
            inGameMenu.mc.uiPanels.towerSelected.flightPaths.vert_btn.valid = true;
            inGameMenu.mc.uiPanels.towerSelected.flightPaths.horiz_btn.valid = true;
            inGameMenu.mc.uiPanels.towerSelected.flightPaths.circle_btn.valid = true;
            prio = (DeployMonkeyAce.aces[this.tower] as AceAircraft).pathType;
            switch(prio)
            {
               case AceAircraft.VERTICAL:
                  inGameMenu.mc.uiPanels.towerSelected.flightPaths.vert_btn.valid = false;
                  break;
               case AceAircraft.HORIZONTAL:
                  inGameMenu.mc.uiPanels.towerSelected.flightPaths.horiz_btn.valid = false;
                  break;
               case AceAircraft.CIRCLE:
                  inGameMenu.mc.uiPanels.towerSelected.flightPaths.circle_btn.valid = false;
            }
         }
         inGameMenu.mc.uiPanels.towerSelected.balance_mc.visible = false;
         if(this.tower.def != null)
         {
            if(this.tower.def.display == MoneyBank || this.tower.def.display == BananaInvestmentsAdvisory)
            {
               inGameMenu.mc.uiPanels.towerSelected.balance_mc.visible = true;
               inGameMenu.mc.uiPanels.towerSelected.balance_mc.balance_txt.text = "$" + String((this.tower.def.behavior.roundStart as BananaEmitter).getBankedFunds(this.tower));
               inGameMenu.mc.uiPanels.towerSelected.balance_mc.extra = {
                  "emitter":this.tower.def.behavior.roundStart as BananaEmitter,
                  "tower":this.tower
               };
               inGameMenu.mc.uiPanels.towerSelected.balance_mc.click = function(param1:Event):void
               {
                  (param1.target as Button).extra.emitter.collect((param1.target as Button).extra.tower);
               };
            }
         }
      }
      
      public function keyDown(param1:KeyboardEvent) : void
      {
         this.keyIsDown = true;
         if(param1.keyCode == 8)
         {
            this.sell(null);
            return;
         }
         if(param1.charCode == ",".charCodeAt(0) || param1.charCode == "<".charCodeAt(0))
         {
            if(inGameMenu.mc.uiPanels.towerSelected["upgradePath1"].next.hit_btn.valid)
            {
               this.upgradePath(0);
               Main.instance.tooltip.hide();
            }
         }
         else if(param1.charCode == ".".charCodeAt(0) || param1.charCode == ">".charCodeAt(0))
         {
            if(inGameMenu.mc.uiPanels.towerSelected["upgradePath2"].next.hit_btn.valid)
            {
               this.upgradePath(1);
               Main.instance.tooltip.hide();
            }
         }
      }
      
      public function keyUp(param1:KeyboardEvent) : void
      {
         this.keyIsDown = false;
      }
      
      override public function enter(param1:Message) : void
      {
         var message:Message = param1;
         this.tower = GameStateMessage(message).tower;
         var towerDef:TowerDef = this.tower.def;
         if(!this.tower.selectable)
         {
            return;
         }
         if(towerDef == null || towerDef.display == null)
         {
            return;
         }
         selectSound.play();
         this.updateTowerSelectedPanel();
         if(this.tower.directUseAbilityButton != null && !inGameMenu.mc.uiPanels.towerSelected.useButton.contains(this.tower.directUseAbilityButton.target))
         {
            inGameMenu.mc.uiPanels.towerSelected.useButton.addChild(this.tower.directUseAbilityButton.target);
         }
         if(this.tower.coolDownTimerGuage != null && !inGameMenu.mc.uiPanels.towerSelected.coolDownTimerClip.contains(this.tower.coolDownTimerGuage))
         {
            inGameMenu.mc.uiPanels.towerSelected.coolDownTimerClip.addChild(this.tower.coolDownTimerGuage);
         }
         inGameMenu.setupReticle(this.tower);
         inGameMenu.mc.uiPanels.towerSelected.visible = true;
         inGameMenu.mc.uiPanels.specialAgentPanel.visible = false;
         inGameMenu.mc.uiPanels.towerSelected.first.click = function(param1:Event):void
         {
            setTargetPriority(Tower.TARGET_FIRST);
         };
         inGameMenu.mc.uiPanels.towerSelected.last.click = function(param1:Event):void
         {
            setTargetPriority(Tower.TARGET_LAST);
         };
         inGameMenu.mc.uiPanels.towerSelected.close.click = function(param1:Event):void
         {
            setTargetPriority(Tower.TARGET_CLOSE);
         };
         inGameMenu.mc.uiPanels.towerSelected.strong.click = function(param1:Event):void
         {
            setTargetPriority(Tower.TARGET_STRONG);
         };
         inGameMenu.mc.uiPanels.towerSelected.flightPaths.vert_btn.click = function(param1:Event):void
         {
            setAceFlightPath(AceAircraft.VERTICAL);
            updateTowerSelectedPanel();
         };
         inGameMenu.mc.uiPanels.towerSelected.flightPaths.horiz_btn.click = function(param1:Event):void
         {
            setAceFlightPath(AceAircraft.HORIZONTAL);
            updateTowerSelectedPanel();
         };
         inGameMenu.mc.uiPanels.towerSelected.flightPaths.circle_btn.click = function(param1:Event):void
         {
            setAceFlightPath(AceAircraft.CIRCLE);
            updateTowerSelectedPanel();
         };
         inGameMenu.mc.uiPanels.towerSelected.pops.text = String(this.tower.popCount);
         this.tower.addEventListener(PropertyModEvent.mod,this.updateTower);
         while(inGameMenu.mc.uiPanels.towerSelected.holder_mc.numChildren > 0)
         {
            inGameMenu.mc.uiPanels.towerSelected.holder_mc.removeChildAt(0);
         }
         if(towerDef != null && towerDef.detailSmall != null)
         {
            inGameMenu.mc.uiPanels.towerSelected.holder_mc.addChild(new this.tower.def.detailSmall());
         }
         this.msg = message;
         inGameMenu.mc.uiPanels.towerSelected.sell.click = this.sell;
         if(inGameMenu.mc.uiPanels.towerSelected.sell.sellLabel != null)
         {
            inGameMenu.mc.uiPanels.towerSelected.sell.sellLabel.mouseEnabled = false;
            inGameMenu.mc.uiPanels.towerSelected.sell.valid = true;
            inGameMenu.mc.uiPanels.towerSelected.sell.sellLabel.text = "SELL FOR $" + String(int(this.tower.spentOn * inGameMenu.sellScale));
            inGameMenu.mc.uiPanels.towerSelected.sell.tooltip = null;
         }
         if(this.tower.hasChildTowers())
         {
            inGameMenu.mc.uiPanels.towerSelected.sell.tooltip = "Can not sell the " + this.tower.def.label + " until all towers on top of it are removed or sold";
            inGameMenu.mc.uiPanels.towerSelected.sell.valid = false;
         }
         else if(!this.tower.canSell)
         {
            inGameMenu.mc.uiPanels.towerSelected.sell.valid = false;
            inGameMenu.mc.uiPanels.towerSelected.sell.sellLabel.text = "Can\'t Sell";
         }
         else
         {
            inGameMenu.mc.uiPanels.towerSelected.sell.valid = true;
         }
         Main.instance.stage.addEventListener(KeyboardEvent.KEY_DOWN,this.keyDown);
         Main.instance.stage.addEventListener(KeyboardEvent.KEY_UP,this.keyUp);
         inGameMenu.mc.uiPanels.towerSelected.label.text = towerDef == null?"":towerDef.label;
         inGameMenu.range.x = this.tower.x;
         inGameMenu.range.y = this.tower.y;
         inGameMenu.extendedRange.x = this.tower.x;
         inGameMenu.extendedRange.y = this.tower.y;
         inGameMenu.range.initialise(towerDef);
         inGameMenu.range.visible = true;
         this.constructUpgrades(this.tower);
         inGameMenu.towerSelectHilight.setTower(this.tower);
         inGameMenu.dispatchEvent(new Event("TowerSelected"));
      }
      
      private function sell(param1:Event) : void
      {
         var _loc2_:String = null;
         var _loc3_:String = null;
         if(this.tower.resellable)
         {
            _loc2_ = this.tower.rootID;
            _loc3_ = this.tower.rootID;
            this.game.level.addCash(this.tower.spentOn * inGameMenu.sellScale);
            this.game.level.sellTower(this.tower);
            machine.changeState(inGameMenu.towerNotSelectedState,this.msg);
         }
      }
      
      public function upgradePath1(param1:MouseEvent) : void
      {
         this.upgradePath(0);
      }
      
      public function upgradePath2(param1:MouseEvent) : void
      {
         this.upgradePath(1);
      }
      
      public function upgradePath(param1:int) : void
      {
         var _loc2_:Button = inGameMenu.mc.uiPanels.towerSelected["upgradePath" + String(param1 + 1)].next.hit_btn;
         var _loc3_:int = _loc2_.extra.cost;
         if(_loc3_ > this.game.level.cash.value)
         {
            return;
         }
         if(param1 == 0 && inGameMenu.mc.uiPanels.towerSelected.upgradePath1.visible == false)
         {
            return;
         }
         if(param1 == 1 && inGameMenu.mc.uiPanels.towerSelected.upgradePath2.visible == false)
         {
            return;
         }
         new MaxSound(Upgrade).play();
         var _loc4_:Number = _loc3_;
         this.game.level.removeCash(_loc4_);
         this.tower.spentOn = this.tower.spentOn + _loc4_;
         this.game.level.upgradeTowerPath(this.tower,param1);
         _loc2_.handleMouseOut(null);
         this.constructUpgrades(this.tower,param1);
         _loc2_.handleMouseOver(null);
         inGameMenu.abilityBar.addTower(this.tower);
         inGameMenu.upgradeTowerPath(this.tower);
         inGameMenu.towerHilight.setTower(inGameMenu.towerHilight.tower);
         inGameMenu.towerSelectHilight.setTower(inGameMenu.towerSelectHilight.tower);
      }
      
      public function updateCanBuy(param1:Event) : void
      {
         this.updateCanBuyPath(0);
         this.updateCanBuyPath(1);
      }
      
      public function updateCanBuyPath(param1:int) : void
      {
         var _loc3_:int = 0;
         if(this.game)
         {
         }
         if(this.game.level)
         {
         }
         var _loc2_:MovieClip = inGameMenu.mc.uiPanels.towerSelected["upgradePath" + String(param1 + 1)].next;
         if(_loc2_)
         {
         }
         if(_loc2_.currentLabel == "CanBuy" || _loc2_.currentLabel == "CantAfford" || _loc2_.currentLabel == "CanBuyEnd" || _loc2_.currentLabel == "CantAffordEnd")
         {
            _loc3_ = int(_loc2_.hit_btn.extra.cost);
            if(this.game.level.cash.value < _loc3_)
            {
               _loc2_.gotoAndStop("CantAffordEnd");
               _loc2_.hit_btn.valid = false;
               _loc2_.cost_txt.text = "$" + String(_loc3_);
            }
            else
            {
               _loc2_.gotoAndStop("CanBuyEnd");
               _loc2_.hit_btn.valid = true;
               _loc2_.cost_txt.text = "$" + String(_loc3_);
            }
         }
      }
      
      public function constructUpgrade(param1:int, param2:Boolean) : void
      {
         var next:MovieClip = null;
         var currentUpgrade:UpgradeDef = null;
         var thumb:MovieClip = null;
         var cost:int = 0;
         var previousUpgrade:UpgradeDef = null;
         var path:int = param1;
         var scroll:Boolean = param2;
         var otherPath:int = path == 0?1:0;
         next = inGameMenu.mc.uiPanels.towerSelected["upgradePath" + String(path + 1)].next;
         var current:MovieClip = inGameMenu.mc.uiPanels.towerSelected["upgradePath" + String(path + 1)].current;
         this.game.level.addEventListener(LevelEvent.CASH_CHANGE,this.updateCanBuy,false,0,true);
         if(next.holder_mc.numChildren > 0)
         {
            next.holder_mc.removeChildAt(0);
         }
         var upgradePathDef:UpgradePathDef = this.tower.upgradePathDef;
         var pathGrade:int = this.tower.upgradePaths[path];
         var otherPathGrade:int = this.tower.upgradePaths[otherPath];
         var towersUnlocked:Object = UpgradeAvailabilityManager.instance.getUpgradesUnlockedForTower(this.tower.rootID);
         var pathKey:String = "path" + (path + 1).toString();
         var pathUnlockedTo:int = towersUnlocked[pathKey];
         var currentTierIsUnlocked:Boolean = pathUnlockedTo > pathGrade;
         if(!currentTierIsUnlocked)
         {
            if(pathGrade == 4)
            {
               next.gotoAndStop("LockedMax");
               next.hit_btn.tooltip = "All upgrades for this path have been purchased.";
               next.hit_btn.click = null;
               next.hit_btn.valid = false;
            }
            else
            {
               if(scroll)
               {
                  next.gotoAndPlay("Locked");
               }
               else
               {
                  next.gotoAndStop("LockedEnd");
               }
               next.hit_btn.tooltip = "Research upgrades in your city upgrade buildings.";
               next.hit_btn.click = null;
               next.hit_btn.valid = false;
            }
            if(pathGrade < 4)
            {
               UpgradesBridge.REQUEST_UPGRADE_INFORMATION.dispatch(this.tower.rootID,path,pathGrade,function(param1:Object):void
               {
                  if(param1.success)
                  {
                     next.hit_btn.tooltip = "Research " + param1.upgradeName + " from your " + param1.buildingName + " building.";
                  }
               });
            }
            else
            {
               next.hit_btn.tooltip = "Maximum upgrades";
            }
         }
         else if(pathGrade == 2 && otherPathGrade >= 3)
         {
            if(scroll)
            {
               next.gotoAndPlay("LockedPath");
            }
            else
            {
               next.gotoAndStop("LockedPathEnd");
            }
            next.hit_btn.tooltip = "No further upgrades can be bought for this path due to level 3 or 4 upgrades bought for the other path.";
            next.hit_btn.click = null;
            next.hit_btn.valid = false;
         }
         else
         {
            currentUpgrade = upgradePathDef.upgrades[path][pathGrade];
            cost = this.game.level.calcCostMods(currentUpgrade.cost,this.tower.x,this.tower.y,this.tower);
            next.hit_btn.extra = {"cost":cost};
            if(cost <= this.game.level.cash.value && pathUnlockedTo)
            {
               if(scroll)
               {
                  next.gotoAndPlay("CanBuy");
               }
               else
               {
                  next.gotoAndStop("CanBuyEnd");
               }
               next.hit_btn.valid = true;
            }
            else
            {
               if(scroll)
               {
                  next.gotoAndPlay("CantAfford");
               }
               else
               {
                  next.gotoAndStop("CantAffordEnd");
               }
               next.hit_btn.valid = false;
            }
            next.cost_txt.text = "$" + String(cost);
            next.hit_btn.tooltip = "<font color=\'#EDE2D5\' face=\'Oetztype\'>" + currentUpgrade.label + "\n$" + String(cost) + "</font>\n" + currentUpgrade.description;
            next.hit_btn.click = this["upgradePath" + String(path + 1)];
            if(currentUpgrade.thumb)
            {
               thumb = new currentUpgrade.thumb();
               next.holder_mc.addChild(thumb);
            }
         }
         if(current.holder_mc.numChildren > 0)
         {
            current.holder_mc.removeChildAt(0);
         }
         current.hit_btn.valid = false;
         if(pathGrade > 0)
         {
            previousUpgrade = upgradePathDef.upgrades[path][pathGrade - 1];
            if(scroll)
            {
               current.gotoAndPlay("Bought");
            }
            else
            {
               current.gotoAndStop(25);
            }
            current.hit_btn.tooltip = "<font color=\'#EDE2D5\' face=\'Oetztype\'>" + previousUpgrade.label + "</font>\n" + previousUpgrade.description;
            if(previousUpgrade.thumb)
            {
               thumb = new previousUpgrade.thumb();
               current.holder_mc.addChild(thumb);
            }
            inGameMenu.mc.uiPanels.towerSelected["upgradePath" + String(path + 1)].upgradeBar1_mc.gotoAndStop(pathGrade + 1);
         }
         else
         {
            current.gotoAndStop("NoUpgrade");
            current.pathNo_txt.text = String(path + 1);
            current.hit_btn.tooltip = null;
            inGameMenu.mc.uiPanels.towerSelected["upgradePath" + String(path + 1)].upgradeBar1_mc.gotoAndStop(1);
         }
      }
      
      public function constructUpgrades(param1:Tower, param2:int = -1) : void
      {
         if(param1.upgradePathDef == null)
         {
            inGameMenu.mc.uiPanels.towerSelected.upgradePath1.visible = false;
            inGameMenu.mc.uiPanels.towerSelected.upgradePath2.visible = false;
            return;
         }
         inGameMenu.mc.uiPanels.towerSelected.upgradePath1.visible = true;
         inGameMenu.mc.uiPanels.towerSelected.upgradePath2.visible = true;
         this.constructUpgrade(0,param2 == 0);
         this.constructUpgrade(1,param2 == 1);
      }
      
      override public function message(param1:Message) : State
      {
         if(GameStateMessage(param1).type == GameStateMessage.TOWERSELECTED_MSG)
         {
            return inGameMenu.towerSelectedState;
         }
         if(GameStateMessage(param1).type == GameStateMessage.TOWERNOTSELECTED_MSG)
         {
            return inGameMenu.towerNotSelectedState;
         }
         if(GameStateMessage(param1).type == GameStateMessage.CANCEL_MSG)
         {
            return inGameMenu.towerNotSelectedState;
         }
         return null;
      }
      
      override public function exit() : void
      {
         if(this.tower && this.tower.directUseAbilityButton != null && inGameMenu.mc.uiPanels.towerSelected.useButton.contains(this.tower.directUseAbilityButton.target))
         {
            inGameMenu.mc.uiPanels.towerSelected.useButton.removeChild(this.tower.directUseAbilityButton.target);
         }
         if(this.tower && this.tower.coolDownTimerGuage != null && inGameMenu.mc.uiPanels.towerSelected.coolDownTimerClip.contains(this.tower.coolDownTimerGuage))
         {
            inGameMenu.mc.uiPanels.towerSelected.coolDownTimerClip.removeChild(this.tower.coolDownTimerGuage);
         }
         inGameMenu.mc.uiPanels.buildPanel.visible = true;
         inGameMenu.mc.uiPanels.towerSelected.visible = false;
         inGameMenu.mc.uiPanels.specialAgentPanel.visible = true;
         inGameMenu.range.visible = false;
         inGameMenu.removeReticle();
         if(this.tower)
         {
            this.tower.removeEventListener(PropertyModEvent.mod,this.updateTower);
         }
         Main.instance.stage.removeEventListener(KeyboardEvent.KEY_DOWN,this.keyDown);
         Main.instance.stage.removeEventListener(KeyboardEvent.KEY_UP,this.keyUp);
         inGameMenu.towerSelectHilight.setTower(null);
      }
   }
}

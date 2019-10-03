package ninjakiwi.monkeyTown.btdModule.ingame
{
   import assets.ability.CannotDoSymbol;
   import assets.module.useTactics_btn;
   import display.ui.Button;
   import flash.display.MovieClip;
   import flash.events.Event;
   import flash.utils.Dictionary;
   import ninjakiwi.monkeyTown.btdModule.abilities.Ability;
   import ninjakiwi.monkeyTown.btdModule.abilities.def.AbilityDef;
   import ninjakiwi.monkeyTown.btdModule.towers.Tower;
   
   public class AbilityBar
   {
       
      
      private var container:MovieClip;
      
      private var abilities:Dictionary;
      
      private var buttonPositions:Dictionary;
      
      private var buttonCounts:Dictionary;
      
      public function AbilityBar()
      {
         super();
      }
      
      public function init(param1:MovieClip) : void
      {
         this.container = param1;
      }
      
      public function gameBegin(param1:Vector.<Tower>) : void
      {
         this.reset();
         var _loc2_:int = 0;
         while(_loc2_ < param1.length)
         {
            this.addTower(param1[_loc2_]);
            _loc2_++;
         }
      }
      
      public function reset() : void
      {
         while(this.container.numChildren > 0)
         {
            this.container.removeChildAt(0);
         }
         this.abilities = new Dictionary();
         this.buttonPositions = new Dictionary();
         this.buttonCounts = new Dictionary();
      }
      
      public function addTower(param1:Tower) : void
      {
         var _loc2_:int = 0;
         var _loc3_:AbilityDef = null;
         var _loc4_:AbilityStruct = null;
         var _loc5_:MovieClip = null;
         var _loc6_:CannotDoSymbol = null;
         var _loc7_:int = 0;
         var _loc8_:int = 0;
         if(this.abilities == null)
         {
            return;
         }
         if(param1.def != null && param1.def.abilities != null)
         {
            _loc2_ = 0;
            while(_loc2_ < param1.def.abilities.length)
            {
               _loc3_ = param1.def.abilities[_loc2_];
               if(this.abilities[param1] == null)
               {
                  this.abilities[param1] = new Dictionary();
               }
               if(this.abilities[param1][_loc3_.id] == null)
               {
                  _loc4_ = new AbilityStruct();
                  _loc4_.abilityDef = _loc3_;
                  _loc4_.tower = param1;
                  _loc4_.button = new useTactics_btn();
                  _loc4_.button.tooltip = "<font color=\'#EDE2D5\' face=\'Oetztype\'>" + _loc3_.label + "</font>\n" + _loc3_.description;
                  _loc4_.button.extra = _loc4_;
                  _loc4_.button.click = this.abilityClicked;
                  _loc5_ = new _loc3_.thumb();
                  _loc5_.stop();
                  _loc4_.button.holder_mc.addChild(_loc5_);
                  _loc4_.button.qty_txt.text = "";
                  _loc6_ = new CannotDoSymbol();
                  _loc4_.cannotDoSymbol = _loc6_;
                  _loc6_.visible = false;
                  _loc4_.button.addChild(_loc6_);
                  this.container.addChild(_loc4_.button);
                  _loc4_.timer = param1.abilityTimer(_loc3_.id);
                  this.abilities[param1][_loc3_.id] = _loc4_;
                  if(this.buttonPositions[_loc3_.id] != null)
                  {
                     _loc4_.button.x = this.buttonPositions[_loc3_.id];
                     this.buttonCounts[_loc3_.id] = this.buttonCounts[_loc3_.id] + 1;
                  }
                  else
                  {
                     _loc7_ = 0;
                     for each(_loc8_ in this.buttonPositions)
                     {
                        _loc7_++;
                     }
                     this.buttonPositions[_loc3_.id] = 3 + _loc7_ * 34;
                     _loc4_.button.x = this.buttonPositions[_loc3_.id];
                     this.buttonCounts[_loc3_.id] = 1;
                  }
                  _loc4_.button.y = 24;
               }
               _loc2_++;
            }
            this.update();
         }
      }
      
      public function removeTower(param1:Tower) : void
      {
         var _loc2_:int = 0;
         var _loc3_:AbilityDef = null;
         var _loc4_:int = 0;
         var _loc5_:* = null;
         var _loc6_:Dictionary = null;
         var _loc7_:AbilityStruct = null;
         if(param1.def != null && param1.def.abilities)
         {
            _loc2_ = 0;
            while(_loc2_ < param1.def.abilities.length)
            {
               _loc3_ = param1.def.abilities[_loc2_];
               if(this.abilities[param1][_loc3_.id] != null)
               {
                  this.container.removeChild(this.abilities[param1][_loc3_.id].button);
                  delete this.abilities[param1][_loc3_.id];
                  this.buttonCounts[_loc3_.id] = this.buttonCounts[_loc3_.id] - 1;
                  if(this.buttonCounts[_loc3_.id] == 0)
                  {
                     delete this.buttonCounts[_loc3_.id];
                     _loc4_ = this.buttonPositions[_loc3_.id];
                     delete this.buttonPositions[_loc3_.id];
                     for(_loc5_ in this.buttonPositions)
                     {
                        if(this.buttonPositions[_loc5_] > _loc4_)
                        {
                           this.buttonPositions[_loc5_] = this.buttonPositions[_loc5_] - 34;
                        }
                     }
                     for each(_loc6_ in this.abilities)
                     {
                        for each(_loc7_ in _loc6_)
                        {
                           _loc7_.button.x = this.buttonPositions[_loc7_.abilityDef.id];
                        }
                     }
                  }
               }
               _loc2_++;
            }
         }
      }
      
      public function updateButtons() : void
      {
         var _loc2_:AbilityStruct = null;
         var _loc3_:Dictionary = null;
         var _loc4_:Object = null;
         var _loc1_:Dictionary = new Dictionary();
         for each(_loc3_ in this.abilities)
         {
            for each(_loc2_ in _loc3_)
            {
               if(_loc1_[_loc2_.abilityDef.id] == null)
               {
                  _loc1_[_loc2_.abilityDef.id] = {
                     "count":(!!_loc2_.timer.running?0:1),
                     "current":_loc2_
                  };
               }
               else
               {
                  _loc4_ = _loc1_[_loc2_.abilityDef.id];
                  _loc4_.count = _loc4_.count + (!!_loc2_.timer.running?0:1);
                  if(_loc4_.current.timer.running == true && (_loc2_.timer.running == false || _loc2_.timer.current > _loc4_.current.timer.current))
                  {
                     _loc4_.current = _loc2_;
                  }
               }
            }
         }
         for each(_loc4_ in _loc1_)
         {
            _loc2_ = _loc4_.current;
            this.container.addChild(_loc4_.current.button);
            if(_loc4_.count > 1)
            {
               _loc4_.current.button.qty_txt.text = _loc4_.count;
            }
            else
            {
               _loc4_.current.button.qty_txt.text = "";
            }
         }
      }
      
      public function update() : void
      {
         var _loc1_:Dictionary = null;
         var _loc2_:AbilityStruct = null;
         var _loc3_:Number = NaN;
         var _loc4_:Ability = null;
         this.updateButtons();
         for each(_loc1_ in this.abilities)
         {
            for each(_loc2_ in _loc1_)
            {
               _loc2_.button.valid = _loc2_.timer.running == false;
               if(_loc2_.timer.running == true)
               {
                  _loc3_ = _loc2_.timer.current / _loc2_.timer.delay;
                  _loc2_.button.coolDown_mc.gotoAndStop(int(_loc3_ * (_loc2_.button.coolDown_mc.totalFrames - 1)) + 1);
                  _loc2_.cannotDoSymbol.visible = false;
                  _loc2_.button.mouseEnabled = true;
                  if(_loc2_.tower.directUseAbilityButton != null)
                  {
                     _loc2_.tower.directUseAbilityButton.enable = false;
                  }
                  if(_loc2_.tower.coolDownTimerGuage != null)
                  {
                     _loc2_.tower.coolDownTimerGuage.guage.scaleX = _loc3_;
                  }
               }
               else
               {
                  if(_loc2_.tower.directUseAbilityButton != null)
                  {
                     _loc2_.tower.directUseAbilityButton.enable = true;
                  }
                  if(_loc2_.tower.coolDownTimerGuage != null)
                  {
                     _loc2_.tower.coolDownTimerGuage.guage.scaleX = 1;
                  }
                  _loc4_ = _loc2_.tower.activeAbilities[_loc2_.abilityDef];
                  if(_loc4_ && !_loc4_.isReady)
                  {
                     _loc2_.cannotDoSymbol.visible = true;
                     _loc2_.button.mouseEnabled = false;
                  }
                  else
                  {
                     _loc2_.cannotDoSymbol.visible = false;
                     _loc2_.button.mouseEnabled = true;
                  }
               }
            }
         }
      }
      
      public function disable() : void
      {
         var _loc1_:Dictionary = null;
         var _loc2_:AbilityStruct = null;
         for each(_loc1_ in this.abilities)
         {
            for each(_loc2_ in _loc1_)
            {
               _loc2_.button.valid = false;
            }
         }
      }
      
      public function abilityClicked(param1:Event) : void
      {
         var _loc2_:Button = Button(param1.target);
         var _loc3_:AbilityStruct = AbilityStruct(_loc2_.extra);
         if(_loc3_.timer.running)
         {
            return;
         }
         _loc3_.tower.level.useAbility(_loc3_.tower,_loc3_.abilityDef.id,_loc2_);
      }
      
      public function set x(param1:Number) : void
      {
         this.container.x = param1;
      }
   }
}

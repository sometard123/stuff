package ninjakiwi.monkeyTown.btdModule.abilities.antiBossAbilities.def
{
   import assets.btdmodule.ui.AntiBossAbilityBaneClip;
   import assets.btdmodule.ui.AntiBossAbilityBlastClip;
   import assets.btdmodule.ui.AntiBossAbilityChillClip;
   import assets.btdmodule.ui.AntiBossAbilityWeakenClip;
   import assets.ui.AntiBossAbilitiesPane;
   import com.greensock.TweenLite;
   import com.greensock.easing.Cubic;
   import flash.display.DisplayObjectContainer;
   import flash.display.MovieClip;
   import ninjakiwi.monkeyTown.btdModule.abilities.antiBossAbilities.BossBaneBehaviour;
   import ninjakiwi.monkeyTown.btdModule.abilities.antiBossAbilities.BossBlastBehaviour;
   import ninjakiwi.monkeyTown.btdModule.abilities.antiBossAbilities.BossChillBehaviour;
   import ninjakiwi.monkeyTown.btdModule.abilities.antiBossAbilities.BossWeakenBehaviour;
   import ninjakiwi.monkeyTown.btdModule.bloons.Bloon;
   import ninjakiwi.monkeyTown.btdModule.events.BloonEvent;
   import ninjakiwi.monkeyTown.btdModule.specialTrack.tracks.SpecialTrackBoss;
   import ninjakiwi.monkeyTown.common.Constants;
   import ninjakiwi.monkeyTown.common.btdModule.definitions.BTDGameRequest;
   import ninjakiwi.monkeyTown.ui.buttons.ButtonControllerBase;
   
   public class AntiBossAbilitySlideoutPane
   {
       
      
      private var _definitions:Vector.<AntiBossAbilityDef> = null;
      
      private var _abilities:Vector.<AntiBossAbility> = null;
      
      private var _areAbilitiesAvailable:Boolean = false;
      
      private var _clip:AntiBossAbilitiesPane;
      
      private var _container:DisplayObjectContainer = null;
      
      private var _pane:MovieClip = null;
      
      private var _lastGameTime:Number = 0;
      
      private var _slideDistance:int;
      
      private var _isOpen:Boolean = true;
      
      private var _openCloseButton:ButtonControllerBase;
      
      private var _chillTutorialArrow:MovieClip = null;
      
      public function AntiBossAbilitySlideoutPane(param1:AntiBossAbilitiesPane)
      {
         super();
         this._clip = param1;
         this._pane = this._clip.pane;
         this._container = this._clip.pane.container;
         this._slideDistance = -this._clip.slideMarker.x;
         this._abilities = new Vector.<AntiBossAbility>();
         this._chillTutorialArrow = param1.chillArrow;
         this._openCloseButton = new ButtonControllerBase(this._pane.openCloseButton);
         this._openCloseButton.setClickFunction(this.toggleOpen);
         SpecialTrackBoss.onBossSpawnedSignal.add(this.onBossSpawned);
         Bloon.eventDispatcher.addEventListener(BloonEvent.BOSS_DESTROYED,this.onBossDestroyed);
         this.slideIn(0);
         this.setLocked(false);
      }
      
      private static function get gameTime() : Number
      {
         return Main.instance.game.getGameTime();
      }
      
      public function reset() : void
      {
         this._areAbilitiesAvailable = false;
         if(this._definitions != null)
         {
            this._definitions.length = 0;
            this._definitions = null;
         }
         this._lastGameTime = 0;
         this.slideIn(0);
      }
      
      public function setLocked(param1:Boolean) : void
      {
         this._clip.lockBlocker.visible = param1;
      }
      
      public function toggleOpen() : void
      {
         if(this._isOpen)
         {
            this.slideIn();
         }
         else
         {
            this.slideOut();
         }
      }
      
      public function setChillArrowVisible(param1:Boolean) : void
      {
         var state:Boolean = param1;
         if(state)
         {
            this._chillTutorialArrow.alpha = 0;
            this._chillTutorialArrow.visible = true;
            TweenLite.to(this._chillTutorialArrow,1,{
               "alpha":1,
               "ease":Cubic.easeIn
            });
         }
         else
         {
            this._chillTutorialArrow.alpha = 1;
            TweenLite.to(this._chillTutorialArrow,1,{
               "alpha":0,
               "ease":Cubic.easeIn,
               "onComplete":function():void
               {
                  _chillTutorialArrow.visible = true;
               }
            });
         }
      }
      
      public function slideIn(param1:Number = 0.3) : void
      {
         this._isOpen = false;
         TweenLite.to(this._pane,param1,{
            "x":this._slideDistance,
            "ease":Cubic.easeIn
         });
         this.setChillArrowVisible(false);
      }
      
      public function slideOut(param1:Number = 0.3) : void
      {
         this._isOpen = true;
         TweenLite.to(this._pane,param1,{
            "x":0,
            "ease":Cubic.easeOut
         });
      }
      
      public function setGameRequest(param1:BTDGameRequest) : void
      {
         this.reset();
         if(null == param1 || null == param1.bossAttack || false == Constants.ENABLE_ANTI_BOSS_ABILITIES)
         {
            this._areAbilitiesAvailable = false;
            this._container.visible = false;
            return;
         }
         this._areAbilitiesAvailable = true;
         this._container.visible = true;
         var _loc2_:Vector.<AntiBossAbilityDef> = new Vector.<AntiBossAbilityDef>();
         var _loc3_:AntiBossAbilityDef = new AntiBossAbilityDef().Type(Constants.BOSS_CHILL_ID).BehaviourClass(BossChillBehaviour).ButtonClipClass(AntiBossAbilityChillClip).ActivationLimit(-1).BonusCount(param1.bossAttack.extraBossChills).Duration(8).Cooldown(30).Cost(30).TooltipName("Boss Chill").TooltipDescription("Holds the Boss in place for 5 seconds. 30 second cooldown.");
         var _loc4_:AntiBossAbilityDef = new AntiBossAbilityDef().Type(Constants.BOSS_BANE_ID).BehaviourClass(BossBaneBehaviour).ButtonClipClass(AntiBossAbilityBaneClip).BonusCount(param1.bossAttack.extraBossBanes).Cooldown(30).Cost(30).TooltipName("Boss Bane").TooltipDescription("Deals 1500 damage to the Boss. 30 second cooldown.");
         var _loc5_:AntiBossAbilityDef = new AntiBossAbilityDef().Type(Constants.BOSS_BLAST_ID).BehaviourClass(BossBlastBehaviour).ButtonClipClass(AntiBossAbilityBlastClip).BonusCount(param1.bossAttack.extraBossBlasts).Duration(1).Cooldown(40).Cost(30).TooltipName("Boss Blast").TooltipDescription("Pushes the Boss back along the track and deals instant damage. 40 second cooldown.");
         var _loc6_:AntiBossAbilityDef = new AntiBossAbilityDef().Type(Constants.BOSS_WEAKEN_ID).BehaviourClass(BossWeakenBehaviour).ButtonClipClass(AntiBossAbilityWeakenClip).BonusCount(param1.bossAttack.extraBossWeakens).Duration(10).Cooldown(60).Cost(30).TooltipName("Boss Weaken").TooltipDescription("Makes the Boss vulnerable. Deal double damage for 10 seconds. 60 second cooldown.");
         _loc2_.push(_loc3_);
         _loc2_.push(_loc4_);
         _loc2_.push(_loc5_);
         _loc2_.push(_loc6_);
         this.populateFromDefinitions(_loc2_);
      }
      
      public function populateFromDefinitions(param1:Vector.<AntiBossAbilityDef>) : void
      {
         var _loc3_:AntiBossAbilityDef = null;
         var _loc4_:IAntiBossAbilityBehaviour = null;
         var _loc5_:int = 0;
         var _loc6_:int = 0;
         var _loc7_:Number = NaN;
         var _loc8_:Number = NaN;
         var _loc9_:AntiBossAbilityButton = null;
         var _loc10_:AntiBossAbility = null;
         this._definitions = param1;
         this._abilities.length = 0;
         var _loc2_:int = 0;
         while(_loc2_ < this._definitions.length)
         {
            _loc3_ = this._definitions[_loc2_];
            _loc4_ = new _loc3_.behaviourClass();
            _loc5_ = 3;
            _loc6_ = 40;
            _loc7_ = _loc2_ * _loc6_ + _loc5_;
            _loc8_ = 0;
            _loc9_ = new AntiBossAbilityButton(_loc3_.buttonClipClass,this._container,_loc7_,_loc8_,_loc3_.cost,_loc3_.tooltipName,_loc3_.tooltipDescription);
            _loc9_.onButtonPressedSignal.addOnce(this.onButtonPressed);
            _loc10_ = new AntiBossAbility(_loc4_,_loc9_,_loc3_);
            this._abilities.push(_loc10_);
            _loc2_++;
         }
         this.onBossDestroyed();
      }
      
      private function onButtonPressed() : void
      {
         this.setChillArrowVisible(false);
      }
      
      public function update() : void
      {
         var _loc1_:Number = NaN;
         if(false == this._areAbilitiesAvailable)
         {
            return;
         }
         _loc1_ = gameTime;
         var _loc2_:Number = _loc1_ - this._lastGameTime;
         var _loc3_:int = 0;
         while(_loc3_ < this._abilities.length)
         {
            this._abilities[_loc3_].update(_loc2_);
            _loc3_++;
         }
         this._lastGameTime = _loc1_;
      }
      
      private function onBossSpawned(param1:Bloon) : void
      {
         var _loc2_:int = 0;
         while(_loc2_ < this._abilities.length)
         {
            this._abilities[_loc2_].onBossSpawned();
            _loc2_++;
         }
      }
      
      private function onBossDestroyed(... rest) : void
      {
         var _loc2_:int = 0;
         while(_loc2_ < this._abilities.length)
         {
            this._abilities[_loc2_].onBossDespawned();
            _loc2_++;
         }
      }
   }
}

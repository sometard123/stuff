package ninjakiwi.monkeyTown.btdModule.ingame
{
   import flash.display.MovieClip;
   import flash.events.Event;
   import flash.events.TimerEvent;
   import flash.utils.Timer;
   import ninjakiwi.monkeyTown.btdModule.entities.SupplyDropHelpFromFriends;
   import ninjakiwi.monkeyTown.btdModule.events.LevelEvent;
   import ninjakiwi.monkeyTown.btdModule.math.Vector2;
   import ninjakiwi.monkeyTown.btdModule.towers.def.TowerDef;
   import ninjakiwi.monkeyTown.common.btdModule.definitions.BTDGameRequest;
   
   public class HelpFromFriends
   {
      
      private static const NUM_OF_SUPPLY_DROPS_IN_ARRAY:uint = 3;
      
      private static const BOSS_DROP_INTERVAL:Number = 30;
       
      
      private var _gameRequest:BTDGameRequest;
      
      private var _activeSupplyDrops:Vector.<SupplyDropHelpFromFriends>;
      
      private var _supplyCratesThisGame:int = 0;
      
      private var _supplyCratesRemaining:int = 0;
      
      private var _dropSpace:MovieClip;
      
      private var _isInitialised:Boolean;
      
      private var _cratesDropped:int = 0;
      
      private var _timedDropTimer:Timer;
      
      private var _timeGameStarted:Number = 0;
      
      public function HelpFromFriends(param1:BTDGameRequest)
      {
         this._activeSupplyDrops = new Vector.<SupplyDropHelpFromFriends>();
         this._timedDropTimer = new Timer(100,0);
         super();
         this._gameRequest = param1;
      }
      
      public function newGame(param1:Array) : void
      {
         this.destroy();
         var _loc2_:* = this._gameRequest.bossAttack !== null;
         if(_loc2_)
         {
            this.initBossDrops();
         }
         else
         {
            Main.instance.game.addEventListener(LevelEvent.ROUND_START,this.newRound);
         }
         this._cratesDropped = 0;
         this._supplyCratesThisGame = 0;
         var _loc3_:int = 0;
         while(_loc3_ < NUM_OF_SUPPLY_DROPS_IN_ARRAY)
         {
            if(param1[_loc3_])
            {
               this._supplyCratesThisGame++;
            }
            _loc3_++;
         }
         this._supplyCratesRemaining = this._supplyCratesThisGame;
      }
      
      private function initBossDrops() : void
      {
         Main.instance.game.addEventListener(LevelEvent.ROUND_START,this.onBossDropFirstRound);
      }
      
      private function onBossDropFirstRound(param1:LevelEvent) : void
      {
         Main.instance.game.removeEventListener(LevelEvent.ROUND_START,this.onBossDropFirstRound);
         this._timedDropTimer.addEventListener(TimerEvent.TIMER,this.onTimedDropTimerUpdate);
         this._timedDropTimer.reset();
         this._timedDropTimer.start();
         this._timeGameStarted = Main.instance.game.getGameTime();
      }
      
      private function onTimedDropTimerUpdate(param1:TimerEvent) : void
      {
         var _loc2_:Number = Main.instance.game.getGameTime() - this._timeGameStarted;
         if(_loc2_ > BOSS_DROP_INTERVAL * this._cratesDropped)
         {
            this.callSupplyDrop();
         }
         if(this._supplyCratesRemaining <= 0)
         {
            this._timedDropTimer.stop();
            this._timedDropTimer.reset();
         }
      }
      
      private function init() : void
      {
         var _loc2_:Vector2 = null;
         if(this._isInitialised)
         {
            this.destroy();
         }
         var _loc1_:TowerDef = Main.instance.towerFactory.getBaseTower("MonkeyVillage");
         this._dropSpace = new _loc1_.occupiedSpace();
         _loc2_ = this.findValidDropPoint();
         this._dropSpace.x = _loc2_.x;
         this._dropSpace.y = _loc2_.y;
         this._isInitialised = true;
      }
      
      private function findValidDropPoint() : Vector2
      {
         var _loc5_:Vector2 = null;
         var _loc7_:Number = NaN;
         var _loc1_:Vector2 = new Vector2(Settings.STAGE_WIDTH * 0.5,Settings.STAGE_HEIGHT * 0.5);
         var _loc2_:Vector2 = new Vector2(_loc1_.x,_loc1_.y);
         var _loc3_:int = 250;
         var _loc4_:int = 10;
         _loc5_ = new Vector2(_loc1_.x,_loc1_.y);
         if(this.checkIfPointValid(_loc5_))
         {
            return _loc5_;
         }
         var _loc6_:int = 0;
         while(_loc6_ < _loc3_)
         {
            _loc7_ = (_loc6_ + 1) * _loc4_;
            _loc5_.x = _loc1_.x - _loc7_;
            _loc5_.y = _loc1_.y + _loc7_;
            if(this.checkIfPointValid(_loc5_))
            {
               break;
            }
            _loc5_.x = _loc1_.x;
            _loc5_.y = _loc1_.y + _loc7_;
            if(this.checkIfPointValid(_loc5_))
            {
               break;
            }
            _loc5_.x = _loc1_.x + _loc7_;
            _loc5_.y = _loc1_.y + _loc7_;
            if(this.checkIfPointValid(_loc5_))
            {
               break;
            }
            _loc5_.x = _loc1_.x - _loc7_;
            _loc5_.y = _loc1_.y;
            if(this.checkIfPointValid(_loc5_))
            {
               break;
            }
            _loc5_.x = _loc1_.x + _loc7_;
            _loc5_.y = _loc1_.y;
            if(this.checkIfPointValid(_loc5_))
            {
               break;
            }
            _loc5_.x = _loc1_.x - _loc7_;
            _loc5_.y = _loc1_.y - _loc7_;
            if(this.checkIfPointValid(_loc5_))
            {
               break;
            }
            _loc5_.x = _loc1_.x;
            _loc5_.y = _loc1_.y - _loc7_;
            if(this.checkIfPointValid(_loc5_))
            {
               break;
            }
            _loc5_.x = _loc1_.x + _loc7_;
            _loc5_.y = _loc1_.y - _loc7_;
            if(this.checkIfPointValid(_loc5_))
            {
               break;
            }
            _loc6_++;
         }
         return _loc5_;
      }
      
      private function checkIfPointValid(param1:Vector2) : Boolean
      {
         this._dropSpace.x = param1.x;
         this._dropSpace.y = param1.y;
         this._dropSpace.width = 500;
         var _loc2_:Boolean = Main.instance.game.level.isPlaceable(this._dropSpace);
         return _loc2_;
      }
      
      public function restartMvMGame() : void
      {
         this._supplyCratesRemaining = this._supplyCratesThisGame;
         var _loc1_:int = 0;
         while(_loc1_ < this._activeSupplyDrops.length)
         {
            this._activeSupplyDrops[_loc1_].reset();
            _loc1_++;
         }
         this._activeSupplyDrops.length = 0;
      }
      
      public function newRound(param1:Event) : void
      {
         this.callSupplyDrop();
      }
      
      public function process(param1:Number) : void
      {
         if(this._isInitialised == false)
         {
            return;
         }
         var _loc2_:int = 0;
         while(_loc2_ < this._activeSupplyDrops.length)
         {
            this._activeSupplyDrops[_loc2_].process(param1);
            _loc2_++;
         }
      }
      
      public function callSupplyDrop() : void
      {
         if(this._supplyCratesRemaining <= 0)
         {
            return;
         }
         if(this._isInitialised == false)
         {
            this.init();
         }
         var _loc1_:SupplyDropHelpFromFriends = new SupplyDropHelpFromFriends();
         _loc1_.initialise(this._dropSpace.x,this._dropSpace.y);
         _loc1_.callDrop();
         this._activeSupplyDrops.push(_loc1_);
         Main.instance.effectLayer.addChild(_loc1_);
         this._supplyCratesRemaining--;
         this._cratesDropped++;
      }
      
      public function destroy() : void
      {
         var _loc1_:int = 0;
         while(_loc1_ < this._activeSupplyDrops.length)
         {
            this._activeSupplyDrops[_loc1_].reset();
            _loc1_++;
         }
         Main.instance.effectLayer.removeChildren();
         this._activeSupplyDrops.length = 0;
         Main.instance.game.removeEventListener(LevelEvent.ROUND_START,this.newRound);
         this._timedDropTimer.stop();
         this._timedDropTimer.reset();
         this._timedDropTimer.removeEventListener(TimerEvent.TIMER,this.onTimedDropTimerUpdate);
         Main.instance.game.removeEventListener(LevelEvent.ROUND_START,this.onBossDropFirstRound);
         this._isInitialised = false;
      }
   }
}

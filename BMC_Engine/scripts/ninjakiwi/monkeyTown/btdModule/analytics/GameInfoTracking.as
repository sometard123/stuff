package ninjakiwi.monkeyTown.btdModule.analytics
{
   import ninjakiwi.monkeyTown.btdModule.bloons.Bloon;
   import ninjakiwi.monkeyTown.btdModule.events.BloonEvent;
   import ninjakiwi.monkeyTown.btdModule.game.Game;
   import ninjakiwi.monkeyTown.btdModule.ingame.InGameMenu;
   import ninjakiwi.monkeyTown.btdModule.levels.Level;
   import ninjakiwi.monkeyTown.btdModule.towers.Tower;
   import ninjakiwi.monkeyTown.btdModule.towers.TowerPlace;
   import ninjakiwi.monkeyTown.btdModule.towers.upgrades.UpgradeDef;
   
   public class GameInfoTracking
   {
      
      public static const TRACE_ENABLED:Boolean = false;
      
      public static const CASH_TYPE_POP:int = 0;
      
      public static const CASH_TYPE_FARM:int = 1;
      
      public static const CASH_TYPE_SUPPLY_DROP:int = 2;
      
      public static const CASH_TYPE_HELP_FROM_FRIENDS:int = 3;
      
      public static const CASH_TYPE_BLOON_TRAP:int = 4;
      
      public static const CASH_TYPE_SELL:int = 5;
      
      public static const CASH_TYPE_RETRY:int = 6;
      
      public static const CASH_TYPE_END_OF_ROUND:int = 7;
      
      public static const CASH_TYPE_START:int = 8;
      
      public static const CASH_TYPE_ABILITY_EMPOWER:int = 9;
       
      
      private var _game:Game;
      
      private var _level:Level;
      
      private var _inGameMenu:InGameMenu;
      
      private var _cashEarnedFromPops:Number;
      
      private var _cashEarnedFromFarms:Number;
      
      private var _cashEarnedFromSupplyDrops:Number;
      
      private var _cashEarnedFromHelpFromFriends:Number;
      
      private var _cashEarnedFromBloonTrap:Number;
      
      private var _cashEarnedFromSelling:Number;
      
      private var _cashEarnedFromRetry:Number;
      
      private var _cashEarnedFromEndOfRound:Number;
      
      private var _cashEarnedFromStart:Number;
      
      private var _cashEarnedFromAbilityEmpower:Number;
      
      private var _bloonsSpawned:int;
      
      private var _regenBloonsSpawned:int;
      
      private var _camoBloonsSpawned:int;
      
      private var _bloonsLeaked:int;
      
      private var _bloonsPopped:int;
      
      private var _livesLost:int;
      
      private var _livesGained:int;
      
      private var _towersBuilt:int;
      
      private var _towersSold:int;
      
      private var _cashSpentOnNewTowers:int;
      
      private var _cashSpentOnUpgrades:int;
      
      public function GameInfoTracking()
      {
         super();
         this._game = Main.instance.game;
         this._level = this._game.level;
         this._inGameMenu = this._game.inGameMenu;
         this._level.addEventListener(BloonEvent.ADD,this.onBloonSpawned);
         Bloon.eventDispatcher.addEventListener(BloonEvent.POP,this.onBloonPopped);
         this._level.sigHealthChange.add(this.onLivesChanged);
         this._level.sigBloonLeaked.add(this.onBloonLeaked);
         TowerPlace.towerPlacedSignal.add(this.onTowerPlaced);
         Level.towerSoldSignal.add(this.onTowerSold);
         this._level.sigUpgradePurchaseSignal.add(this.onUpgradePurchased);
      }
      
      public function reset() : void
      {
         this._cashEarnedFromPops = 0;
         this._cashEarnedFromFarms = 0;
         this._cashEarnedFromSupplyDrops = 0;
         this._cashEarnedFromHelpFromFriends = 0;
         this._cashEarnedFromBloonTrap = 0;
         this._cashEarnedFromSelling = 0;
         this._cashEarnedFromRetry = 0;
         this._cashEarnedFromEndOfRound = 0;
         this._cashEarnedFromStart = 0;
         this._cashEarnedFromAbilityEmpower = 0;
         this._bloonsSpawned = 0;
         this._regenBloonsSpawned = 0;
         this._camoBloonsSpawned = 0;
         this._bloonsLeaked = 0;
         this._bloonsPopped = 0;
         this._livesLost = 0;
         this._livesGained = 0;
         this._towersBuilt = 0;
         this._towersSold = 0;
         this._cashSpentOnNewTowers = 0;
         this._cashSpentOnUpgrades = 0;
      }
      
      public function cashEarned(param1:Number, param2:int) : void
      {
         switch(param2)
         {
            case CASH_TYPE_POP:
               this._cashEarnedFromPops = this._cashEarnedFromPops + param1;
               if(!TRACE_ENABLED)
               {
               }
               if(!TRACE_ENABLED)
               {
               }
               break;
            case CASH_TYPE_FARM:
               this._cashEarnedFromFarms = this._cashEarnedFromFarms + param1;
               if(!TRACE_ENABLED)
               {
               }
               if(!TRACE_ENABLED)
               {
               }
               break;
            case CASH_TYPE_SUPPLY_DROP:
               this._cashEarnedFromSupplyDrops = this._cashEarnedFromSupplyDrops + param1;
               if(!TRACE_ENABLED)
               {
               }
               if(!TRACE_ENABLED)
               {
               }
               break;
            case CASH_TYPE_HELP_FROM_FRIENDS:
               this._cashEarnedFromHelpFromFriends = this._cashEarnedFromHelpFromFriends + param1;
               if(!TRACE_ENABLED)
               {
               }
               if(!TRACE_ENABLED)
               {
               }
               break;
            case CASH_TYPE_BLOON_TRAP:
               this._cashEarnedFromBloonTrap = this._cashEarnedFromBloonTrap + param1;
               if(!TRACE_ENABLED)
               {
               }
               if(!TRACE_ENABLED)
               {
               }
               break;
            case CASH_TYPE_SELL:
               this._cashEarnedFromSelling = this._cashEarnedFromSelling + param1;
               if(!TRACE_ENABLED)
               {
               }
               if(!TRACE_ENABLED)
               {
               }
               break;
            case CASH_TYPE_RETRY:
               this._cashEarnedFromRetry = this._cashEarnedFromRetry + param1;
               if(!TRACE_ENABLED)
               {
               }
               if(!TRACE_ENABLED)
               {
               }
               break;
            case CASH_TYPE_END_OF_ROUND:
               this._cashEarnedFromEndOfRound = this._cashEarnedFromEndOfRound + param1;
               if(!TRACE_ENABLED)
               {
               }
               if(!TRACE_ENABLED)
               {
               }
               break;
            case CASH_TYPE_START:
               this._cashEarnedFromStart = this._cashEarnedFromStart + param1;
               if(!TRACE_ENABLED)
               {
               }
               if(!TRACE_ENABLED)
               {
               }
               break;
            case CASH_TYPE_ABILITY_EMPOWER:
               this._cashEarnedFromAbilityEmpower = this._cashEarnedFromAbilityEmpower + param1;
               if(!TRACE_ENABLED)
               {
               }
               if(!TRACE_ENABLED)
               {
               }
               break;
            default:
               if(!TRACE_ENABLED)
               {
               }
         }
      }
      
      private function onBloonSpawned(param1:BloonEvent) : void
      {
         if(param1.bloon.isChild)
         {
            return;
         }
         this._bloonsSpawned = this._bloonsSpawned + param1.bloon.rbe;
         if(!TRACE_ENABLED)
         {
         }
         if(!TRACE_ENABLED)
         {
         }
         if(param1.bloon.isRegen)
         {
            this._regenBloonsSpawned = this._regenBloonsSpawned + param1.bloon.rbe;
            if(!TRACE_ENABLED)
            {
            }
            if(!TRACE_ENABLED)
            {
            }
            if(!TRACE_ENABLED)
            {
            }
         }
         if(param1.bloon.isCamo)
         {
            this._camoBloonsSpawned = this._camoBloonsSpawned + param1.bloon.rbe;
            if(!TRACE_ENABLED)
            {
            }
            if(!TRACE_ENABLED)
            {
            }
            if(!TRACE_ENABLED)
            {
            }
         }
      }
      
      private function onBloonPopped(param1:BloonEvent) : void
      {
         this._bloonsPopped = this._bloonsPopped + param1.layers;
         if(!TRACE_ENABLED)
         {
         }
      }
      
      private function onBloonLeaked(param1:Bloon) : void
      {
         this._bloonsLeaked = this._bloonsLeaked + param1.rbe;
         if(!TRACE_ENABLED)
         {
         }
         if(!TRACE_ENABLED)
         {
         }
      }
      
      private function onLivesChanged(param1:int, param2:int) : void
      {
         if(!TRACE_ENABLED)
         {
         }
         if(param2 > 0)
         {
            this._livesGained = this._livesGained + param2;
            if(!TRACE_ENABLED)
            {
            }
         }
         else if(param2 < 0)
         {
            this._livesLost = this._livesLost + Math.abs(param2);
            if(!TRACE_ENABLED)
            {
            }
         }
      }
      
      private function onTowerPlaced(param1:Tower) : void
      {
         if(false == param1.resellable)
         {
            return;
         }
         this._cashSpentOnNewTowers = this._cashSpentOnNewTowers + param1.spentOn;
         if(!TRACE_ENABLED)
         {
         }
         if(!TRACE_ENABLED)
         {
         }
         this._towersBuilt++;
         if(!TRACE_ENABLED)
         {
         }
         if(!TRACE_ENABLED)
         {
         }
      }
      
      private function onTowerSold(param1:Tower) : void
      {
         var _loc2_:Number = param1.spentOn * this._inGameMenu.sellScale;
         this.cashEarned(_loc2_,CASH_TYPE_SELL);
         this._towersSold++;
         if(!TRACE_ENABLED)
         {
         }
      }
      
      private function onUpgradePurchased(param1:UpgradeDef) : void
      {
         this._cashSpentOnUpgrades = this._cashSpentOnUpgrades + param1.cost;
         if(!TRACE_ENABLED)
         {
         }
         if(!TRACE_ENABLED)
         {
         }
      }
      
      public function getDataAsObject() : Object
      {
         var _loc1_:Object = {
            "cashEarned":{
               "totalCashEarned":this.totalCashEarned,
               "cashEarnedFromPops":this._cashEarnedFromPops,
               "cashEarnedFromFarms":this._cashEarnedFromFarms,
               "cashEarnedFromSupplyDrops":this._cashEarnedFromSupplyDrops,
               "cashEarnedFromHelpFromFriends":this._cashEarnedFromHelpFromFriends,
               "cashEarnedFromBloonTrap":this._cashEarnedFromBloonTrap,
               "cashEarnedFromSelling":this._cashEarnedFromSelling,
               "cashEarnedFromRetry":this._cashEarnedFromRetry,
               "cashEarnedFromEndOfRound":this._cashEarnedFromEndOfRound,
               "cashEarnedFromStart":this._cashEarnedFromStart,
               "cashEarnedFromAbilityEmpower":this._cashEarnedFromAbilityEmpower
            },
            "bloons":{
               "bloonsSpawned":this._bloonsSpawned,
               "regenBloonsSpawned":this._regenBloonsSpawned,
               "camoBloonsSpawned":this._camoBloonsSpawned,
               "bloonsLeaked":this._bloonsLeaked,
               "bloonsPopped":this._bloonsPopped
            },
            "lives":{
               "livesLost":this._livesLost,
               "livesGained":this._livesGained
            },
            "towers":{
               "towersBuilt":this._towersBuilt,
               "towersSold":this._towersSold
            },
            "cashSpent":{
               "totalCashSpent":this.totalCashSpent,
               "cashSpentOnNewTowers":this.cashSpentOnNewTowers,
               "cashSpentOnUpgrades":this.cashSpentOnUpgrades
            }
         };
         return _loc1_;
      }
      
      public function get cashEarnedFromPops() : Number
      {
         return this._cashEarnedFromPops;
      }
      
      public function get cashEarnedFromFarms() : Number
      {
         return this._cashEarnedFromFarms;
      }
      
      public function get cashEarnedFromSupplyDrops() : Number
      {
         return this._cashEarnedFromSupplyDrops;
      }
      
      public function get cashEarnedFromHelpFromFriends() : Number
      {
         return this._cashEarnedFromHelpFromFriends;
      }
      
      public function get cashEarnedFromBloonTrap() : Number
      {
         return this._cashEarnedFromBloonTrap;
      }
      
      public function get cashEarnedFromSelling() : Number
      {
         return this._cashEarnedFromSelling;
      }
      
      public function get cashEarnedFromRetry() : Number
      {
         return this._cashEarnedFromRetry;
      }
      
      public function get cashEarnedFromEndOfRound() : Number
      {
         return this._cashEarnedFromEndOfRound;
      }
      
      public function get cashEarnedFromStart() : Number
      {
         return this._cashEarnedFromStart;
      }
      
      public function get cashEarnedFromAbilityEmpower() : Number
      {
         return this._cashEarnedFromAbilityEmpower;
      }
      
      public function get bloonsSpawned() : int
      {
         return this._bloonsSpawned;
      }
      
      public function get regenBloonsSpawned() : int
      {
         return this._regenBloonsSpawned;
      }
      
      public function get camoBloonsSpawned() : int
      {
         return this._camoBloonsSpawned;
      }
      
      public function get bloonsLeaked() : int
      {
         return this._bloonsLeaked;
      }
      
      public function get bloonsPopped() : int
      {
         return this._bloonsPopped;
      }
      
      public function get livesLost() : int
      {
         return this._livesLost;
      }
      
      public function get livesGained() : int
      {
         return this._livesGained;
      }
      
      public function get towersBuilt() : int
      {
         return this._towersBuilt;
      }
      
      public function get towersSold() : int
      {
         return this._towersSold;
      }
      
      public function get cashSpentOnNewTowers() : int
      {
         return this._cashSpentOnNewTowers;
      }
      
      public function get cashSpentOnUpgrades() : int
      {
         return this._cashSpentOnUpgrades;
      }
      
      public function get totalCashEarned() : Number
      {
         return this._cashEarnedFromPops + this._cashEarnedFromFarms + this._cashEarnedFromSupplyDrops + this._cashEarnedFromHelpFromFriends + this._cashEarnedFromBloonTrap + this._cashEarnedFromSelling + this._cashEarnedFromRetry + this._cashEarnedFromEndOfRound + this._cashEarnedFromStart + this._cashEarnedFromAbilityEmpower;
      }
      
      public function get totalCashSpent() : Number
      {
         return this._cashSpentOnNewTowers + this._cashSpentOnUpgrades;
      }
   }
}

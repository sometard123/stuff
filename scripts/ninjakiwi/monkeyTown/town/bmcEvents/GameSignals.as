package ninjakiwi.monkeyTown.town.bmcEvents
{
   import flash.utils.setTimeout;
   import ninjakiwi.monkeyTown.btd.definitions.TileAttackDefinition;
   import ninjakiwi.monkeyTown.common.btdModule.definitions.BTDGameRequest;
   import ninjakiwi.monkeyTown.common.btdModule.definitions.GameResultDefinition;
   import ninjakiwi.monkeyTown.display.tileSystem.Tile;
   import ninjakiwi.monkeyTown.pvp.PvPAttackDefinition;
   import ninjakiwi.monkeyTown.system.MonkeySystem;
   import ninjakiwi.monkeyTown.town.buildings.customClasses.UpgradeableBuilding;
   import ninjakiwi.monkeyTown.town.data.definitions.UpgradePathStateDefinition;
   import ninjakiwi.monkeyTown.town.data.definitions.UpgradePathTierDefinition;
   import ninjakiwi.monkeyTown.town.monkeyCityMain.WorldViewSignals;
   import ninjakiwi.monkeyTown.town.townMap.TownMap;
   import ninjakiwi.monkeyTown.town.ui.helpFromFriends.CrateStruct;
   import ninjakiwi.monkeyTown.town.ui.helpFromFriends.FriendCrateInfoBox;
   import org.osflash.signals.PrioritySignal;
   import org.osflash.signals.Signal;
   
   public class GameSignals
   {
      
      public static const MODAL_UI_CLOSED:Signal = new Signal();
      
      public static const CREATED_CAPITAL_CITY:Signal = new Signal();
      
      public static const CREATED_SECONDARY_CITY:Signal = new Signal();
      
      public static const UPGRADE_WARMUP_COMPLETE:Signal = new Signal(UpgradePathTierDefinition,UpgradePathStateDefinition);
      
      public static const BUILD_PANEL_CLOSED:Signal = new Signal();
      
      public static const MOUSE_OVER_CAMO_TILE:Signal = new Signal();
      
      public static const MOUSE_OVER_LEAD_TILE:Signal = new Signal();
      
      public static const MOUSE_OVER_MOAB_TILE:Signal = new Signal();
      
      public static const BANKS_FULL:Signal = new Signal();
      
      public static const PVP_DEFENSE:Signal = new Signal();
      
      public static const PVP_DEFENSE_COMPLETE:Signal = new Signal();
      
      public static const PVP_WON_SIGNAL:PrioritySignal = new PrioritySignal(Object);
      
      public static const PVP_LOST_SIGNAL:PrioritySignal = new PrioritySignal(Object);
      
      public static const TUTORIAL_BUILDING_WAS_PLACED:Signal = new Signal(Boolean);
      
      public static const TILE_CAPTURED_SIGNAL:PrioritySignal = new PrioritySignal(Tile,TownMap,TileAttackDefinition);
      
      public static const TREASURE_IS_VISIBLE:Signal = new Signal();
      
      public static const GOT_TREASURE:Signal = new Signal();
      
      public static const SPECIAL_TERRAIN_IS_VISIBLE:Signal = new Signal(String);
      
      public static const TUTORIAL_DISABLE_BASE_BUTTONS:Signal = new Signal();
      
      public static const TUTORIAL_ENABLE_BUTTONS:Signal = new Signal();
      
      public static const TUTORIAL_ENABLE_BASE_BUTTON:Signal = new Signal(String);
      
      public static const BTD_GAME_LAUNCHED_SIGNAL:PrioritySignal = new PrioritySignal(Object);
      
      public static const BTD_GAME_LOST_SIGNAL:PrioritySignal = new PrioritySignal(GameResultDefinition);
      
      public static const BTD_GAME_WON_SIGNAL:PrioritySignal = new PrioritySignal(GameResultDefinition);
      
      public static const BTD_GAME_COMPLETE_SIGNAL:PrioritySignal = new PrioritySignal(GameResultDefinition,TileAttackDefinition,BTDGameRequest);
      
      public static const BTD_RETRY:PrioritySignal = new PrioritySignal(int,int,int,String);
      
      public static const BUILDING_UPGRADE_COMPLETE:PrioritySignal = new PrioritySignal(UpgradeableBuilding);
      
      public static const FIND_PORTAL_SIGNAL:Signal = new Signal();
      
      public static const BLOONTONIUM_GENERATOR_CLICKED:Signal = new Signal();
      
      public static const BANKS_FULL_ANIMATION:Signal = new Signal(Number,Number);
      
      public static const TANKS_FULL_ANIMATION:Signal = new Signal(Number,Number);
      
      public static const BOUGHT_CASH_WITH_BLOONSTONES:PrioritySignal = new PrioritySignal(int,int,int);
      
      public static const BOUGHT_BLOONTONIUM_WITH_BLOONSTONES:PrioritySignal = new PrioritySignal(int,int,int);
      
      public static const PLAYER_USED_BONUS_STARTING_CASH:PrioritySignal = new PrioritySignal(int);
      
      public static const MVM_OVERCLOCKED_WITH_BLOONSTONES:PrioritySignal = new PrioritySignal(int,PvPAttackDefinition);
      
      public static const REPORT_GAME_LAUNCH_STATE:PrioritySignal = new PrioritySignal(String);
      
      public static const TREASURE_CHEST_CAPTURED:PrioritySignal = new PrioritySignal();
      
      public static const POWER_CHANGED:Signal = new PrioritySignal(int);
      
      public static const POWER_CHANGED_DIFF:Signal = new PrioritySignal(int);
      
      public static const NOT_ENOUGH_NK_COINS:Signal = new PrioritySignal();
      
      public static const POWER_USED_CHANGED_DIFF:Signal = new PrioritySignal(int);
      
      public static const LOAD_CITY_BEGIN:Signal = new Signal();
      
      public static const CITY_IS_FINALLY_READY:Signal = new Signal();
      
      {
         setTimeout(function():void
         {
            WorldViewSignals.initialMVMDataReceived.add(function():void
            {
               MonkeySystem.getInstance().map.cityIsReady = true;
               CITY_IS_FINALLY_READY.dispatch();
            });
         },0);
      }
      
      public function GameSignals()
      {
         super();
      }
   }
}

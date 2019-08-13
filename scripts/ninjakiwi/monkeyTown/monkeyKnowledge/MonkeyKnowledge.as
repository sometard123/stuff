package ninjakiwi.monkeyTown.monkeyKnowledge
{
   import com.greensock.TweenLite;
   import flash.display.MovieClip;
   import flash.utils.getTimer;
   import flash.utils.setTimeout;
   import ninjakiwi.dancingShadows.DancingShadows;
   import ninjakiwi.dancingShadows.INumber;
   import ninjakiwi.monkeyTown.common.Constants;
   import ninjakiwi.monkeyTown.data.ResourceStore;
   import ninjakiwi.monkeyTown.system.MonkeySystem;
   import ninjakiwi.monkeyTown.town.gameEvents.GameEventManager;
   import ninjakiwi.monkeyTown.town.monkeyCityMain.WorldViewSignals;
   import ninjakiwi.monkeyTown.town.ui.TownUI;
   import ninjakiwi.monkeyTown.town.ui.eventsMenu.EventsMenuData;
   import ninjakiwi.monkeyTown.town.ui.eventsMenu.EventsMenuItem;
   import ninjakiwi.monkeyTown.ui.HideRevealView;
   import ninjakiwi.monkeyTown.ui.monkeyKnowledge.MonkeyKnowledgePack;
   import ninjakiwi.monkeyTown.ui.panelManager.PanelManager;
   import org.osflash.signals.Signal;
   
   public class MonkeyKnowledge
   {
      
      public static const syncUIElementSignal:Signal = new Signal(String,Number);
      
      public static const HAS_RECIEVED_INTRO_PACK:String = "hasRecievedIntroPack";
      
      public static const HAS_SEEN_TUTORIAL:String = "hasSeenTutorial";
      
      public static const COMMON:String = "Common";
      
      public static const UNCOMMON:String = "Uncommon";
      
      public static const RARE:String = "Rare";
      
      public static const LEGENDARY:String = "Legendary";
      
      public static const FLAGS_KEY:String = "Flags";
      
      public static const UNOPENED_PACKS_KEY:String = "KnowledgePacks";
      
      public static const UNOPENED_ANCIENT_PACKS_KEY:String = "AncientPacks";
      
      public static const UNOPENED_WILDCARD_PACKS_KEY:String = "WildcardPacks";
      
      public static const PROBABILITY_STATS_KEY:String = "KnowledgeStats";
      
      public static const UNLOCK_AT_LEVEL:int = 12;
      
      public static const MAX_RANK:int = 15;
      
      private static var instance:MonkeyKnowledge;
       
      
      private var _tree:MonkeyKnowledgeTree;
      
      private var _unopenedPacks:INumber;
      
      private var _unopenedAncientPacks:INumber;
      
      private var _unopenedWildcardPacks:INumber;
      
      private var _hasSeenTutorial:Boolean = false;
      
      private var _flags:Object = null;
      
      public const dataPopulatedSignal:Signal = new Signal();
      
      public const unopenedPacksChangedSignal:Signal = new Signal(int);
      
      public const unopenedAncientPacksChangedSignal:Signal = new Signal(int);
      
      public const unopenedWildcardPacksChangedSignal:Signal = new Signal(int);
      
      public const monkeyKnowledgePersistence:MonkeyKnowledgePersistence = MonkeyKnowledgePersistence.getInstance();
      
      private const rewards:MonkeyKnowledgeRewards = MonkeyKnowledgeRewards.getInstance();
      
      private var monkeyKnowledgeButton:MovieClip = null;
      
      public function MonkeyKnowledge(param1:SingletonEnforcer#1053)
      {
         this._tree = MonkeyKnowledgeTree.getInstance();
         this._unopenedPacks = DancingShadows.getOne();
         this._unopenedAncientPacks = DancingShadows.getOne();
         this._unopenedWildcardPacks = DancingShadows.getOne();
         super();
         if(param1 == null)
         {
            throw new Error("Error: Instantiation failed: Use MonkeyKnowledge.getInstance() instead of new.");
         }
         this.init();
      }
      
      public static function getInstance() : MonkeyKnowledge
      {
         if(instance == null)
         {
            instance = new MonkeyKnowledge(new SingletonEnforcer#1053());
         }
         return instance;
      }
      
      private function init() : void
      {
         WorldViewSignals.initialMVMDataReceived.add(this.checkForUnlock);
      }
      
      private function checkForUnlock(... rest) : void
      {
         this.monkeyKnowledgeButton = TownUI.getInstance().bottomUI.openMonkeyKnowledeButton.clip;
         if(MonkeySystem.getInstance().city.cityIndex != 0)
         {
            this.revealMonkeyKnowledgeButton();
         }
         var _loc2_:Boolean = this.getFlag(HAS_RECIEVED_INTRO_PACK);
         if(_loc2_)
         {
            this.revealMonkeyKnowledgeButton();
            return;
         }
         if(ResourceStore.getInstance().townLevel >= UNLOCK_AT_LEVEL)
         {
            this.unopenedPacks = this.unopenedPacks + 1;
            PanelManager.getInstance().showPanel(TownUI.getInstance().monkeyKnowledgeIntroPanel);
            this.setFlag(HAS_RECIEVED_INTRO_PACK,true);
            this.revealMonkeyKnowledgeButton();
         }
         else
         {
            ResourceStore.getInstance().townLevelChangedDiffSignal.remove(this.checkForUnlock);
            ResourceStore.getInstance().townLevelChangedDiffSignal.add(this.checkForUnlock);
         }
      }
      
      private function revealMonkeyKnowledgeButton() : void
      {
         setTimeout(function():void
         {
            monkeyKnowledgeButton.alpha = 0;
            monkeyKnowledgeButton.visible = true;
            TweenLite.to(monkeyKnowledgeButton,0.5,{"alpha":1});
         },1000);
      }
      
      public function winPack(param1:int = 0) : void
      {
         if(param1 == MonkeyKnowledgePack.STANDARD_PACK)
         {
            _loc2_.unopenedPacks = _loc3_;
         }
         else if(param1 == MonkeyKnowledgePack.ANCIENT_PACK)
         {
            this.unopenedAncientPacks++;
         }
      }
      
      public function winPacks(param1:Array) : void
      {
         var _loc2_:int = 0;
         while(_loc2_ < param1.length)
         {
            this.winPack(param1[_loc2_]);
            _loc2_++;
         }
      }
      
      public function populateFromSaveData(param1:Object) : void
      {
         this._tree.populateFromSaveData(param1);
         this._unopenedPacks.value = !!param1.hasOwnProperty(UNOPENED_PACKS_KEY)?Number(param1[UNOPENED_PACKS_KEY].packs):Number(0);
         this._unopenedAncientPacks.value = !!param1.hasOwnProperty(UNOPENED_ANCIENT_PACKS_KEY)?Number(param1[UNOPENED_ANCIENT_PACKS_KEY].packs):Number(0);
         this._unopenedWildcardPacks.value = !!param1.hasOwnProperty(UNOPENED_WILDCARD_PACKS_KEY)?Number(param1[UNOPENED_WILDCARD_PACKS_KEY].packs):Number(0);
         this._flags = !!param1.hasOwnProperty(FLAGS_KEY)?param1[FLAGS_KEY]:{};
         if(param1.hasOwnProperty(PROBABILITY_STATS_KEY))
         {
            MonkeyKnowledgePack.setSaveData(param1[PROBABILITY_STATS_KEY]);
         }
         this.dataPopulatedSignal.dispatch();
      }
      
      public function get unopenedPacks() : int
      {
         return this._unopenedPacks.value;
      }
      
      public function set unopenedPacks(param1:int) : void
      {
         if(param1 === int(this._unopenedPacks.value))
         {
            return;
         }
         if(param1 < 0)
         {
            param1 = 0;
         }
         this._unopenedPacks.value = param1;
         MonkeyKnowledgePersistence.getInstance().saveValue(UNOPENED_PACKS_KEY,{"packs":this._unopenedPacks.value});
         this.unopenedPacksChangedSignal.dispatch(this._unopenedPacks.value);
      }
      
      public function get unopenedAncientPacks() : int
      {
         return this._unopenedAncientPacks.value;
      }
      
      public function set unopenedAncientPacks(param1:int) : void
      {
         if(param1 === int(this._unopenedAncientPacks.value))
         {
            return;
         }
         if(param1 < 0)
         {
            param1 = 0;
         }
         this._unopenedAncientPacks.value = param1;
         MonkeyKnowledgePersistence.getInstance().saveValue(UNOPENED_ANCIENT_PACKS_KEY,{"packs":this._unopenedAncientPacks.value});
         this.unopenedAncientPacksChangedSignal.dispatch(this._unopenedAncientPacks.value);
      }
      
      public function get unopenedWildcardPacks() : int
      {
         return this._unopenedWildcardPacks.value;
      }
      
      public function set unopenedWildcardPacks(param1:int) : void
      {
         if(param1 === int(this._unopenedWildcardPacks.value))
         {
            return;
         }
         if(param1 < 0)
         {
            param1 = 0;
         }
         this._unopenedWildcardPacks.value = param1;
         MonkeyKnowledgePersistence.getInstance().saveValue(UNOPENED_WILDCARD_PACKS_KEY,{"packs":this._unopenedWildcardPacks.value});
         this.unopenedWildcardPacksChangedSignal.dispatch(this._unopenedWildcardPacks.value);
      }
      
      private function getFlagsSaveData() : Object
      {
         return JSON.parse(JSON.stringify(this._flags));
      }
      
      private function setFlag(param1:String, param2:Boolean) : void
      {
         if(this._flags == null)
         {
            return;
         }
         this._flags[param1] = param2;
         MonkeyKnowledgePersistence.getInstance().saveValue(FLAGS_KEY,this.getFlagsSaveData());
      }
      
      private function getFlag(param1:String) : Boolean
      {
         if(this._flags == null)
         {
            return false;
         }
         if(this._flags.hasOwnProperty(param1) == false)
         {
            return false;
         }
         return this._flags[param1];
      }
      
      public function get hasSeenTutorial() : Boolean
      {
         return this.getFlag(HAS_SEEN_TUTORIAL);
      }
      
      public function set hasSeenTutorial(param1:Boolean) : void
      {
         this.setFlag(HAS_SEEN_TUTORIAL,param1);
      }
      
      public function get hasRecievedIntroPack() : Boolean
      {
         return this.getFlag(HAS_RECIEVED_INTRO_PACK);
      }
   }
}

class SingletonEnforcer#1053
{
    
   
   function SingletonEnforcer#1053()
   {
      super();
   }
}

package ninjakiwi.monkeyTown.town.quests
{
   import ninjakiwi.data.NKDefinition;
   import ninjakiwi.monkeyTown.net.Squeeze;
   import ninjakiwi.monkeyTown.pvp.Pacifist;
   import ninjakiwi.monkeyTown.pvp.PvPAttackDefinition;
   import ninjakiwi.monkeyTown.pvp.PvPTimerObject;
   import ninjakiwi.monkeyTown.system.MonkeySystem;
   import ninjakiwi.monkeyTown.town.gameEvents.GameplayEvent;
   import ninjakiwi.monkeyTown.town.monkeyCityMain.WorldView;
   import ninjakiwi.monkeyTown.town.ui.TownUI;
   import ninjakiwi.monkeyTown.town.ui.eventsMenu.menuItems.icons.BloonBeaconIcon;
   import ninjakiwi.monkeyTown.ui.HideRevealView;
   import org.osflash.signals.Signal;
   
   public class QuestDefinition extends NKDefinition
   {
      
      protected static const _propertyNames:Array = ["id","completingID","reachingMCL","name","description","rewardXP","rewardMonkeyMoney","type","achieveSignal","longDescription","symbolFrame","cityAvailability"];
       
      
      public var id:String;
      
      public var completingID:String = null;
      
      public var reachingMCL:int = 0;
      
      public var name:String = "";
      
      public var description:String = "";
      
      public var rewardXP:int = 0;
      
      public var rewardMonkeyMoney:int = 0;
      
      public var type:String = "";
      
      public var achieveSignal:Signal = null;
      
      public var longDescription:String = "";
      
      public var symbolFrame:int = 1;
      
      public var cityAvailability:Array;
      
      public function QuestDefinition()
      {
         this.cityAvailability = [0];
         super();
      }
      
      public function Id(param1:String) : QuestDefinition
      {
         this.id = param1;
         return this;
      }
      
      public function CompletingID(param1:String) : QuestDefinition
      {
         this.completingID = param1;
         return this;
      }
      
      public function ReachingMCL(param1:int) : QuestDefinition
      {
         this.reachingMCL = param1;
         return this;
      }
      
      public function Name(param1:String) : QuestDefinition
      {
         this.name = param1;
         return this;
      }
      
      public function Description(param1:String) : QuestDefinition
      {
         this.description = param1;
         return this;
      }
      
      public function RewardXP(param1:int) : QuestDefinition
      {
         this.rewardXP = param1;
         return this;
      }
      
      public function RewardMonkeyMoney(param1:int) : QuestDefinition
      {
         this.rewardMonkeyMoney = param1;
         return this;
      }
      
      public function Type(param1:String) : QuestDefinition
      {
         this.type = param1;
         return this;
      }
      
      public function AchieveSignal(param1:Signal) : QuestDefinition
      {
         this.achieveSignal = param1;
         return this;
      }
      
      public function LongDescription(param1:String) : QuestDefinition
      {
         this.longDescription = param1;
         return this;
      }
      
      public function SymbolFrame(param1:int) : QuestDefinition
      {
         this.symbolFrame = param1;
         return this;
      }
      
      public function CityAvailability(param1:Array) : QuestDefinition
      {
         this.cityAvailability = param1;
         return this;
      }
   }
}

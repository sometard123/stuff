package ninjakiwi.monkeyTown.achievements
{
   import flash.geom.ColorTransform;
   import ninjakiwi.data.NKDefinition;
   import ninjakiwi.monkeyTown.Main;
   import ninjakiwi.monkeyTown.btd.BTDView;
   import ninjakiwi.monkeyTown.pvp.IncomingRaid;
   import ninjakiwi.monkeyTown.town.gameEvents.GameEventManager;
   import ninjakiwi.monkeyTown.town.gameEvents.ui.OccupationRewardInfoBox;
   import ninjakiwi.monkeyTown.town.monkeyCityMain.WorldView;
   import ninjakiwi.monkeyTown.town.monkeyCityMain.WorldViewSignals;
   import ninjakiwi.monkeyTown.town.ui.contestedTerritory.ContestedTerritoryPanel;
   
   public class AchievementDefinition extends NKDefinition
   {
      
      protected static const _propertyNames:Array = ["id","name","description","type","awesomeEarned","nkAchievementIndex"];
       
      
      public var id:String;
      
      public var name:String = "UnnamedAchievement";
      
      public var description:String;
      
      public var type:String;
      
      public var awesomeEarned:int = 0;
      
      public var nkAchievementIndex:int = -1;
      
      public function AchievementDefinition()
      {
         super();
      }
      
      public function Id(param1:String) : AchievementDefinition
      {
         this.id = param1;
         return this;
      }
      
      public function Name(param1:String) : AchievementDefinition
      {
         this.name = param1;
         return this;
      }
      
      public function Description(param1:String) : AchievementDefinition
      {
         this.description = param1;
         return this;
      }
      
      public function Type(param1:String) : AchievementDefinition
      {
         this.type = param1;
         return this;
      }
      
      public function AwesomeEarned(param1:int) : AchievementDefinition
      {
         this.awesomeEarned = param1;
         return this;
      }
      
      public function NkAchievementIndex(param1:int) : AchievementDefinition
      {
         this.nkAchievementIndex = param1;
         return this;
      }
   }
}

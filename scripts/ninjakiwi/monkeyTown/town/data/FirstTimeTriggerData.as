package ninjakiwi.monkeyTown.town.data
{
   import ninjakiwi.monkeyTown.town.data.definitions.FirstTimeTriggerDefinition;
   
   public class FirstTimeTriggerData
   {
      
      private static var _instance:FirstTimeTriggerData;
       
      
      public const TUTORIAL_WELCOME:FirstTimeTriggerDefinition = new FirstTimeTriggerDefinition().Id("TutorialWelcome").Sequence(["WelcomeStep1","WelcomeStep2","WelcomeStep3","WelcomeStep4","WelcomeStep5"]);
      
      public const TUTORIAL_BTD:FirstTimeTriggerDefinition = new FirstTimeTriggerDefinition().Id("TutorialBTD").Sequence(["TutorialBTDStep1","TutorialBTDStep2","TutorialBTDStep3","TutorialBTDStep4","TutorialBTDStep5","TutorialBTDStep6","TutorialBTDStep7"]);
      
      public const TUTORIAL_BUILDING:FirstTimeTriggerDefinition = new FirstTimeTriggerDefinition().Id("TutorialBuilding").Sequence(["TutorialBuilding"]);
      
      public const TUTORIAL_WAITING:FirstTimeTriggerDefinition = new FirstTimeTriggerDefinition().Id("TutorialWaiting").Sequence(["TutorialWaiting"]);
      
      public const TUTORIAL_SECOND_TILE_CAPTURED:FirstTimeTriggerDefinition = new FirstTimeTriggerDefinition().Id("TutorialFirstBuildingComplete").Sequence(["TutorialFirstBuildingCompleteStep1","TutorialFirstBuildingCompleteStep3","TutorialFirstBuildingCompleteStep4"]);
      
      public const TUTORIAL_BUILD_MONKEY_ACADEMY:FirstTimeTriggerDefinition = new FirstTimeTriggerDefinition().Id("TutorialBuildMonkeyAcademy").Sequence(["TutorialBuildMonkeyAcademyStep1","TutorialBuildMonkeyAcademyStep2","TutorialBuildMonkeyAcademyStep3","TutorialBuildMonkeyAcademyStep4"]);
      
      public const FIRST_CAMO_BLOONS:FirstTimeTriggerDefinition = new FirstTimeTriggerDefinition().Id("FirstCamoBloons").Sequence(["FirstCamoBloons"]);
      
      public const FIRST_LEAD_BLOONS:FirstTimeTriggerDefinition = new FirstTimeTriggerDefinition().Id("FirstLeadBloons").Sequence(["FirstLeadBloons"]);
      
      public const FIRST_MOABS:FirstTimeTriggerDefinition = new FirstTimeTriggerDefinition().Id("FirstMOABs").Sequence(["FirstMOABs"]);
      
      public const FIRST_HARD:FirstTimeTriggerDefinition = new FirstTimeTriggerDefinition().Id("FirstHard").Sequence(["FirstHard"]);
      
      public const BANKS_ARE_FULL:FirstTimeTriggerDefinition = new FirstTimeTriggerDefinition().Id("BanksAreFull").Sequence(["BanksAreFull"]);
      
      public const FIRST_PVP_DEFENSE:FirstTimeTriggerDefinition = new FirstTimeTriggerDefinition().Id("FirstPVPDefense").Sequence(["FirstPVPDefense"]);
      
      public const FIRST_PVP_DEFENSE_COMPLETE:FirstTimeTriggerDefinition = new FirstTimeTriggerDefinition().Id("FirstPVPDefenseComplete").Sequence(["FirstPVPDefenseComplete"]);
      
      public const POWER_FULL:FirstTimeTriggerDefinition = new FirstTimeTriggerDefinition().Id("PowerFull").Sequence(["PowerFull"]);
      
      public const NEED_BLOONTONIUM_STORAGE:FirstTimeTriggerDefinition = new FirstTimeTriggerDefinition().Id("NeedBloontoniumStorage").Sequence(["NeedBloontoniumStorage"]);
      
      public const FILL_BLOONTONIUM:FirstTimeTriggerDefinition = new FirstTimeTriggerDefinition().Id("FillBloontonium").Sequence(["FillBloontonium"]);
      
      public const FIRST_CAMO_ASSAULT:FirstTimeTriggerDefinition = new FirstTimeTriggerDefinition().Id("FirstCamoAssault").Sequence(["FirstCamoAssault"]);
      
      public const FIRST_REGROW_ASSAULT:FirstTimeTriggerDefinition = new FirstTimeTriggerDefinition().Id("FirstRegrowAssault").Sequence(["FirstRegrowAssault"]);
      
      private var firstTimeTriggerDefinitions:Array;
      
      public function FirstTimeTriggerData(param1:SingletonEnforcer#1346)
      {
         this.firstTimeTriggerDefinitions = [this.TUTORIAL_WELCOME,this.TUTORIAL_BUILDING,this.TUTORIAL_WAITING,this.TUTORIAL_SECOND_TILE_CAPTURED,this.TUTORIAL_BUILD_MONKEY_ACADEMY,this.FIRST_CAMO_BLOONS,this.FIRST_LEAD_BLOONS,this.FIRST_MOABS,this.BANKS_ARE_FULL,this.FIRST_PVP_DEFENSE,this.FIRST_PVP_DEFENSE_COMPLETE,this.POWER_FULL,this.NEED_BLOONTONIUM_STORAGE,this.FILL_BLOONTONIUM,this.FIRST_HARD,this.FIRST_CAMO_ASSAULT,this.FIRST_REGROW_ASSAULT];
         super();
         if(param1 == null)
         {
            throw new Error("Error: Instantiation failed: Use FirstTimeTriggerData.getInstance() instead of new.");
         }
      }
      
      public static function getInstance() : FirstTimeTriggerData
      {
         if(_instance == null)
         {
            _instance = new FirstTimeTriggerData(new SingletonEnforcer#1346());
         }
         return _instance;
      }
      
      public function initDataFromObject(param1:Object) : void
      {
         var _loc2_:FirstTimeTriggerDefinition = null;
         var _loc4_:String = null;
         var _loc5_:int = 0;
         var _loc3_:int = 0;
         while(_loc3_ < this.firstTimeTriggerDefinitions.length)
         {
            _loc2_ = this.firstTimeTriggerDefinitions[_loc3_];
            if(_loc2_.sequence.length > 1)
            {
            }
            _loc5_ = 0;
            while(_loc5_ < _loc2_.sequence.length)
            {
               _loc4_ = _loc2_.sequence[_loc5_];
               _loc2_.eventText.push(param1[_loc4_].text);
               _loc2_.buttonTypes.push(param1[_loc4_].buttonType);
               _loc5_++;
            }
            _loc3_++;
         }
      }
   }
}

class SingletonEnforcer#1346
{
    
   
   function SingletonEnforcer#1346()
   {
      super();
   }
}

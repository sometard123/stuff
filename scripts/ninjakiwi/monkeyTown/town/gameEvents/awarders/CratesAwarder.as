package ninjakiwi.monkeyTown.town.gameEvents.awarders
{
   import ninjakiwi.monkeyTown.smallEvents.bloonstoneSpendEvent.BloonstoneSpendMilestone;
   import ninjakiwi.monkeyTown.town.data.BloonResearchLabUpgrades;
   import ninjakiwi.monkeyTown.town.helpFromFriends.CrateManager;
   
   public class CratesAwarder extends Awarder
   {
       
      
      public function CratesAwarder(param1:Number)
      {
         super(param1);
      }
      
      override public function award() : void
      {
         CrateManager.getInstance().addNewCrates(_quantity.value);
      }
   }
}

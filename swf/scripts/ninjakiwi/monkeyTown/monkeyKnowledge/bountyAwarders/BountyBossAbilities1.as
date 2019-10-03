package ninjakiwi.monkeyTown.monkeyKnowledge.bountyAwarders
{
   import flash.events.MouseEvent;
   import ninjakiwi.monkeyTown.data.ResourceStore;
   import ninjakiwi.monkeyTown.town.gameEvents.awarders.Awarder;
   
   public class BountyBossAbilities1 extends Awarder
   {
       
      
      public function BountyBossAbilities1()
      {
         super(1);
      }
      
      override public function award() : void
      {
         ResourceStore.getInstance().bossBanes++;
         ResourceStore.getInstance().bossBlasts++;
         ResourceStore.getInstance().bossChills++;
         ResourceStore.getInstance().bossWeakens++;
      }
   }
}

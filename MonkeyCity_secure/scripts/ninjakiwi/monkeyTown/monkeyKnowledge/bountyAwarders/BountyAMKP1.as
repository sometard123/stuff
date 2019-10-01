package ninjakiwi.monkeyTown.monkeyKnowledge.bountyAwarders
{
   import ninjakiwi.monkeyTown.monkeyKnowledge.MonkeyKnowledge;
   import ninjakiwi.monkeyTown.town.gameEvents.awarders.AncientKnowledgePackAwarder;
   import ninjakiwi.monkeyTown.ui.monkeyKnowledge.MonkeyKnowledgePack;
   
   public class BountyAMKP1 extends AncientKnowledgePackAwarder
   {
       
      
      public function BountyAMKP1()
      {
         super(1);
      }
      
      override public function dispatchUISyncSignal() : void
      {
         MonkeyKnowledge.syncUIElementSignal.dispatch(MonkeyKnowledgePack.ANCIENT_PACK_KEY,quantity);
      }
   }
}

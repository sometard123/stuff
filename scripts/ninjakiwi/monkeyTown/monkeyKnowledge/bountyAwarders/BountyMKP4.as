package ninjakiwi.monkeyTown.monkeyKnowledge.bountyAwarders
{
   import ninjakiwi.monkeyTown.friends.FriendsManager;
   import ninjakiwi.monkeyTown.monkeyKnowledge.MonkeyKnowledge;
   import ninjakiwi.monkeyTown.town.gameEvents.awarders.KnowledgePackAwarder;
   import ninjakiwi.monkeyTown.ui.monkeyKnowledge.MonkeyKnowledgePack;
   
   public class BountyMKP4 extends KnowledgePackAwarder
   {
       
      
      public function BountyMKP4()
      {
         super(4);
      }
      
      override public function dispatchUISyncSignal() : void
      {
         MonkeyKnowledge.syncUIElementSignal.dispatch(MonkeyKnowledgePack.STANDARD_PACK_KEY,quantity);
      }
   }
}

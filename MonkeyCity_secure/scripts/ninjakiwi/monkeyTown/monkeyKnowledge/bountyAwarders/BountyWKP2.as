package ninjakiwi.monkeyTown.monkeyKnowledge.bountyAwarders
{
   import ninjakiwi.monkeyTown.monkeyKnowledge.MonkeyKnowledge;
   import ninjakiwi.monkeyTown.town.gameEvents.awarders.WildcardKnowledgePackAwarder;
   import ninjakiwi.monkeyTown.ui.monkeyKnowledge.MonkeyKnowledgePack;
   
   public class BountyWKP2 extends WildcardKnowledgePackAwarder
   {
       
      
      public function BountyWKP2()
      {
         super(2);
      }
      
      override public function dispatchUISyncSignal() : void
      {
         MonkeyKnowledge.syncUIElementSignal.dispatch(MonkeyKnowledgePack.WILDCARD_PACK_KEY,quantity);
      }
   }
}

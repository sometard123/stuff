package ninjakiwi.monkeyTown.town.gameEvents.awarders
{
   import ninjakiwi.monkeyTown.monkeyKnowledge.MonkeyKnowledge;
   
   public class AncientKnowledgePackAwarder extends Awarder
   {
       
      
      public function AncientKnowledgePackAwarder(param1:Number)
      {
         super(param1);
      }
      
      override public function award() : void
      {
         MonkeyKnowledge.getInstance().unopenedAncientPacks = MonkeyKnowledge.getInstance().unopenedAncientPacks + _quantity.value;
      }
   }
}

package ninjakiwi.monkeyTown.monkeyKnowledge
{
   import flash.utils.setTimeout;
   import ninjakiwi.monkeyTown.ui.monkeyKnowledge.MonkeyKnowledgeCardSpread;
   import ninjakiwi.monkeyTown.ui.monkeyKnowledge.MonkeyKnowledgePack;
   
   public class UnopenedPack
   {
       
      
      public var index:int = 0;
      
      public var pack:MonkeyKnowledgePack = null;
      
      public var cardSpread:MonkeyKnowledgeCardSpread;
      
      public function UnopenedPack(param1:int)
      {
         super();
         this.pack = new MonkeyKnowledgePack(param1);
         this.cardSpread = new MonkeyKnowledgeCardSpread(this.pack);
      }
   }
}

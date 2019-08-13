package ninjakiwi.monkeyTown.town.gameEvents.awarders
{
   import flash.display.DisplayObjectContainer;
   import flash.display.Loader;
   import flash.display.LoaderInfo;
   import flash.events.Event;
   import flash.net.URLRequest;
   import flash.system.Security;
   import ninjakiwi.monkeyTown.monkeyKnowledge.MonkeyKnowledge;
   import ninjakiwi.monkeyTown.ui.monkeyKnowledge.KnowledgeParticlesPool;
   import ninjakiwi.monkeyTown.userServices.kong.Kong;
   
   public class WildcardKnowledgePackAwarder extends Awarder
   {
       
      
      public function WildcardKnowledgePackAwarder(param1:Number)
      {
         super(param1);
      }
      
      override public function award() : void
      {
         MonkeyKnowledge.getInstance().unopenedWildcardPacks = MonkeyKnowledge.getInstance().unopenedWildcardPacks + _quantity.value;
      }
   }
}

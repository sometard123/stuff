package ninjakiwi.monkeyTown.testing.APITests
{
   import ninjakiwi.monkeyTown.monkeyKnowledge.MonkeyKnowledge;
   import ninjakiwi.monkeyTown.monkeyKnowledge.MonkeyKnowledgePersistence;
   
   public class LoadCoreTest
   {
       
      
      private var lastKey:int = 0;
      
      private var iterationCount:int = 0;
      
      public function LoadCoreTest()
      {
         super();
      }
      
      public function start() : void
      {
      }
      
      private function loadCoreCallback(param1:Object) : void
      {
         if(this.iterationCount++ !== 0 && param1.monkeyKnowledge.Flags.hasOwnProperty("test"))
         {
            if(param1.monkeyKnowledge.Flags.test !== this.lastKey)
            {
            }
         }
         this.lastKey = int(Math.random() * int.MAX_VALUE);
         param1.monkeyKnowledge.Flags.test = this.lastKey;
         MonkeyKnowledgePersistence.getInstance().saveValue(MonkeyKnowledge.FLAGS_KEY,param1.monkeyKnowledge.Flags);
      }
      
      private function onKnowledgeSaved() : void
      {
         this.start();
      }
   }
}

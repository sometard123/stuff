package ninjakiwi.monkeyTown.transition
{
   public interface Transitionable
   {
       
      
      function prepareToReveal() : void;
      
      function prepareToExit() : void;
      
      function arriveAfterTransition() : void;
      
      function sleepAfterExit() : void;
   }
}

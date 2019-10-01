package ninjakiwi.monkeyTown.utils
{
   public class Random
   {
      
      private static const MULTIPLIER:Number = 16807;
      
      public static var reportUsecountFlag:Boolean = false;
       
      
      protected var initialSeed:uint;
      
      protected var currentSeed:uint;
      
      protected var useCount:uint = 0;
      
      public function Random(param1:uint = 1)
      {
         super();
         this.currentSeed = this.initialSeed = param1;
      }
      
      public function setSeed(param1:uint) : void
      {
         if(reportUsecountFlag)
         {
            this.reportUseCount();
         }
         this.currentSeed = this.initialSeed = param1;
         this.useCount = 0;
      }
      
      public function reportUseCount() : void
      {
      }
      
      public function nextInteger(param1:int = 0) : int
      {
         this.useCount++;
         this.currentSeed = this.currentSeed * MULTIPLIER % int.MAX_VALUE;
         if(param1 > 0)
         {
            return this.currentSeed % param1;
         }
         return this.currentSeed;
      }
      
      public function nextNumber(param1:Number = 0) : Number
      {
         var _loc2_:Number = this.nextInteger() / (int.MAX_VALUE - 1);
         if(param1 > 0)
         {
            return _loc2_ * param1;
         }
         return _loc2_;
      }
      
      public function sign() : int
      {
         if(this.nextNumber() < 0.5)
         {
            return 1;
         }
         return -1;
      }
   }
}

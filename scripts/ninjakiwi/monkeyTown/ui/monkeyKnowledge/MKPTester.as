package ninjakiwi.monkeyTown.ui.monkeyKnowledge
{
   import flash.display.MovieClip;
   
   public class MKPTester extends MovieClip
   {
       
      
      private const STRESS:int = 1000;
      
      public function MKPTester()
      {
         super();
         this.test1();
      }
      
      private function test1() : void
      {
         var _loc4_:MonkeyKnowledgePack = null;
         var _loc5_:* = false;
         var _loc1_:Array = [];
         var _loc2_:Array = [];
         MonkeyKnowledgePack._state.reset();
         var _loc3_:int = 0;
         while(_loc3_ < this.STRESS)
         {
            _loc4_ = new MonkeyKnowledgePack();
            _loc5_ = Boolean(this.checkHasBounty(_loc4_));
            if(this.checkHasBounty(_loc4_))
            {
               _loc1_.push(_loc3_);
               if(this.checkHasSecret(_loc4_))
               {
                  _loc2_.push(_loc3_);
               }
            }
            _loc3_++;
         }
      }
      
      private function checkHasBounty(param1:MonkeyKnowledgePack) : Boolean
      {
         var _loc2_:int = 0;
         while(_loc2_ < param1.tokens.length)
         {
            if(param1.tokens[_loc2_].type === MonkeyKnowledgeCard.BOUNTY_CARD)
            {
               return true;
            }
            _loc2_++;
         }
         return false;
      }
      
      private function checkHasSecret(param1:MonkeyKnowledgePack) : Boolean
      {
         var _loc2_:int = 0;
         while(_loc2_ < param1.tokens.length)
         {
            if(param1.tokens[_loc2_].subType === MonkeyKnowledgeCard.BOUNTY_SECRET_CARD)
            {
               return true;
            }
            _loc2_++;
         }
         return false;
      }
   }
}

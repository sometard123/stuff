package ninjakiwi.monkeyTown.monkeyKnowledge
{
   public class MonkeyKnowledgeToken
   {
       
      
      public var type:String = null;
      
      public var subType:String = null;
      
      public var quality:String = null;
      
      public var points:int = 0;
      
      public function MonkeyKnowledgeToken()
      {
         super();
      }
      
      public function clone() : MonkeyKnowledgeToken
      {
         var _loc1_:MonkeyKnowledgeToken = new MonkeyKnowledgeToken();
         _loc1_.type = this.type;
         _loc1_.quality = this.quality;
         _loc1_.points = this.points;
         return _loc1_;
      }
   }
}

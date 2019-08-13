package ninjakiwi.monkeyTown.monkeyKnowledge
{
   import ninjakiwi.monkeyTown.data.KeyValueStore;
   import ninjakiwi.monkeyTown.data.ResourceStore;
   import ninjakiwi.monkeyTown.saleEvents.SaleEventData;
   import ninjakiwi.monkeyTown.saleEvents.ui.KnowledgePackSaleIntroPanel;
   import org.osflash.signals.Signal;
   
   public class SecretAwarder
   {
      
      public static const rankUpSignal:Signal = new Signal(String);
       
      
      public function SecretAwarder()
      {
         super();
      }
      
      public static function givePoints() : void
      {
         var _loc1_:MonkeyKnowledgeTree = MonkeyKnowledgeTree.getInstance();
         var _loc2_:Array = MonkeyKnowledgePortraitData.allAvatarIDs;
         var _loc3_:int = 0;
         while(_loc3_ < _loc2_.length)
         {
            _loc1_.awardPoints(_loc2_[_loc3_],KnowledgeBounty.SECRET_POINTS);
            _loc3_++;
         }
      }
      
      public static function updatePath(param1:String) : Boolean
      {
         var _loc2_:MonkeyKnowledgeTree = MonkeyKnowledgeTree.getInstance();
         var _loc3_:MonkeyKnowledgePath = _loc2_.getPath(param1);
         var _loc4_:MonkeyKnowledgePath = _loc3_.clone();
         var _loc5_:Boolean = false;
         _loc3_.displayPoints = _loc3_.displayPoints + KnowledgeBounty.SECRET_POINTS;
         if(_loc3_.displayRank > _loc4_.displayRank)
         {
            _loc5_ = true;
            rankUpSignal.dispatch(param1);
         }
         return _loc5_;
      }
   }
}

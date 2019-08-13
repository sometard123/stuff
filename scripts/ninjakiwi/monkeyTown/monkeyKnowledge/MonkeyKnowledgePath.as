package ninjakiwi.monkeyTown.monkeyKnowledge
{
   import ninjakiwi.dancingShadows.DancingShadows;
   import ninjakiwi.dancingShadows.INumber;
   import org.osflash.signals.Signal;
   
   public class MonkeyKnowledgePath
   {
      
      private static const RANK_STEP:int = 2500;
      
      private static const NUMBER_OF_RANKS:int = 15;
      
      private static const rankThresholds:Array = [50,200,1000,2500,5000];
      
      {
         initRankThresholds();
      }
      
      public var id:String = null;
      
      private var _points:INumber;
      
      private var _rank:INumber;
      
      private var _displayPoints:INumber;
      
      private var _displayRank:INumber;
      
      public const changedSignal:Signal = new Signal();
      
      public function MonkeyKnowledgePath()
      {
         this._points = DancingShadows.getOne();
         this._rank = DancingShadows.getOne();
         this._displayPoints = DancingShadows.getOne();
         this._displayRank = DancingShadows.getOne();
         super();
      }
      
      private static function initRankThresholds() : void
      {
         var _loc1_:int = 0;
         while(_loc1_ < 10)
         {
            rankThresholds.push(rankThresholds[rankThresholds.length - 1] + RANK_STEP);
            _loc1_++;
         }
      }
      
      public function clone() : MonkeyKnowledgePath
      {
         var _loc1_:MonkeyKnowledgePath = new MonkeyKnowledgePath();
         _loc1_.id = this.id;
         _loc1_._points.value = this._points.value;
         _loc1_._rank.value = this._rank.value;
         _loc1_._displayPoints.value = this._displayPoints.value;
         _loc1_._displayRank.value = this._displayRank.value;
         return _loc1_;
      }
      
      public function setRank(param1:int) : void
      {
         if(param1 <= 0)
         {
            this.points = 0;
            MonkeyKnowledgeTree.getInstance().requestSaveSignal.dispatch(this.id,{"points":this.points});
            return;
         }
         if(param1 > rankThresholds.length)
         {
            param1 = rankThresholds.length;
         }
         this.points = rankThresholds[param1 - 1];
         MonkeyKnowledgeTree.getInstance().requestSaveSignal.dispatch(this.id,{"points":this.points});
      }
      
      public function set points(param1:int) : void
      {
         if(param1 === this._points.value)
         {
            return;
         }
         this._points.value = param1;
         this.updateRank();
      }
      
      public function get points() : int
      {
         return this._points.value;
      }
      
      private function updateRank() : void
      {
         var _loc1_:int = this._rank.value;
         this.updateRankShadowNumber(this._rank,this._points.value);
         if(_loc1_ !== this._rank.value)
         {
            this.changedSignal.dispatch();
         }
      }
      
      private function updateDisplayRank() : void
      {
         this.updateRankShadowNumber(this._displayRank,this._displayPoints.value);
      }
      
      private function updateRankShadowNumber(param1:INumber, param2:int) : void
      {
         var _loc3_:Boolean = false;
         var _loc4_:int = 0;
         while(_loc4_ < rankThresholds.length)
         {
            if(rankThresholds[_loc4_] > param2)
            {
               param1.value = _loc4_;
               _loc3_ = true;
               break;
            }
            _loc4_++;
         }
         if(!_loc3_)
         {
            param1.value = rankThresholds.length;
         }
      }
      
      public function get rank() : int
      {
         return this._rank.value;
      }
      
      public function get displayRankProgress() : Number
      {
         if(this.displayRank === NUMBER_OF_RANKS)
         {
            return 1;
         }
         var _loc1_:Number = rankThresholds[this.displayRank];
         var _loc2_:Number = 0;
         if(this.displayRank !== 0)
         {
            _loc2_ = rankThresholds[this.displayRank - 1];
         }
         return (this.displayPoints - _loc2_) / (_loc1_ - _loc2_);
      }
      
      public function syncDisplayData() : void
      {
         this._displayPoints.value = this._points.value;
         this._displayRank.value = this._rank.value;
      }
      
      public function get displayPoints() : int
      {
         return this._displayPoints.value;
      }
      
      public function set displayPoints(param1:int) : void
      {
         this._displayPoints.value = param1;
         this.updateDisplayRank();
      }
      
      public function get displayRank() : int
      {
         return this._displayRank.value;
      }
   }
}

package ninjakiwi.monkeyTown.ui.monkeyKnowledge
{
   import com.codecatalyst.promise.Promise;
   import ninjakiwi.luck.HappyCurve;
   import ninjakiwi.monkeyTown.monkeyKnowledge.MonkeyKnowledge;
   import ninjakiwi.monkeyTown.monkeyKnowledge.MonkeyKnowledgePersistence;
   
   public class MonkeyPackState
   {
       
      
      public var packsSinceThreeGood:int = 0;
      
      public var packsSinceFourGood:int = 0;
      
      public var packsSinceLegendary:int = 0;
      
      public var totalPacks:int = 0;
      
      public var legendaryCurve:HappyCurve;
      
      public var bountyCurve:HappyCurve;
      
      public var curves:Vector.<HappyCurve>;
      
      private var _persistentKeys:Array;
      
      public function MonkeyPackState()
      {
         this.legendaryCurve = new HappyCurve();
         this.bountyCurve = new HappyCurve();
         this.curves = Vector.<HappyCurve>([this.legendaryCurve,this.bountyCurve]);
         this._persistentKeys = ["packsSinceThreeGood","packsSinceFourGood","packsSinceLegendary","totalPacks"];
         super();
         this.init();
      }
      
      private function init() : void
      {
         this.legendaryCurve.protectAgainstBadLuck = false;
         this.legendaryCurve.baseProbability = 0.01;
         this.legendaryCurve.growthRate = 0.001;
         this.legendaryCurve.curve = 0.001;
         this.legendaryCurve.hitCurvePenalty = 0.3;
         this.legendaryCurve.charges = 3;
         this.bountyCurve.protectAgainstBadLuck = true;
         this.bountyCurve.baseProbability = 0.05;
         this.bountyCurve.growthRate = 0.001;
         this.bountyCurve.curve = 0.001;
         this.bountyCurve.hitCurvePenalty = 0.3;
         this.bountyCurve.charges = 3;
      }
      
      public function reset() : void
      {
         this.totalPacks = 0;
         this.packsSinceLegendary = 0;
         this.packsSinceFourGood = 0;
         this.packsSinceThreeGood = 0;
         this.legendaryCurve = new HappyCurve();
         this.init();
      }
      
      public function incrementAllCounters() : void
      {
         this.totalPacks++;
         this.packsSinceLegendary++;
         this.packsSinceFourGood++;
         this.packsSinceThreeGood++;
      }
      
      public function save() : void
      {
         MonkeyKnowledgePersistence.getInstance().saveValue(MonkeyKnowledge.PROBABILITY_STATS_KEY,this.getSaveData());
      }
      
      public function getSaveData() : Object
      {
         var _loc3_:String = null;
         var _loc1_:Object = {};
         var _loc2_:int = 0;
         while(_loc2_ < this._persistentKeys.length)
         {
            _loc3_ = this._persistentKeys[_loc2_];
            _loc1_[_loc3_] = this[_loc3_];
            _loc2_++;
         }
         _loc1_.legendaryCurve = this.legendaryCurve.state.getSaveData();
         _loc1_.bountyCurve = this.bountyCurve.state.getSaveData();
         return _loc1_;
      }
      
      public function setSaveData(param1:Object) : void
      {
         var _loc3_:String = null;
         var _loc2_:int = 0;
         while(_loc2_ < this._persistentKeys.length)
         {
            _loc3_ = this._persistentKeys[_loc2_];
            if(param1.hasOwnProperty(_loc3_))
            {
               this[_loc3_] = param1[_loc3_];
            }
            _loc2_++;
         }
         if(param1.hasOwnProperty("legendaryCurve"))
         {
            this.legendaryCurve.state.setSaveData(param1.legendaryCurve);
         }
         if(param1.hasOwnProperty("bountyCurve"))
         {
            this.bountyCurve.state.setSaveData(param1.bountyCurve);
         }
      }
      
      public function stepCurves() : void
      {
         var _loc1_:int = 0;
         while(_loc1_ < this.curves.length)
         {
            this.curves[_loc1_].step();
            _loc1_++;
         }
      }
      
      public function storeCurves() : void
      {
         var _loc1_:int = 0;
         while(_loc1_ < this.curves.length)
         {
            this.curves[_loc1_].state.storeState();
            _loc1_++;
         }
      }
      
      public function rollBackCurves() : void
      {
         var _loc1_:int = 0;
         while(_loc1_ < this.curves.length)
         {
            this.curves[_loc1_].state.rollBackState();
            _loc1_++;
         }
      }
   }
}

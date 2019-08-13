package ninjakiwi.monkeyTown.monkeyKnowledge
{
   import org.osflash.signals.Signal;
   
   public class MonkeyKnowledgeTree
   {
      
      private static var instance:MonkeyKnowledgeTree;
       
      
      public var allPaths:Vector.<MonkeyKnowledgePath>;
      
      private var _initialised:Boolean = false;
      
      private var _pathsByID:Object;
      
      private var _wildCards:Array = null;
      
      public const requestSaveSignal:Signal = new Signal(String,Object);
      
      private const WILDCARD_KEY:String = "WildCard";
      
      public function MonkeyKnowledgeTree(param1:SingletonEnforcer#793)
      {
         this.allPaths = new Vector.<MonkeyKnowledgePath>();
         this._pathsByID = {};
         super();
         if(param1 == null)
         {
            throw new Error("Error: Instantiation failed: " + "Use MonkeyKnowledgeTree.getInstance() instead of new.");
         }
         this.init();
         this.initPaths();
      }
      
      public static function getInstance() : MonkeyKnowledgeTree
      {
         if(instance == null)
         {
            instance = new MonkeyKnowledgeTree(new SingletonEnforcer#793());
         }
         return instance;
      }
      
      private function init() : void
      {
      }
      
      public function populateFromSaveData(param1:Object) : void
      {
         var _loc3_:MonkeyKnowledgePath = null;
         var _loc4_:String = null;
         var _loc5_:int = 0;
         if(param1 == null)
         {
            return;
         }
         this.reset();
         var _loc2_:int = 0;
         while(_loc2_ < this.allPaths.length)
         {
            _loc3_ = this.allPaths[_loc2_];
            _loc4_ = _loc3_.id;
            if(param1.hasOwnProperty(_loc4_) && param1[_loc4_] != "")
            {
               _loc3_.points = param1[_loc4_].points;
            }
            else
            {
               _loc3_.points = 0;
            }
            _loc2_++;
         }
         if(param1.hasOwnProperty(this.WILDCARD_KEY) && param1[this.WILDCARD_KEY] is Array)
         {
            this._wildCards = param1[this.WILDCARD_KEY];
            _loc5_ = this._wildCards.length - 1;
            while(_loc5_ >= 0)
            {
               if(!(this._wildCards[_loc5_] is MonkeyKnowledgeToken))
               {
                  this._wildCards.splice(_loc5_,1);
               }
               _loc5_--;
            }
         }
         else
         {
            this._wildCards = [];
         }
         this._initialised = true;
      }
      
      public function getPath(param1:String) : MonkeyKnowledgePath
      {
         var _loc2_:MonkeyKnowledgePath = this._pathsByID[param1];
         return _loc2_;
      }
      
      public function getRank(param1:String) : int
      {
         var _loc2_:MonkeyKnowledgePath = this._pathsByID[param1];
         if(_loc2_ !== null)
         {
            return _loc2_.rank;
         }
         return 0;
      }
      
      public function getAllRanks() : Object
      {
         var _loc1_:MonkeyKnowledgePath = null;
         var _loc2_:String = null;
         var _loc3_:Object = {};
         var _loc4_:int = 0;
         while(_loc4_ < this.allPaths.length)
         {
            _loc1_ = this.allPaths[_loc4_];
            if(_loc1_.rank > 0)
            {
               _loc3_[_loc2_] = _loc1_.rank;
            }
            _loc4_++;
         }
         return _loc3_;
      }
      
      public function awardPoints(param1:String, param2:int) : void
      {
         if(!this._initialised)
         {
            return;
         }
         var _loc3_:MonkeyKnowledgePath = this._pathsByID[param1];
         if(_loc3_ === null)
         {
            return;
         }
         _loc3_.points = _loc3_.points + param2;
         this.requestSaveSignal.dispatch(param1,{"points":_loc3_.points});
      }
      
      private function saveWildcards() : void
      {
         var _loc1_:Array = [];
         var _loc2_:int = 0;
         while(_loc2_ < this._wildCards.length)
         {
            _loc1_.push(this._wildCards[_loc2_].clone());
            _loc2_++;
         }
         this.requestSaveSignal.dispatch(this.WILDCARD_KEY,_loc1_);
      }
      
      public function addWildcard(param1:MonkeyKnowledgeToken) : void
      {
         this._wildCards.push(param1);
         this.saveWildcards();
      }
      
      public function consumeWildcard(param1:MonkeyKnowledgeToken) : void
      {
         var _loc2_:int = this._wildCards.indexOf(param1);
         if(_loc2_ >= 0)
         {
            this._wildCards.splice(_loc2_,1);
            this.saveWildcards();
         }
      }
      
      public function placeWildcardOnTop(param1:MonkeyKnowledgeToken) : void
      {
         var _loc2_:int = this._wildCards.indexOf(param1);
         if(_loc2_ > -1)
         {
            this._wildCards.splice(_loc2_,1);
            this._wildCards.push(param1);
         }
      }
      
      public function reset() : void
      {
         var _loc1_:int = 0;
         while(_loc1_ < this.allPaths.length)
         {
            this.allPaths[_loc1_].points = 0;
            _loc1_++;
         }
      }
      
      public function resetAndSave() : void
      {
         var _loc1_:int = 0;
         while(_loc1_ < this.allPaths.length)
         {
            this.allPaths[_loc1_].points = 0;
            MonkeyKnowledgeTree.getInstance().requestSaveSignal.dispatch(this.allPaths[_loc1_].id,{"points":this.allPaths[_loc1_].points});
            _loc1_++;
         }
      }
      
      private function initPaths() : void
      {
         var _loc3_:String = null;
         var _loc4_:MonkeyKnowledgePath = null;
         var _loc1_:Vector.<String> = MonkeyKnowledgeBuffData.getInstance().allIDs;
         var _loc2_:int = 0;
         while(_loc2_ < _loc1_.length)
         {
            _loc3_ = _loc1_[_loc2_];
            _loc4_ = new MonkeyKnowledgePath();
            _loc4_.id = _loc3_;
            this._pathsByID[_loc3_] = _loc4_;
            this.allPaths.push(_loc4_);
            _loc2_++;
         }
      }
      
      public function removeAllWildcards() : void
      {
      }
      
      public function syncDisplayData() : void
      {
         var _loc1_:MonkeyKnowledgePath = null;
         for each(_loc1_ in this.allPaths)
         {
            _loc1_.syncDisplayData();
         }
      }
      
      public function get wildCards() : Array
      {
         return this._wildCards;
      }
      
      public function get totalWildCards() : int
      {
         return this._wildCards.length;
      }
   }
}

class SingletonEnforcer#793
{
    
   
   function SingletonEnforcer#793()
   {
      super();
   }
}

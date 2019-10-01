package ninjakiwi.monkeyTown.monkeyKnowledge
{
   import flash.utils.ByteArray;
   import ninjakiwi.monkeyTown.btdModule.ingame.monkeyKnowledge.Buff;
   import ninjakiwi.monkeyTown.btdModule.ingame.monkeyKnowledge.pathSpecificClasses.ActiveAbilityEmpower;
   
   public class MonkeyKnowledgeBuffData
   {
      
      private static var instance:MonkeyKnowledgeBuffData;
       
      
      private var _dataTable:Object = null;
      
      private var _pathDefinitionsByKey:Object;
      
      public var pathDefinitions:Vector.<MonkeyKnowledgePathDefinition>;
      
      public var allIDs:Vector.<String>;
      
      private var _state:Object;
      
      private const TestJsonData:Class = MonkeyKnowledgeBuffData_TestJsonData;
      
      public function MonkeyKnowledgeBuffData(param1:SingletonEnforcer#983)
      {
         this._pathDefinitionsByKey = {};
         this.pathDefinitions = new Vector.<MonkeyKnowledgePathDefinition>();
         this.allIDs = new Vector.<String>();
         this._state = {};
         super();
         if(param1 == null)
         {
            throw new Error("Error: Instantiation failed: Use AchievementsManager.getInstance() instead of new.");
         }
      }
      
      public static function getInstance() : MonkeyKnowledgeBuffData
      {
         if(instance == null)
         {
            instance = new MonkeyKnowledgeBuffData(new SingletonEnforcer#983());
         }
         return instance;
      }
      
      public function initialiseWithDebugData() : void
      {
         var _loc1_:ByteArray = new this.TestJsonData() as ByteArray;
         var _loc2_:Object = JSON.parse(_loc1_.toString());
         this.initialiseWithData(_loc2_);
      }
      
      public function initialiseWithData(param1:Object) : void
      {
         this._dataTable = JSON.parse(JSON.stringify(param1));
         this.init();
      }
      
      private function init() : void
      {
         this.processDataTable();
      }
      
      private function processDataTable() : void
      {
         var _loc1_:MonkeyKnowledgePathDefinition = null;
         var _loc2_:Object = null;
         var _loc4_:* = null;
         var _loc5_:int = 0;
         var _loc3_:Array = [];
         this._pathDefinitionsByKey = {};
         this.pathDefinitions.length = 0;
         this.allIDs.length = 0;
         for(_loc4_ in this._dataTable)
         {
            _loc2_ = this._dataTable[_loc4_];
            _loc1_ = new MonkeyKnowledgePathDefinition(_loc4_,_loc2_);
            _loc3_.push(_loc1_);
         }
         _loc3_.sortOn("displayOrder",Array.NUMERIC);
         _loc5_ = 0;
         while(_loc5_ < _loc3_.length)
         {
            _loc1_ = _loc3_[_loc5_];
            this._pathDefinitionsByKey[_loc1_.id] = _loc1_;
            this.pathDefinitions.push(_loc1_);
            this.allIDs.push(_loc1_.id);
            _loc5_++;
         }
      }
      
      public function getPathDefinition(param1:String) : MonkeyKnowledgePathDefinition
      {
         if(this._pathDefinitionsByKey.hasOwnProperty(param1))
         {
            return this._pathDefinitionsByKey[param1];
         }
         return null;
      }
      
      public function get dataTable() : Object
      {
         return this._dataTable;
      }
   }
}

class SingletonEnforcer#983
{
    
   
   function SingletonEnforcer#983()
   {
      super();
   }
}

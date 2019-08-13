package ninjakiwi.monkeyTown.monkeyKnowledge
{
   public class MonkeyKnowledgePathDefinition
   {
      
      private static const RANKS_PER_PATH:int = 15;
       
      
      private var _rankValues:Vector.<Number>;
      
      private var _rankMethods:Vector.<String>;
      
      private var _rankDescriptions:Vector.<String>;
      
      private var _id:String = null;
      
      private var _name:String = null;
      
      private var _displayOrder:int = 0;
      
      public function MonkeyKnowledgePathDefinition(param1:String, param2:Object)
      {
         this._rankValues = new Vector.<Number>();
         this._rankMethods = new Vector.<String>();
         this._rankDescriptions = new Vector.<String>();
         super();
         this.init(param1,param2);
      }
      
      public function init(param1:String, param2:Object) : void
      {
         var _loc3_:int = 0;
         this._id = param1;
         this._name = param2.name;
         this._displayOrder = param2.displayOrder;
         var _loc4_:int = 0;
         while(_loc4_ < RANKS_PER_PATH)
         {
            _loc3_ = _loc4_ + 1;
            this._rankValues[_loc4_] = param2["rank" + _loc3_ + "Value"];
            this._rankMethods[_loc4_] = param2["rank" + _loc3_ + "Method"];
            this._rankDescriptions[_loc4_] = param2["rank" + _loc3_ + "Description"];
            _loc4_++;
         }
      }
      
      public function getRankValue(param1:int) : Number
      {
         if(param1 < 1 || param1 > RANKS_PER_PATH)
         {
            return -1;
         }
         return this._rankValues[param1 - 1];
      }
      
      public function getRankMethod(param1:int) : String
      {
         if(param1 < 1 || param1 > RANKS_PER_PATH)
         {
            return null;
         }
         return this._rankMethods[param1 - 1];
      }
      
      public function getRankDescription(param1:int) : String
      {
         if(param1 < 1 || param1 > RANKS_PER_PATH)
         {
            return null;
         }
         return this._rankDescriptions[param1 - 1];
      }
      
      public function get id() : String
      {
         return this._id;
      }
      
      public function get name() : String
      {
         return this._name;
      }
      
      public function get displayOrder() : int
      {
         return this._displayOrder;
      }
   }
}

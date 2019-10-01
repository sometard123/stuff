package ninjakiwi.monkeyTown.btdModule.utils
{
   import flash.utils.Dictionary;
   import flash.utils.getDefinitionByName;
   import flash.utils.getQualifiedClassName;
   
   public class Pool
   {
      
      private static var pools:Dictionary = new Dictionary();
       
      
      public function Pool()
      {
         super();
      }
      
      public static function get(param1:Class) : *
      {
         var _loc2_:Pooled = pools[param1];
         if(_loc2_ == null)
         {
            _loc2_ = new Pooled(param1);
            pools[param1] = _loc2_;
         }
         return _loc2_.get();
      }
      
      public static function release(param1:*) : void
      {
         if(param1 == null)
         {
            return;
         }
         var _loc2_:Pooled = pools[getDefinitionByName(getQualifiedClassName(param1)) as Class];
         if(_loc2_)
         {
            _loc2_.release(param1);
         }
      }
   }
}

class Pooled
{
    
   
   private var free:Array;
   
   private var type:Class = null;
   
   function Pooled(param1:Class)
   {
      this.free = new Array();
      super();
      this.type = param1;
   }
   
   public function get() : *
   {
      if(this.free.length > 0)
      {
         return this.free.pop();
      }
      return new this.type();
   }
   
   public function release(param1:*) : void
   {
      this.free.push(param1);
   }
}

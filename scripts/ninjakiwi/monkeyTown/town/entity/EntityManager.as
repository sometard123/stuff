package ninjakiwi.monkeyTown.town.entity
{
   import ninjakiwi.monkeyTown.town.management.Manager;
   
   public class EntityManager extends Manager
   {
       
      
      public function EntityManager()
      {
         super();
         validType = Entity;
      }
      
      override public function register(param1:*) : Boolean
      {
         var _loc2_:Entity = param1;
         var _loc3_:Boolean = super.register(param1);
         if(_loc3_)
         {
            _loc2_.manager = this;
         }
         return _loc3_;
      }
   }
}

package ninjakiwi.monkeyTown.town.requirements
{
   import flash.utils.Dictionary;
   
   public class Requirements
   {
      
      private static var _requirements:Dictionary = new Dictionary();
       
      
      public function Requirements()
      {
         super();
      }
      
      public static function hasRequirements(param1:*) : Boolean
      {
         if(!_requirements[param1])
         {
            return false;
         }
         return _requirements[param1]();
      }
      
      public static function registerRequirement(param1:*, param2:Function) : void
      {
         _requirements[param1] = param2;
      }
      
      public static function init() : void
      {
         Requirements.registerRequirement("foo",Requirements.fooTest);
      }
      
      public static function fooTest() : Boolean
      {
         return true;
      }
   }
}

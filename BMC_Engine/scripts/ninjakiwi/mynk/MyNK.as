package ninjakiwi.mynk
{
   import flash.errors.IllegalOperationError;
   import flash.system.Capabilities;
   
   public class MyNK
   {
      
      private static var _instance:IGateway;
       
      
      public function MyNK()
      {
         super();
      }
      
      public static function get ey() : IGateway
      {
         if(_instance == null)
         {
            throw new IllegalOperationError("call MyNK.makeMyNKey( ) before using MyNK.ey");
         }
         return _instance;
      }
      
      public static function makeMyNKey(param1:IGateway) : void
      {
         if(_instance != null)
         {
            throw new IllegalOperationError("already called MyNK.makeMyNKey( )");
         }
         _instance = param1;
         if(Capabilities.playerType !== "Desktop")
         {
            _instance.activate();
         }
      }
   }
}

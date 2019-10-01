package ninjakiwi.monkeyTown.btdModule.towers.behavior.process
{
   import flash.utils.Dictionary;
   import ninjakiwi.monkeyTown.btdModule.entities.BloonTrap;
   import ninjakiwi.monkeyTown.btdModule.towers.Tower;
   
   public class CreateBloonTrap extends BehaviorProcess
   {
      
      private static var time:Dictionary = new Dictionary();
      
      public static var hasTrap:Dictionary = new Dictionary();
       
      
      public function CreateBloonTrap()
      {
         super();
      }
      
      override public function process(param1:Tower, param2:Number) : void
      {
         if(hasTrap[param1] != null)
         {
            return;
         }
         if(time[param1] == null)
         {
            time[param1] = 0;
         }
         time[param1] = time[param1] + param2;
         if(time[param1] >= 5)
         {
            this.create(param1);
            time[param1] = 0;
         }
      }
      
      private function create(param1:Tower) : void
      {
         var _loc2_:BloonTrap = null;
         _loc2_ = new BloonTrap();
         _loc2_.initialise(param1.level.mainPath[param1.level.mainPath.length - 1],-0.5,param1);
         _loc2_.z = 1;
         param1.level.addEntity(_loc2_);
         hasTrap[param1] = true;
      }
   }
}

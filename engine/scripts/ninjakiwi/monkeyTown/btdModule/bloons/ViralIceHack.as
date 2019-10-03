package ninjakiwi.monkeyTown.btdModule.bloons
{
   import flash.utils.Dictionary;
   import ninjakiwi.monkeyTown.btdModule.projectiles.Projectile;
   
   public class ViralIceHack
   {
      
      private static var table:Dictionary = new Dictionary();
       
      
      public function ViralIceHack()
      {
         super();
      }
      
      public static function addEffect(param1:Bloon, param2:Projectile) : void
      {
         if(table[param2] == null)
         {
            table[param2] = [param1];
            return;
         }
         var _loc3_:Array = table[param2];
         if(_loc3_.length < 2)
         {
            if(_loc3_[0].overallProgress < param1.overallProgress)
            {
               _loc3_.push(param1);
            }
            else
            {
               _loc3_.unshift(param1);
            }
         }
         if(_loc3_[0].overallProgress > param1.overallProgress)
         {
            _loc3_[0].viralDepth = 0;
            _loc3_[0] = param1;
         }
         else if(_loc3_[1].overallProgress < param1.overallProgress)
         {
            _loc3_[1].viralDepth = 0;
            _loc3_[1] = param1;
         }
         else
         {
            param1.viralDepth = 0;
         }
      }
      
      public static function clear() : void
      {
         table = new Dictionary();
      }
   }
}

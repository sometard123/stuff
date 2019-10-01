package ninjakiwi.monkeyTown.btdModule.abilities.def
{
   import ninjakiwi.monkeyTown.btdModule.towers.def.TowerDef;
   
   public class OverclockPickDef extends AbilityDef
   {
       
      
      public function OverclockPickDef(param1:String = null)
      {
         super(param1);
      }
      
      public function Cooldown(param1:Number) : OverclockPickDef
      {
         cooldown = param1;
         return this;
      }
      
      public function Sound(param1:Class) : OverclockPickDef
      {
         sound = param1;
         return this;
      }
      
      public function Effect(param1:Class) : OverclockPickDef
      {
         effect = param1;
         return this;
      }
      
      public function Thumb(param1:Class) : OverclockPickDef
      {
         thumb = param1;
         return this;
      }
      
      public function AbilityClass(param1:Class) : OverclockPickDef
      {
         ability = param1;
         return this;
      }
      
      public function Label(param1:String) : OverclockPickDef
      {
         label = param1;
         return this;
      }
      
      public function Description(param1:String) : OverclockPickDef
      {
         description = param1;
         return this;
      }
      
      public function Input(param1:Vector.<TowerDef>) : OverclockPickDef
      {
         input = param1;
         return this;
      }
   }
}

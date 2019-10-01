package ninjakiwi.monkeyTown.btdModule.abilities.def
{
   public class SummonPhoenixDef extends AbilityDef
   {
       
      
      public function SummonPhoenixDef(param1:String = null)
      {
         super(param1);
      }
      
      public function Cooldown(param1:Number) : SummonPhoenixDef
      {
         cooldown = param1;
         return this;
      }
      
      public function Sound(param1:Class) : SummonPhoenixDef
      {
         sound = param1;
         return this;
      }
      
      public function Effect(param1:Class) : SummonPhoenixDef
      {
         effect = param1;
         return this;
      }
      
      public function Thumb(param1:Class) : SummonPhoenixDef
      {
         thumb = param1;
         return this;
      }
      
      public function AbilityClass(param1:Class) : SummonPhoenixDef
      {
         ability = param1;
         return this;
      }
      
      public function Label(param1:String) : SummonPhoenixDef
      {
         label = param1;
         return this;
      }
      
      public function Description(param1:String) : SummonPhoenixDef
      {
         description = param1;
         return this;
      }
   }
}

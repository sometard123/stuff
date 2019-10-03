package ninjakiwi.monkeyTown.btdModule.abilities.def
{
   public class SpikeStormDef extends AbilityDef
   {
       
      
      public function SpikeStormDef(param1:String = null)
      {
         super(param1);
      }
      
      public function Cooldown(param1:Number) : SpikeStormDef
      {
         cooldown = param1;
         return this;
      }
      
      public function Sound(param1:Class) : SpikeStormDef
      {
         sound = param1;
         return this;
      }
      
      public function Effect(param1:Class) : SpikeStormDef
      {
         effect = param1;
         return this;
      }
      
      public function Thumb(param1:Class) : SpikeStormDef
      {
         thumb = param1;
         return this;
      }
      
      public function AbilityClass(param1:Class) : SpikeStormDef
      {
         ability = param1;
         return this;
      }
      
      public function Label(param1:String) : SpikeStormDef
      {
         label = param1;
         return this;
      }
      
      public function Description(param1:String) : SpikeStormDef
      {
         description = param1;
         return this;
      }
   }
}

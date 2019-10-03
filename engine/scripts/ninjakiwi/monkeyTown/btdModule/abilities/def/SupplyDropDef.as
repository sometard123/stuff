package ninjakiwi.monkeyTown.btdModule.abilities.def
{
   public class SupplyDropDef extends AbilityDef
   {
       
      
      public function SupplyDropDef(param1:String = null)
      {
         super(param1);
      }
      
      public function Cooldown(param1:Number) : SupplyDropDef
      {
         cooldown = param1;
         return this;
      }
      
      public function Sound(param1:Class) : SupplyDropDef
      {
         sound = param1;
         return this;
      }
      
      public function Effect(param1:Class) : SupplyDropDef
      {
         effect = param1;
         return this;
      }
      
      public function Thumb(param1:Class) : SupplyDropDef
      {
         thumb = param1;
         return this;
      }
      
      public function AbilityClass(param1:Class) : SupplyDropDef
      {
         ability = param1;
         return this;
      }
      
      public function Label(param1:String) : SupplyDropDef
      {
         label = param1;
         return this;
      }
      
      public function Description(param1:String) : SupplyDropDef
      {
         description = param1;
         return this;
      }
   }
}

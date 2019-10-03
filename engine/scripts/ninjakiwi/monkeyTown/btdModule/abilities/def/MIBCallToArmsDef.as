package ninjakiwi.monkeyTown.btdModule.abilities.def
{
   public class MIBCallToArmsDef extends AbilityDef
   {
       
      
      public function MIBCallToArmsDef(param1:String = null)
      {
         super(param1);
      }
      
      public function Cooldown(param1:Number) : MIBCallToArmsDef
      {
         cooldown = param1;
         return this;
      }
      
      public function Sound(param1:Class) : MIBCallToArmsDef
      {
         sound = param1;
         return this;
      }
      
      public function Effect(param1:Class) : MIBCallToArmsDef
      {
         effect = param1;
         return this;
      }
      
      public function Thumb(param1:Class) : MIBCallToArmsDef
      {
         thumb = param1;
         return this;
      }
      
      public function AbilityClass(param1:Class) : MIBCallToArmsDef
      {
         ability = param1;
         return this;
      }
      
      public function Label(param1:String) : MIBCallToArmsDef
      {
         label = param1;
         return this;
      }
      
      public function Description(param1:String) : MIBCallToArmsDef
      {
         description = param1;
         return this;
      }
   }
}

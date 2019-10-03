package ninjakiwi.monkeyTown.btdModule.abilities.def
{
   public class MOABTakedownDef extends AbilityDef
   {
       
      
      public function MOABTakedownDef(param1:String = null)
      {
         super(param1);
      }
      
      public function Cooldown(param1:Number) : MOABTakedownDef
      {
         cooldown = param1;
         return this;
      }
      
      public function Effect(param1:Class) : MOABTakedownDef
      {
         effect = param1;
         return this;
      }
      
      public function Sound(param1:Class) : MOABTakedownDef
      {
         sound = param1;
         return this;
      }
      
      public function Thumb(param1:Class) : MOABTakedownDef
      {
         thumb = param1;
         return this;
      }
      
      public function AbilityClass(param1:Class) : MOABTakedownDef
      {
         ability = param1;
         return this;
      }
      
      public function Label(param1:String) : MOABTakedownDef
      {
         label = param1;
         return this;
      }
      
      public function Description(param1:String) : MOABTakedownDef
      {
         description = param1;
         return this;
      }
   }
}

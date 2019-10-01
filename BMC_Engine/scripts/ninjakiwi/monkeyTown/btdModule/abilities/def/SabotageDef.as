package ninjakiwi.monkeyTown.btdModule.abilities.def
{
   public class SabotageDef extends AbilityDef
   {
       
      
      public function SabotageDef(param1:String = null)
      {
         super(param1);
      }
      
      public function Cooldown(param1:Number) : SabotageDef
      {
         cooldown = param1;
         return this;
      }
      
      public function Sound(param1:Class) : SabotageDef
      {
         sound = param1;
         return this;
      }
      
      public function Effect(param1:Class) : SabotageDef
      {
         effect = param1;
         return this;
      }
      
      public function Thumb(param1:Class) : SabotageDef
      {
         thumb = param1;
         return this;
      }
      
      public function AbilityClass(param1:Class) : SabotageDef
      {
         ability = param1;
         return this;
      }
      
      public function Label(param1:String) : SabotageDef
      {
         label = param1;
         return this;
      }
      
      public function Description(param1:String) : SabotageDef
      {
         description = param1;
         return this;
      }
   }
}

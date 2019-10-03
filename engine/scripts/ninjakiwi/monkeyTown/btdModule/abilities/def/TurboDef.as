package ninjakiwi.monkeyTown.btdModule.abilities.def
{
   public class TurboDef extends AbilityDef
   {
       
      
      public function TurboDef(param1:String = null)
      {
         super(param1);
      }
      
      public function Cooldown(param1:Number) : TurboDef
      {
         cooldown = param1;
         return this;
      }
      
      public function Sound(param1:Class) : TurboDef
      {
         sound = param1;
         return this;
      }
      
      public function Effect(param1:Class) : TurboDef
      {
         effect = param1;
         return this;
      }
      
      public function Thumb(param1:Class) : TurboDef
      {
         thumb = param1;
         return this;
      }
      
      public function AbilityClass(param1:Class) : TurboDef
      {
         ability = param1;
         return this;
      }
      
      public function Label(param1:String) : TurboDef
      {
         label = param1;
         return this;
      }
      
      public function Description(param1:String) : TurboDef
      {
         description = param1;
         return this;
      }
   }
}

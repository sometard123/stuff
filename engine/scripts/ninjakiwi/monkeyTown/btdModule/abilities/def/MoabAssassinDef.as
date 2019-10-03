package ninjakiwi.monkeyTown.btdModule.abilities.def
{
   public class MoabAssassinDef extends AbilityDef
   {
       
      
      public function MoabAssassinDef(param1:String = null)
      {
         super(param1);
      }
      
      public function Cooldown(param1:Number) : MoabAssassinDef
      {
         cooldown = param1;
         return this;
      }
      
      public function Effect(param1:Class) : MoabAssassinDef
      {
         effect = param1;
         return this;
      }
      
      public function Sound(param1:Class) : MoabAssassinDef
      {
         sound = param1;
         return this;
      }
      
      public function Thumb(param1:Class) : MoabAssassinDef
      {
         thumb = param1;
         return this;
      }
      
      public function AbilityClass(param1:Class) : MoabAssassinDef
      {
         ability = param1;
         return this;
      }
      
      public function Label(param1:String) : MoabAssassinDef
      {
         label = param1;
         return this;
      }
      
      public function Description(param1:String) : MoabAssassinDef
      {
         description = param1;
         return this;
      }
   }
}

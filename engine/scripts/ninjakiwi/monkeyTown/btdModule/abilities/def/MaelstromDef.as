package ninjakiwi.monkeyTown.btdModule.abilities.def
{
   public class MaelstromDef extends AbilityDef
   {
       
      
      public function MaelstromDef(param1:String = null)
      {
         super(param1);
      }
      
      public function Cooldown(param1:Number) : MaelstromDef
      {
         cooldown = param1;
         return this;
      }
      
      public function Sound(param1:Class) : MaelstromDef
      {
         sound = param1;
         return this;
      }
      
      public function Effect(param1:Class) : MaelstromDef
      {
         effect = param1;
         return this;
      }
      
      public function Thumb(param1:Class) : MaelstromDef
      {
         thumb = param1;
         return this;
      }
      
      public function AbilityClass(param1:Class) : MaelstromDef
      {
         ability = param1;
         return this;
      }
      
      public function Label(param1:String) : MaelstromDef
      {
         label = param1;
         return this;
      }
      
      public function Description(param1:String) : MaelstromDef
      {
         description = param1;
         return this;
      }
   }
}

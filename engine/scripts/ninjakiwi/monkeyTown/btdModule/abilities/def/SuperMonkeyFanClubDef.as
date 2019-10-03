package ninjakiwi.monkeyTown.btdModule.abilities.def
{
   public class SuperMonkeyFanClubDef extends AbilityDef
   {
       
      
      public function SuperMonkeyFanClubDef(param1:String = null)
      {
         super(param1);
      }
      
      public function Cooldown(param1:Number) : SuperMonkeyFanClubDef
      {
         cooldown = param1;
         return this;
      }
      
      public function Sound(param1:Class) : SuperMonkeyFanClubDef
      {
         sound = param1;
         return this;
      }
      
      public function Effect(param1:Class) : SuperMonkeyFanClubDef
      {
         effect = param1;
         return this;
      }
      
      public function Thumb(param1:Class) : SuperMonkeyFanClubDef
      {
         thumb = param1;
         return this;
      }
      
      public function AbilityClass(param1:Class) : SuperMonkeyFanClubDef
      {
         ability = param1;
         return this;
      }
      
      public function Label(param1:String) : SuperMonkeyFanClubDef
      {
         label = param1;
         return this;
      }
      
      public function Description(param1:String) : SuperMonkeyFanClubDef
      {
         description = param1;
         return this;
      }
   }
}

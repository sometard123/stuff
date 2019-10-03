package ninjakiwi.monkeyTown.btdModule.abilities.def
{
   public class ActivateWhirpoolDef extends AbilityDef
   {
       
      
      public function ActivateWhirpoolDef(param1:String = null)
      {
         super(param1);
      }
      
      public function Cooldown(param1:Number) : ActivateWhirpoolDef
      {
         cooldown = param1;
         return this;
      }
      
      public function Effect(param1:Class) : ActivateWhirpoolDef
      {
         effect = param1;
         return this;
      }
      
      public function Sound(param1:Class) : ActivateWhirpoolDef
      {
         sound = param1;
         return this;
      }
      
      public function Thumb(param1:Class) : ActivateWhirpoolDef
      {
         thumb = param1;
         return this;
      }
      
      public function AbilityClass(param1:Class) : ActivateWhirpoolDef
      {
         ability = param1;
         return this;
      }
      
      public function Label(param1:String) : ActivateWhirpoolDef
      {
         label = param1;
         return this;
      }
      
      public function Description(param1:String) : ActivateWhirpoolDef
      {
         description = param1;
         return this;
      }
   }
}

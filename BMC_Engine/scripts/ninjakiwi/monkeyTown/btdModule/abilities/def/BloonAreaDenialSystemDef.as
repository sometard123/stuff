package ninjakiwi.monkeyTown.btdModule.abilities.def
{
   import ninjakiwi.monkeyTown.btdModule.events.PropertyModEvent;
   import ninjakiwi.monkeyTown.btdModule.projectiles.def.ProjectileDef;
   
   public class BloonAreaDenialSystemDef extends AbilityDef
   {
       
      
      private var projectile_:ProjectileDef;
      
      public function BloonAreaDenialSystemDef(param1:String = null)
      {
         super(param1);
      }
      
      public function set projectile(param1:ProjectileDef) : void
      {
         if(this.projectile_ != param1)
         {
            this.projectile_ = param1;
            dispatchEvent(new PropertyModEvent("projectile"));
         }
      }
      
      public function get projectile() : ProjectileDef
      {
         return this.projectile_;
      }
      
      public function Projectile(param1:ProjectileDef) : BloonAreaDenialSystemDef
      {
         this.projectile = param1;
         return this;
      }
      
      public function Cooldown(param1:Number) : BloonAreaDenialSystemDef
      {
         cooldown = param1;
         return this;
      }
      
      public function Sound(param1:Class) : BloonAreaDenialSystemDef
      {
         sound = param1;
         return this;
      }
      
      public function Effect(param1:Class) : BloonAreaDenialSystemDef
      {
         effect = param1;
         return this;
      }
      
      public function Thumb(param1:Class) : BloonAreaDenialSystemDef
      {
         thumb = param1;
         return this;
      }
      
      public function AbilityClass(param1:Class) : BloonAreaDenialSystemDef
      {
         ability = param1;
         return this;
      }
      
      public function Label(param1:String) : BloonAreaDenialSystemDef
      {
         label = param1;
         return this;
      }
      
      public function Description(param1:String) : BloonAreaDenialSystemDef
      {
         description = param1;
         return this;
      }
   }
}

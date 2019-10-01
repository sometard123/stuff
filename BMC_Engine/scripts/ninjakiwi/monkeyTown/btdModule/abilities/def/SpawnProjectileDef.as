package ninjakiwi.monkeyTown.btdModule.abilities.def
{
   import ninjakiwi.monkeyTown.btdModule.events.PropertyModEvent;
   import ninjakiwi.monkeyTown.btdModule.projectiles.def.ProjectileDef;
   
   public class SpawnProjectileDef extends AbilityDef
   {
       
      
      private var projectile_:ProjectileDef;
      
      public function SpawnProjectileDef(param1:String = null)
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
      
      public function Projectile(param1:ProjectileDef) : SpawnProjectileDef
      {
         this.projectile = param1;
         return this;
      }
      
      public function Cooldown(param1:Number) : SpawnProjectileDef
      {
         cooldown = param1;
         return this;
      }
      
      public function Sound(param1:Class) : SpawnProjectileDef
      {
         sound = param1;
         return this;
      }
      
      public function Effect(param1:Class) : SpawnProjectileDef
      {
         effect = param1;
         return this;
      }
      
      public function Thumb(param1:Class) : SpawnProjectileDef
      {
         thumb = param1;
         return this;
      }
      
      public function AbilityClass(param1:Class) : SpawnProjectileDef
      {
         ability = param1;
         return this;
      }
      
      public function Label(param1:String) : SpawnProjectileDef
      {
         label = param1;
         return this;
      }
      
      public function Description(param1:String) : SpawnProjectileDef
      {
         description = param1;
         return this;
      }
      
      public function EffectBlend(param1:String) : SpawnProjectileDef
      {
         effectBlend = param1;
         return this;
      }
   }
}

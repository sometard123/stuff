package ninjakiwi.monkeyTown.btdModule.abilities.def
{
   import ninjakiwi.monkeyTown.btdModule.events.PropertyModEvent;
   import ninjakiwi.monkeyTown.btdModule.projectiles.def.ProjectileDef;
   
   public class StickySapFlowerDef extends AbilityDef
   {
       
      
      private var projectile_:ProjectileDef;
      
      private var fullscreenEffect_:Class = null;
      
      public function StickySapFlowerDef(param1:String = null)
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
      
      public function Projectile(param1:ProjectileDef) : StickySapFlowerDef
      {
         this.projectile = param1;
         return this;
      }
      
      public function get fullscreenEffect() : Class
      {
         return this.fullscreenEffect_;
      }
      
      public function set fullscreenEffect(param1:Class) : void
      {
         if(this.fullscreenEffect_ != param1)
         {
            this.fullscreenEffect_ = param1;
            dispatchEvent(new PropertyModEvent("fullscreenEffect"));
         }
      }
      
      public function FullscreenEffect(param1:Class) : StickySapFlowerDef
      {
         this.fullscreenEffect = param1;
         return this;
      }
      
      public function Cooldown(param1:Number) : StickySapFlowerDef
      {
         cooldown = param1;
         return this;
      }
      
      public function Effect(param1:Class) : StickySapFlowerDef
      {
         effect = param1;
         return this;
      }
      
      public function Sound(param1:Class) : StickySapFlowerDef
      {
         sound = param1;
         return this;
      }
      
      public function Thumb(param1:Class) : StickySapFlowerDef
      {
         thumb = param1;
         return this;
      }
      
      public function AbilityClass(param1:Class) : StickySapFlowerDef
      {
         ability = param1;
         return this;
      }
      
      public function Label(param1:String) : StickySapFlowerDef
      {
         label = param1;
         return this;
      }
      
      public function Description(param1:String) : StickySapFlowerDef
      {
         description = param1;
         return this;
      }
   }
}

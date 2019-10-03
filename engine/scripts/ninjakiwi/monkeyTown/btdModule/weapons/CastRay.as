package ninjakiwi.monkeyTown.btdModule.weapons
{
   import ninjakiwi.monkeyTown.btdModule.bloons.Bloon;
   import ninjakiwi.monkeyTown.btdModule.entities.EnergyRay;
   import ninjakiwi.monkeyTown.btdModule.events.PropertyModEvent;
   import ninjakiwi.monkeyTown.btdModule.framework.Entity;
   import ninjakiwi.monkeyTown.btdModule.math.Vector2;
   import ninjakiwi.monkeyTown.btdModule.projectiles.def.ProjectileDef;
   import ninjakiwi.monkeyTown.btdModule.towers.Tower;
   
   public class CastRay extends Standard
   {
       
      
      private var rotate_:Boolean = true;
      
      private var tempRotation:Vector2;
      
      public function CastRay()
      {
         this.tempRotation = new Vector2();
         super();
      }
      
      public function Range(param1:Number) : CastRay
      {
         range = param1;
         return this;
      }
      
      public function ReloadTime(param1:Number) : CastRay
      {
         reloadTime = param1;
         return this;
      }
      
      public function Power(param1:Number) : CastRay
      {
         power = param1;
         return this;
      }
      
      public function Projectile(param1:ProjectileDef) : CastRay
      {
         projectile = param1;
         return this;
      }
      
      public function Proxied(param1:Boolean) : CastRay
      {
         proxied = param1;
         return this;
      }
      
      public function set rotate(param1:Boolean) : void
      {
         if(this.rotate_ != param1)
         {
            this.rotate_ = param1;
            dispatchEvent(new PropertyModEvent("rotate"));
         }
      }
      
      public function get rotate() : Boolean
      {
         return this.rotate_;
      }
      
      public function Rotate(param1:Boolean) : CastRay
      {
         this.rotate = param1;
         return this;
      }
      
      override public function execute(param1:Tower, param2:Entity, param3:Entity, param4:Vector2 = null) : void
      {
         if(param3 == null)
         {
            return;
         }
         if(EnergyRay.target[param1] != null)
         {
            return;
         }
         var _loc5_:EnergyRay = new EnergyRay();
         _loc5_.initialise(param1,param4,param3 as Bloon);
         param1.level.addEntity(_loc5_);
      }
   }
}

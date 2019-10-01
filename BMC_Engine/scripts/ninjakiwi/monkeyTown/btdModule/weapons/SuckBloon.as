package ninjakiwi.monkeyTown.btdModule.weapons
{
   import ninjakiwi.monkeyTown.btdModule.bloons.Bloon;
   import ninjakiwi.monkeyTown.btdModule.events.PropertyModEvent;
   import ninjakiwi.monkeyTown.btdModule.framework.Entity;
   import ninjakiwi.monkeyTown.btdModule.math.Vector2;
   import ninjakiwi.monkeyTown.btdModule.projectiles.def.ProjectileDef;
   import ninjakiwi.monkeyTown.btdModule.towers.Tower;
   import ninjakiwi.monkeyTown.btdModule.towers.behavior.process.BloonchipperStore;
   
   public class SuckBloon extends Standard
   {
       
      
      private var rotate_:Boolean = true;
      
      private var offsetTemp:Vector2;
      
      private var vec:Vector2;
      
      public function SuckBloon(param1:String = null)
      {
         this.offsetTemp = new Vector2();
         this.vec = new Vector2();
         super(param1);
      }
      
      public function Range(param1:Number) : SuckBloon
      {
         range = param1;
         return this;
      }
      
      public function ReloadTime(param1:Number) : SuckBloon
      {
         reloadTime = param1;
         return this;
      }
      
      public function Power(param1:Number) : SuckBloon
      {
         power = param1;
         return this;
      }
      
      public function Projectile(param1:ProjectileDef) : SuckBloon
      {
         projectile = param1;
         return this;
      }
      
      public function Proxied(param1:Boolean) : SuckBloon
      {
         proxied = param1;
         return this;
      }
      
      public function IsBaseWeapon(param1:Boolean) : SuckBloon
      {
         isBaseWeapon = param1;
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
      
      public function Rotate(param1:Boolean) : SuckBloon
      {
         this.rotate = param1;
         return this;
      }
      
      override public function execute(param1:Tower, param2:Entity, param3:Entity, param4:Vector2 = null) : void
      {
         var _loc5_:Bloon = null;
         var _loc6_:Bloon = null;
         _loc5_ = null;
         for each(_loc6_ in param1.targetsByPriority)
         {
            if((param1.def.behavior.process as BloonchipperStore).canSuck(param1,_loc6_))
            {
               _loc5_ = _loc6_;
               break;
            }
         }
         if(_loc5_ == null)
         {
            return;
         }
         this.vec.x = _loc5_.x - param1.x;
         this.vec.y = _loc5_.y - param1.y;
         param1.rotation = this.vec.rotation;
         (param1.def.behavior.process as BloonchipperStore).addBloon(param1,_loc5_);
      }
   }
}

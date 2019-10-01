package ninjakiwi.monkeyTown.btdModule.towers.behavior.process
{
   import ninjakiwi.monkeyTown.btdModule.bloons.Bloon;
   import ninjakiwi.monkeyTown.btdModule.entities.MapElement;
   import ninjakiwi.monkeyTown.btdModule.events.PropertyModEvent;
   import ninjakiwi.monkeyTown.btdModule.math.Intersection;
   import ninjakiwi.monkeyTown.btdModule.math.Vector2;
   import ninjakiwi.monkeyTown.btdModule.projectiles.Projectile;
   import ninjakiwi.monkeyTown.btdModule.projectiles.def.ProjectileDef;
   import ninjakiwi.monkeyTown.btdModule.towers.Tower;
   import ninjakiwi.monkeyTown.btdModule.towers.behavior.roundStart.DeployRay;
   import ninjakiwi.monkeyTown.btdModule.towers.def.TowerDef;
   import ninjakiwi.monkeyTown.btdModule.weapons.FireAtReticle;
   
   public class RayDamage extends BehaviorProcess
   {
      
      private static var bloonPos:Vector2 = new Vector2();
      
      private static var lineStart:Vector2 = new Vector2();
      
      private static var lineEnd:Vector2 = new Vector2();
      
      private static var testProjectile:Projectile = null;
       
      
      private var vec:Vector2;
      
      private var projectile_:ProjectileDef;
      
      public function RayDamage()
      {
         this.vec = new Vector2();
         super();
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
      
      public function Projectile(param1:ProjectileDef) : RayDamage
      {
         this.projectile = param1;
         return this;
      }
      
      override public function process(param1:Tower, param2:Number) : void
      {
         var _loc4_:Bloon = null;
         var _loc5_:Vector2 = null;
         var _loc7_:MapElement = null;
         var _loc8_:Boolean = false;
         var _loc9_:Vector2 = null;
         if(testProjectile == null)
         {
            testProjectile = new Projectile();
            testProjectile.initialise(this.projectile,param1.level,param1.buffs,null);
         }
         testProjectile.owner = param1;
         lineStart.x = param1.x;
         lineStart.y = param1.y;
         lineEnd.x = 1;
         lineEnd.y = 0;
         lineEnd.rotation = param1.rotation;
         lineEnd.magnitude = 1000;
         var _loc3_:int = 0;
         for each(_loc4_ in param1.level.bloons)
         {
            if(!_loc4_.isInTunnel)
            {
               bloonPos.x = _loc4_.x;
               bloonPos.y = _loc4_.y;
               _loc8_ = Intersection.testCircleLine(lineStart,lineEnd,bloonPos,_loc4_.radius);
               if(_loc8_)
               {
                  _loc4_.handleCollision(testProjectile);
                  _loc3_++;
                  if(_loc3_ >= 100)
                  {
                     break;
                  }
               }
            }
         }
         lineStart.x = 1;
         lineStart.y = 0;
         lineStart.rotation = param1.rotation;
         _loc5_ = new Vector2();
         if(param1.targetingSystem == TowerDef.TARGETS_MOUSE)
         {
            _loc9_ = param1.level.getMousePos();
            _loc5_.x = _loc9_.x;
            _loc5_.y = _loc9_.y;
         }
         else if(param1.targetingSystem == TowerDef.TARGETS_RETICLE)
         {
            _loc5_ = FireAtReticle.GetLocation(param1);
         }
         lineEnd.x = _loc5_.x - param1.x;
         lineEnd.y = _loc5_.y - param1.y;
         lineEnd.magnitude = 3000;
         var _loc6_:Number = lineStart.angleBetween(lineEnd);
         if(isNaN(_loc6_))
         {
            _loc6_ = 0;
         }
         param1.rotation = param1.rotation + _loc6_ / 5;
         _loc7_ = DeployRay.rays[param1];
         if(_loc7_ != null)
         {
            lineStart.x = 1;
            lineStart.y = 0;
            lineStart.rotation = param1.rotation;
            lineStart.magnitude = 64;
            _loc7_.x = param1.x + lineStart.x;
            _loc7_.y = param1.y + lineStart.y;
            _loc7_.rotation = param1.rotation;
         }
      }
   }
}

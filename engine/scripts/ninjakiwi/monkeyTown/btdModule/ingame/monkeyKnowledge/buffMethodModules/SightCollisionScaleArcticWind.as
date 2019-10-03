package ninjakiwi.monkeyTown.btdModule.ingame.monkeyKnowledge.buffMethodModules
{
   import ninjakiwi.monkeyTown.btdModule.ingame.monkeyKnowledge.Buff;
   import ninjakiwi.monkeyTown.btdModule.towers.def.TowerDef;
   import ninjakiwi.monkeyTown.btdModule.weapons.Surround;
   
   public class SightCollisionScaleArcticWind implements IBuffMethodModule
   {
       
      
      public function SightCollisionScaleArcticWind()
      {
         super();
      }
      
      public function invoke(param1:Buff) : void
      {
         var _loc2_:TowerDef = null;
         var _loc3_:TowerDef = null;
         var _loc5_:Surround = null;
         var _loc6_:Surround = null;
         var _loc8_:TowerDef = null;
         var _loc9_:TowerDef = null;
         var _loc11_:Surround = null;
         var _loc12_:Surround = null;
         _loc2_ = Main.instance.towerFactory.getBaseTower("ArcticWind");
         _loc3_ = Main.instance.towerFactoryUnmodified.getBaseTower("ArcticWind");
         var _loc4_:Number = _loc2_.rangeOfVisibility / _loc3_.rangeOfVisibility - (1 - param1.buffValue);
         _loc2_.RangeOfVisibility(_loc3_.rangeOfVisibility * _loc4_);
         _loc5_ = _loc2_.weapons[0] as Surround;
         _loc6_ = _loc3_.weapons[0] as Surround;
         var _loc7_:Number = _loc5_.projectile.radius / _loc6_.projectile.radius - (1 - param1.buffValue);
         _loc5_.projectile.Radius(_loc6_.projectile.radius * _loc7_);
         _loc8_ = Main.instance.towerFactory.getBaseTower("ViralFrost");
         _loc9_ = Main.instance.towerFactoryUnmodified.getBaseTower("ViralFrost");
         var _loc10_:Number = _loc8_.rangeOfVisibility / _loc9_.rangeOfVisibility - (1 - param1.buffValue);
         _loc8_.RangeOfVisibility(_loc9_.rangeOfVisibility * _loc10_);
         _loc11_ = _loc8_.weapons[0] as Surround;
         _loc12_ = _loc9_.weapons[0] as Surround;
         var _loc13_:Number = _loc11_.projectile.radius / _loc12_.projectile.radius - (1 - param1.buffValue);
         _loc11_.Range(_loc12_.projectile.radius * _loc13_);
      }
   }
}

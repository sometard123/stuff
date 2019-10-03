package ninjakiwi.monkeyTown.btdModule.towers.behavior.initialise
{
   import assests.effects.DartMonkeyLightningblast;
   import assests.effects.MonkeyGod;
   import assets.projectile.Blade;
   import assets.projectile.Dart;
   import assets.projectile.GodGlueShot;
   import assets.projectile.GodGlueSplat;
   import assets.projectile.IceBolt;
   import assets.projectile.IceExplosion;
   import assets.projectile.IceExplosionLarge;
   import assets.projectile.IceExplosionMedium;
   import assets.projectile.NuclearExplosion;
   import assets.projectile.SunBall;
   import assets.projectile.TempleMissile;
   import assets.projectile.Tornado;
   import assets.sound.TempleSacrifice;
   import flash.events.Event;
   import flash.utils.Dictionary;
   import ninjakiwi.monkeyTown.btdModule.bloons.Bloon;
   import ninjakiwi.monkeyTown.btdModule.entities.Effect;
   import ninjakiwi.monkeyTown.btdModule.ingame.monkeyKnowledge.Buff;
   import ninjakiwi.monkeyTown.btdModule.ingame.monkeyKnowledge.buffMethodModules.SacrificeValueScaleSet;
   import ninjakiwi.monkeyTown.btdModule.projectiles.behavior.BehaviorDef;
   import ninjakiwi.monkeyTown.btdModule.projectiles.behavior.collision.CollisionSpawnProjectile;
   import ninjakiwi.monkeyTown.btdModule.projectiles.def.DamageEffectDef;
   import ninjakiwi.monkeyTown.btdModule.projectiles.def.GlueEffectDef;
   import ninjakiwi.monkeyTown.btdModule.projectiles.def.IceEffectDef;
   import ninjakiwi.monkeyTown.btdModule.projectiles.def.ProjectileDef;
   import ninjakiwi.monkeyTown.btdModule.projectiles.def.WindEffectDef;
   import ninjakiwi.monkeyTown.btdModule.sound.MaxSound;
   import ninjakiwi.monkeyTown.btdModule.towers.Tower;
   import ninjakiwi.monkeyTown.btdModule.towers.behavior.roundOver.RetractArcticWind;
   import ninjakiwi.monkeyTown.btdModule.towers.behavior.roundStart.SpawnArcticWind;
   import ninjakiwi.monkeyTown.btdModule.towers.def.AreaEffectDef;
   import ninjakiwi.monkeyTown.btdModule.towers.upgrades.AddDef;
   import ninjakiwi.monkeyTown.btdModule.towers.upgrades.BehaviorModDef;
   import ninjakiwi.monkeyTown.btdModule.towers.upgrades.Combinator;
   import ninjakiwi.monkeyTown.btdModule.towers.upgrades.UpgradeDef;
   import ninjakiwi.monkeyTown.btdModule.utils.GameSpeedTimer;
   import ninjakiwi.monkeyTown.btdModule.weapons.Single;
   import ninjakiwi.monkeyTown.btdModule.weapons.SingleAtMultiTarget;
   import ninjakiwi.monkeyTown.btdModule.weapons.Spread;
   import ninjakiwi.monkeyTown.btdModule.weapons.Weapon;
   
   public class Sacrifice extends BehaviorInitialise
   {
      
      public static const SACRIFICE_TYPE_FREEZE:int = 0;
      
      public static const SACRIFICE_TYPE_EXPLOSION:int = 1;
      
      public static const SACRIFICE_TYPE_SHARP:int = 2;
      
      public static const SACRIFICE_TYPE_GLUE:int = 3;
      
      public static const SACRIFICE_TYPE_WIND:int = 4;
      
      public static var sacrificeSpentOn:Dictionary = new Dictionary();
      
      public static var dont:Vector.<Tower> = new Vector.<Tower>();
      
      private static var dart:ProjectileDef = new ProjectileDef().Display(Dart).Pierce(20).EffectMask(Vector.<int>([Bloon.IMMUNITY_NONE])).DamageEffect(new DamageEffectDef().Damage(2).CantBreak(Vector.<int>([Bloon.LEAD,Bloon.DDT,Bloon.BOSS_DREADBLOON])).CanBreakIce(false)).ZOffset(0.01);
      
      private static var dart2:ProjectileDef = new ProjectileDef().Display(Dart).Pierce(30).EffectMask(Vector.<int>([Bloon.IMMUNITY_NONE])).DamageEffect(new DamageEffectDef().Damage(3).CantBreak(Vector.<int>([Bloon.LEAD,Bloon.DDT,Bloon.BOSS_DREADBLOON])).CanBreakIce(false)).ZOffset(0.01);
      
      private static var blade:ProjectileDef = new ProjectileDef().Display(Blade).Pierce(40).Radius(4).EffectMask(Vector.<int>([Bloon.IMMUNITY_NONE])).DamageEffect(new DamageEffectDef().Damage(4).CantBreak(Vector.<int>([Bloon.LEAD,Bloon.DDT,Bloon.BOSS_DREADBLOON])).CanBreakIce(false)).ZOffset(0.01);
      
      private static var bladePlasma:ProjectileDef = new ProjectileDef().Display(Blade).Pierce(40).Radius(4).EffectMask(Vector.<int>([Bloon.IMMUNITY_NONE])).DamageEffect(new DamageEffectDef().Damage(4).CanBreakIce(true)).ZOffset(0.01);
      
      private static var iceExplosion:ProjectileDef = new ProjectileDef().Display(IceExplosion).Pierce(999).Radius(200).EffectMask(Vector.<int>([Bloon.IMMUNITY_NONE])).DamageEffect(new DamageEffectDef().Damage(1).CanBreakIce(true)).IceEffect(new IceEffectDef().Lifespan(1.5)).ZOffset(0.01);
      
      private static var iceBomb:ProjectileDef = new ProjectileDef().Display(IceBolt).Pierce(1).Radius(5).EffectMask(Vector.<int>([Bloon.IMMUNITY_NONE])).Behavior(new ninjakiwi.monkeyTown.btdModule.projectiles.behavior.BehaviorDef().Collision(new CollisionSpawnProjectile().Projectile(iceExplosion))).ZOffset(0.01);
      
      private static var iceExplosion2:ProjectileDef = new ProjectileDef().Display(IceExplosionMedium).Pierce(999).Radius(250).EffectMask(Vector.<int>([Bloon.IMMUNITY_NONE])).DamageEffect(new DamageEffectDef().Damage(1).CanBreakIce(true)).IceEffect(new IceEffectDef().Lifespan(2)).ZOffset(0.01);
      
      private static var iceBomb2:ProjectileDef = new ProjectileDef().Display(IceBolt).Pierce(1).Radius(5).EffectMask(Vector.<int>([Bloon.IMMUNITY_NONE])).Behavior(new ninjakiwi.monkeyTown.btdModule.projectiles.behavior.BehaviorDef().Collision(new CollisionSpawnProjectile().Projectile(iceExplosion2))).ZOffset(0.01);
      
      private static var iceExplosion3:ProjectileDef = new ProjectileDef().Display(IceExplosionMedium).Pierce(999).Radius(250).EffectMask(Vector.<int>([Bloon.IMMUNITY_NONE])).DamageEffect(new DamageEffectDef().Damage(1).CanBreakIce(true)).IceEffect(new IceEffectDef().Lifespan(2).FreezeLayers(2)).ZOffset(0.01);
      
      private static var iceBomb3:ProjectileDef = new ProjectileDef().Display(IceBolt).Pierce(1).Radius(5).EffectMask(Vector.<int>([Bloon.IMMUNITY_NONE])).Behavior(new ninjakiwi.monkeyTown.btdModule.projectiles.behavior.BehaviorDef().Collision(new CollisionSpawnProjectile().Projectile(iceExplosion3))).ZOffset(0.01);
      
      private static var iceExplosion4:ProjectileDef = new ProjectileDef().Display(IceExplosionLarge).Pierce(999).Radius(300).EffectMask(Vector.<int>([Bloon.IMMUNITY_NONE])).DamageEffect(new DamageEffectDef().Damage(1).CanBreakIce(true)).IceEffect(new IceEffectDef().Lifespan(2.5).FreezeLayers(2)).ZOffset(0.01);
      
      private static var iceBomb4:ProjectileDef = new ProjectileDef().Display(IceBolt).Pierce(1).Radius(5).EffectMask(Vector.<int>([Bloon.IMMUNITY_NONE])).Behavior(new ninjakiwi.monkeyTown.btdModule.projectiles.behavior.BehaviorDef().Collision(new CollisionSpawnProjectile().Projectile(iceExplosion4))).ZOffset(0.01);
      
      private static var missileExplosion:ProjectileDef = new ProjectileDef().Display(NuclearExplosion).Pierce(200).Radius(200).EffectMask(Vector.<int>([Bloon.IMMUNITY_NONE])).DamageEffect(new DamageEffectDef().Damage(1).CanBreakIce(true)).ZOffset(0.01);
      
      private static var missile:ProjectileDef = new ProjectileDef().Display(TempleMissile).Pierce(1).Radius(5).EffectMask(Vector.<int>([Bloon.IMMUNITY_NONE])).Behavior(new ninjakiwi.monkeyTown.btdModule.projectiles.behavior.BehaviorDef().Collision(new CollisionSpawnProjectile().Projectile(missileExplosion))).ZOffset(0.01);
      
      private static var missileExplosion2:ProjectileDef = new ProjectileDef().Display(NuclearExplosion).Pierce(200).Radius(200).EffectMask(Vector.<int>([Bloon.IMMUNITY_NONE])).DamageEffect(new DamageEffectDef().Damage(2).CanBreakIce(true)).ZOffset(0.01);
      
      private static var missile2:ProjectileDef = new ProjectileDef().Display(TempleMissile).Pierce(1).Radius(5).EffectMask(Vector.<int>([Bloon.IMMUNITY_NONE])).Behavior(new ninjakiwi.monkeyTown.btdModule.projectiles.behavior.BehaviorDef().Collision(new CollisionSpawnProjectile().Projectile(missileExplosion2))).ZOffset(0.01);
      
      private static var missileExplosion3:ProjectileDef = new ProjectileDef().Display(NuclearExplosion).Pierce(150).Radius(150).EffectMask(Vector.<int>([Bloon.IMMUNITY_NONE])).DamageEffect(new DamageEffectDef().Damage(2).CanBreakIce(true)).ZOffset(0.01);
      
      private static var missile3:ProjectileDef = new ProjectileDef().Display(TempleMissile).Pierce(1).Radius(5).EffectMask(Vector.<int>([Bloon.IMMUNITY_NONE])).Behavior(new ninjakiwi.monkeyTown.btdModule.projectiles.behavior.BehaviorDef().Collision(new CollisionSpawnProjectile().Projectile(missileExplosion3))).ZOffset(0.01);
      
      private static var missileExplosion4:ProjectileDef = new ProjectileDef().Display(NuclearExplosion).Pierce(150).Radius(150).EffectMask(Vector.<int>([Bloon.IMMUNITY_NONE])).DamageEffect(new DamageEffectDef().Damage(2).CanBreakIce(true).MOABScale(10)).ZOffset(0.01);
      
      private static var missile4:ProjectileDef = new ProjectileDef().Display(TempleMissile).Pierce(1).Radius(5).EffectMask(Vector.<int>([Bloon.IMMUNITY_NONE])).Behavior(new ninjakiwi.monkeyTown.btdModule.projectiles.behavior.BehaviorDef().Collision(new CollisionSpawnProjectile().Projectile(missileExplosion4))).ZOffset(0.01);
      
      private static var glueExplosion:ProjectileDef = new ProjectileDef().Display(GodGlueSplat).Pierce(150).Radius(30).EffectMask(Vector.<int>([Bloon.IMMUNITY_NONE])).GlueEffect(new GlueEffectDef().SpeedScale(0.5).Lifespan(22.86).Soak(true)).ZOffset(0.01);
      
      private static var glue:ProjectileDef = new ProjectileDef().Display(GodGlueShot).Pierce(1).Radius(5).EffectMask(Vector.<int>([Bloon.IMMUNITY_NONE])).Behavior(new ninjakiwi.monkeyTown.btdModule.projectiles.behavior.BehaviorDef().Collision(new CollisionSpawnProjectile().Projectile(glueExplosion))).ZOffset(0.01);
      
      private static var glueExplosion2:ProjectileDef = new ProjectileDef().Display(GodGlueSplat).Pierce(150).Radius(30).EffectMask(Vector.<int>([Bloon.IMMUNITY_NONE])).GlueEffect(new GlueEffectDef().SpeedScale(0.5).Lifespan(22.86).Soak(true).CorosionInterval(2.29)).ZOffset(0.01);
      
      private static var glue2:ProjectileDef = new ProjectileDef().Display(GodGlueShot).Pierce(1).Radius(5).EffectMask(Vector.<int>([Bloon.IMMUNITY_NONE])).Behavior(new ninjakiwi.monkeyTown.btdModule.projectiles.behavior.BehaviorDef().Collision(new CollisionSpawnProjectile().Projectile(glueExplosion2))).ZOffset(0.01);
      
      private static var glueExplosion3:ProjectileDef = new ProjectileDef().Display(GodGlueSplat).Pierce(150).Radius(36).EffectMask(Vector.<int>([Bloon.IMMUNITY_NONE])).GlueEffect(new GlueEffectDef().SpeedScale(0.5).Lifespan(22.86).Soak(true).CorosionInterval(1)).ZOffset(0.01);
      
      private static var glue3:ProjectileDef = new ProjectileDef().Display(GodGlueShot).Pierce(1).Radius(5).EffectMask(Vector.<int>([Bloon.IMMUNITY_NONE])).Behavior(new ninjakiwi.monkeyTown.btdModule.projectiles.behavior.BehaviorDef().Collision(new CollisionSpawnProjectile().Projectile(glueExplosion3))).ZOffset(0.01);
      
      private static var glueExplosion4:ProjectileDef = new ProjectileDef().Display(GodGlueSplat).Pierce(150).Radius(43).EffectMask(Vector.<int>([Bloon.IMMUNITY_NONE])).GlueEffect(new GlueEffectDef().SpeedScale(0.5).Lifespan(22.86).Soak(true).CorosionInterval(0.5)).DamageEffect(new DamageEffectDef().Damage(1).CanBreakIce(true)).ZOffset(0.01);
      
      private static var glue4:ProjectileDef = new ProjectileDef().Display(GodGlueShot).Pierce(1).Radius(5).EffectMask(Vector.<int>([Bloon.IMMUNITY_NONE])).Behavior(new ninjakiwi.monkeyTown.btdModule.projectiles.behavior.BehaviorDef().Collision(new CollisionSpawnProjectile().Projectile(glueExplosion3))).ZOffset(0.01);
      
      private static var glueExplosion5:ProjectileDef = new ProjectileDef().Display(GodGlueSplat).Pierce(150).Radius(52).EffectMask(Vector.<int>([Bloon.IMMUNITY_NONE])).GlueEffect(new GlueEffectDef().SpeedScale(0.5).Lifespan(22.86).Soak(true).CorosionInterval(0.5)).DamageEffect(new DamageEffectDef().Damage(1).CanBreakIce(true)).ZOffset(0.01);
      
      private static var glue5:ProjectileDef = new ProjectileDef().Display(GodGlueShot).Pierce(1).Radius(5).EffectMask(Vector.<int>([Bloon.IMMUNITY_NONE])).Behavior(new ninjakiwi.monkeyTown.btdModule.projectiles.behavior.BehaviorDef().Collision(new CollisionSpawnProjectile().Projectile(glueExplosion3))).ZOffset(0.01);
      
      private static var whirlwind:ProjectileDef = new ProjectileDef().Display(Tornado).Pierce(60).Radius(30).EffectMask(Vector.<int>([Bloon.IMMUNITY_NONE])).WindEffect(new WindEffectDef().Speed(300)).ZOffset(0.01);
      
      private static var whirlwind2:ProjectileDef = new ProjectileDef().Display(Tornado).Pierce(90).Radius(30).EffectMask(Vector.<int>([Bloon.IMMUNITY_NONE])).WindEffect(new WindEffectDef().Speed(300)).ZOffset(0.01);
      
      private static var whirlwind3:ProjectileDef = new ProjectileDef().Display(Tornado).Pierce(120).Radius(30).EffectMask(Vector.<int>([Bloon.IMMUNITY_NONE])).WindEffect(new WindEffectDef().Speed(300)).DamageEffect(new DamageEffectDef().Damage(1).CanBreakIce(true)).ZOffset(0.01);
      
      private static var whirlwind4:ProjectileDef = new ProjectileDef().Display(Tornado).Pierce(150).Radius(30).EffectMask(Vector.<int>([Bloon.IMMUNITY_NONE])).WindEffect(new WindEffectDef().Speed(300)).DamageEffect(new DamageEffectDef().Damage(1).CanBreakIce(true)).ZOffset(0.01);
      
      private static var whirlwind5:ProjectileDef = new ProjectileDef().Display(Tornado).Pierce(150).Radius(30).EffectMask(Vector.<int>([Bloon.IMMUNITY_NONE])).WindEffect(new WindEffectDef().Speed(300)).DamageEffect(new DamageEffectDef().Damage(2).CanBreakIce(true)).ZOffset(0.01);
      
      private static var stageGate:Vector.<int> = Vector.<int>([1500,4000,10000,30000]);
      
      private static var sharpUpgrades:Vector.<UpgradeDef> = Vector.<UpgradeDef>([new UpgradeDef().Id("templeSharp1").Add(new AddDef().Weapons(Vector.<Weapon>([new Spread().Count(16).Angle(Math.PI * 2 * 15 / 16).ReloadTime(0.8).Projectile(dart).Range(1000).Power(600).Rotate(false)]))),new UpgradeDef().Id("templeSharp2").Add(new AddDef().Weapons(Vector.<Weapon>([new Spread().Count(16).Angle(Math.PI * 2 * 15 / 16).ReloadTime(0.8).Projectile(dart2).Range(1000).Power(600).Rotate(false)]))),new UpgradeDef().Id("templeSharp3").Add(new AddDef().Weapons(Vector.<Weapon>([new Spread().Count(16).Angle(Math.PI * 2 * 15 / 16).ReloadTime(0.8).Projectile(blade).Range(1000).Power(600).Rotate(false)]))),new UpgradeDef().Id("templeSharp4").Add(new AddDef().Weapons(Vector.<Weapon>([new Spread().Count(16).Angle(Math.PI * 2 * 31 / 32).ReloadTime(0.8).Projectile(blade).Range(1000).Power(600).Rotate(false)]))),new UpgradeDef().Id("templeSharp5").Add(new AddDef().Weapons(Vector.<Weapon>([new Spread().Count(16).Angle(Math.PI * 2 * 31 / 32).ReloadTime(0.8).Projectile(bladePlasma).Range(1000).Power(600).Rotate(false)])))]);
      
      private static var freezeUpgrades:Vector.<UpgradeDef> = Vector.<UpgradeDef>([new UpgradeDef().Id("templeFreeze1").Add(new AddDef().Weapons(Vector.<Weapon>([new Single().ReloadTime(2).Projectile(iceBomb).Range(1000).Power(600).Rotate(false)]))),new UpgradeDef().Id("templeFreeze2").Add(new AddDef().Weapons(Vector.<Weapon>([new Single().ReloadTime(2).Projectile(iceBomb2).Range(1000).Power(600).Rotate(false)]))),new UpgradeDef().Id("templeFreeze3").Add(new AddDef().Weapons(Vector.<Weapon>([new Single().ReloadTime(2).Projectile(iceBomb3).Range(1000).Power(600).Rotate(false)]))),new UpgradeDef().Id("templeFreeze4").Add(new AddDef().Weapons(Vector.<Weapon>([new Single().ReloadTime(2).Projectile(iceBomb4).Range(1000).Power(600).Rotate(false)]))),new UpgradeDef().Id("templeFreeze5").Add(new AddDef().Behavior(new BehaviorModDef().BehaviorSet(new ninjakiwi.monkeyTown.btdModule.towers.behavior.BehaviorDef().RoundStart(new SpawnArcticWind()).RoundOver(new RetractArcticWind()))).Weapons(Vector.<Weapon>([new Single().ReloadTime(2).Projectile(iceBomb4).Range(1000).Power(600).Rotate(false)])))]);
      
      private static var explosionUpgrades:Vector.<UpgradeDef> = Vector.<UpgradeDef>([new UpgradeDef().Id("explosionUpgrade1").Add(new AddDef().Weapons(Vector.<Weapon>([new Single().ReloadTime(1).Projectile(missile).Range(1000).Power(600).Rotate(false)]))),new UpgradeDef().Id("explosionUpgrade2").Add(new AddDef().Weapons(Vector.<Weapon>([new Single().ReloadTime(1).Projectile(missile2).Range(1000).Power(600).Rotate(false)]))),new UpgradeDef().Id("explosionUpgrade3").Add(new AddDef().Weapons(Vector.<Weapon>([new SingleAtMultiTarget().ReloadTime(1).Projectile(missile3).Range(1000).Power(600).Count(3).Rotate(false)]))),new UpgradeDef().Id("explosionUpgrade4").Add(new AddDef().Weapons(Vector.<Weapon>([new SingleAtMultiTarget().ReloadTime(1).Projectile(missile4).Range(1000).Power(600).Count(3).Rotate(false)]))),new UpgradeDef().Id("explosionUpgrade5").Add(new AddDef().Weapons(Vector.<Weapon>([new SingleAtMultiTarget().ReloadTime(1).Projectile(missile4).Range(1000).Power(600).Count(6).Rotate(false)])))]);
      
      private static var glueUpgrades:Vector.<UpgradeDef> = Vector.<UpgradeDef>([new UpgradeDef().Id("templeGlue1").Add(new AddDef().Weapons(Vector.<Weapon>([new Single().ReloadTime(0.5).Projectile(glue).Range(1000).Power(600).Rotate(false)]))),new UpgradeDef().Id("templeGlue2").Add(new AddDef().Weapons(Vector.<Weapon>([new Single().ReloadTime(0.5).Projectile(glue2).Range(1000).Power(600).Rotate(false)]))),new UpgradeDef().Id("templeGlue3").Add(new AddDef().Weapons(Vector.<Weapon>([new Single().ReloadTime(0.5).Projectile(glue3).Range(1000).Power(600).Rotate(false)]))),new UpgradeDef().Id("templeGlue4").Add(new AddDef().Weapons(Vector.<Weapon>([new Single().ReloadTime(0.5).Projectile(glue4).Range(1000).Power(600).Rotate(false)]))),new UpgradeDef().Id("templeGlue5").Add(new AddDef().Weapons(Vector.<Weapon>([new Single().ReloadTime(0.5).Projectile(glue5).Range(1000).Power(600).Rotate(false)])))]);
      
      private static var windUpgrades:Vector.<UpgradeDef> = Vector.<UpgradeDef>([new UpgradeDef().Id("templeWind1").Add(new AddDef().Weapons(Vector.<Weapon>([new Single().Range(1000).Power(500).Projectile(whirlwind).ReloadTime(1.25).Rotate(false)]))),new UpgradeDef().Id("templeWind2").Add(new AddDef().Weapons(Vector.<Weapon>([new Single().Range(1000).Power(500).Projectile(whirlwind2).ReloadTime(1.25).Rotate(false)]))),new UpgradeDef().Id("templeWind3").Add(new AddDef().Weapons(Vector.<Weapon>([new Single().Range(1000).Power(500).Projectile(whirlwind3).ReloadTime(1.25).Rotate(false)]))),new UpgradeDef().Id("templeWind4").Add(new AddDef().Weapons(Vector.<Weapon>([new Single().Range(1000).Power(500).Projectile(whirlwind4).ReloadTime(1.25).Rotate(false)]))),new UpgradeDef().Id("templeWind5").Add(new AddDef().Weapons(Vector.<Weapon>([new Single().Range(1000).Power(500).Projectile(whirlwind5).ReloadTime(1.25).Rotate(false)])))]);
      
      private static var upgrades:Dictionary = new Dictionary();
      
      public static var effectClass:Class = MonkeyGod;
      
      public static const plasmaDart:ProjectileDef = new ProjectileDef().Display(SunBall).Pierce(50).Radius(40).AdditiveBlend(true).EffectMask(Vector.<int>([Bloon.IMMUNITY_NONE])).DamageEffect(new DamageEffectDef().Damage(3).CanBreakIce(true));
       
      
      public function Sacrifice()
      {
         super();
         upgrades[SACRIFICE_TYPE_FREEZE] = freezeUpgrades;
         upgrades[SACRIFICE_TYPE_EXPLOSION] = explosionUpgrades;
         upgrades[SACRIFICE_TYPE_SHARP] = sharpUpgrades;
         upgrades[SACRIFICE_TYPE_GLUE] = glueUpgrades;
         upgrades[SACRIFICE_TYPE_WIND] = windUpgrades;
      }
      
      public static function getGate(param1:int) : int
      {
         var _loc2_:int = stageGate.length - 1;
         while(_loc2_ >= 0)
         {
            if(param1 >= stageGate[_loc2_])
            {
               return _loc2_ + 1;
            }
            _loc2_--;
         }
         return 0;
      }
      
      public static function addUpgrades(param1:Tower, param2:Vector.<int>) : void
      {
         var _loc6_:int = 0;
         var _loc7_:Vector.<AreaEffectDef> = null;
         var _loc8_:int = 0;
         var _loc9_:AreaEffectDef = null;
         Sacrifice.sacrificeSpentOn[param1] = param2;
         var _loc3_:UpgradeDef = new UpgradeDef().Id("templePlasma").Add(new AddDef().Weapons(Vector.<Weapon>([new Single().ReloadTime(0.1).Projectile(plasmaDart).Range(1000).Power(600).Rotate(false)])));
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         for each(_loc6_ in param2)
         {
            if(_loc6_ == 0)
            {
               _loc5_++;
            }
            else
            {
               _loc8_ = getGate(_loc6_);
               _loc4_ = _loc4_ + (_loc8_ + 1);
               param1.addUpgrade(upgrades[_loc5_][_loc8_],false);
               _loc5_++;
            }
         }
         plasmaDart.pierce = plasmaDart.pierce + 5 * _loc4_;
         plasmaDart.damageEffect.damage = plasmaDart.damageEffect.damage + Math.floor(_loc4_ / 2);
         param1.addUpgrade(_loc3_,false);
         _loc7_ = param1.level.getAreaEffects(param1.x,param1.y,param1);
         if(_loc7_ != null)
         {
            for each(_loc9_ in _loc7_)
            {
               if(_loc9_.upgrade != null)
               {
                  param1.addUpgrade(_loc9_.upgrade,false);
               }
            }
         }
         param1.initialise(Combinator.combine(Main.instance.towerFactory.getBaseTower("TempleOfTheMonkeyGod"),param1.upgrades),param1.level,false);
      }
      
      override public function execute(param1:Tower) : void
      {
         var tempTimer:GameSpeedTimer = null;
         var sT:Tower = null;
         var sacrificedValueScale:Number = NaN;
         var i:int = 0;
         var buff:Buff = null;
         var tID:String = null;
         var up:UpgradeDef = null;
         var tower:Tower = param1;
         if(tower.def.weapons != null || dont.indexOf(tower) != -1)
         {
            return;
         }
         dont.push(tower);
         sacrificeSpentOn[tower] = Vector.<int>([0,0,0,0,0]);
         new MaxSound(TempleSacrifice).play();
         var mc:Effect = new Effect();
         mc.initialise(effectClass,4);
         mc.x = tower.x;
         mc.y = tower.y;
         tower.level.addEntity(mc);
         tower.pause = true;
         tower.pauseDraw = true;
         tempTimer = new GameSpeedTimer((mc.clip.totalFrames - 2) / 30);
         tempTimer.extra = {"tower":tower};
         tempTimer.addEventListener(GameSpeedTimer.COMPLETE,function(param1:Event):void
         {
            (param1.target as GameSpeedTimer).extra.tower.pause = false;
            (param1.target as GameSpeedTimer).extra.tower.pauseDraw = false;
            tempTimer.removeEventListener(GameSpeedTimer.COMPLETE,arguments.callee);
            (param1.target as GameSpeedTimer).extra.tower.rotation = 0;
            (param1.target as GameSpeedTimer).extra.tower.addonRotation[(param1.target as GameSpeedTimer).extra.tower.addonClips[0]] = Math.PI / 2;
         });
         tower.rotation = 0;
         var sacrificedTowers:Vector.<Tower> = tower.level.getTowersInRange(tower.x,tower.y,tower.def.rangeOfVisibility - 100);
         var newSacrifiecedTowers:Vector.<Tower> = new Vector.<Tower>();
         for each(sT in sacrificedTowers)
         {
            if(sT.resellable)
            {
               newSacrifiecedTowers.push(sT);
            }
         }
         sacrificedTowers = newSacrifiecedTowers;
         sacrificedValueScale = 1;
         i = 0;
         while(i < tower.def.buffs.length)
         {
            buff = tower.def.buffs[i];
            if(SacrificeValueScaleSet == buff.buffMethodModuleClass)
            {
               if(buff.buffValue > sacrificedValueScale)
               {
                  sacrificedValueScale = buff.buffValue;
               }
            }
            i++;
         }
         for each(sT in sacrificedTowers)
         {
            if(!(sT == tower || sT.def == null || !sT.canSell || sT.def.isPlatform))
            {
               mc = new Effect();
               mc.initialise(DartMonkeyLightningblast,4);
               mc.x = sT.x;
               mc.y = sT.y;
               tower.level.addEntity(mc);
               sacrificeSpentOn[tower][sT.def.sacrificeType] = sacrificeSpentOn[tower][sT.def.sacrificeType] + sT.spentOn * sacrificedValueScale;
            }
         }
         for each(sT in sacrificedTowers)
         {
            if(!(sT == tower || sT.def == null || !sT.canSell || sT.def.isPlatform))
            {
               tID = sT.rootID;
               tower.level.removeTower(sT);
               sT.destroy();
            }
         }
         tower.rotation = 0;
         if(tower.upgrades != null)
         {
            for each(up in tower.upgrades)
            {
               if(up.id != null && up.id.indexOf("Test") != -1)
               {
                  tower.removeUpgrade(up,false);
               }
            }
         }
         addUpgrades(tower,sacrificeSpentOn[tower]);
      }
   }
}

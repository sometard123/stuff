package ninjakiwi.monkeyTown.btdModule.abilities
{
   import assests.effects.DartMonkeyFullScreen;
   import assests.effects.DartMonkeyLightningblast;
   import assets.towers.DartLongSharp;
   import assets.towers.DartLongerRazor;
   import assets.towers.DartMonkey;
   import assets.towers.DartSuperCall;
   import assets.towers.SuperMonkey;
   import assets.towers.TripleShot;
   import flash.events.Event;
   import flash.utils.Dictionary;
   import ninjakiwi.monkeyTown.btdModule.abilities.def.AbilityDef;
   import ninjakiwi.monkeyTown.btdModule.entities.Effect;
   import ninjakiwi.monkeyTown.btdModule.towers.Tower;
   import ninjakiwi.monkeyTown.btdModule.towers.def.TowerDef;
   import ninjakiwi.monkeyTown.btdModule.towers.def.TowerDisplayMod;
   import ninjakiwi.monkeyTown.btdModule.towers.upgrades.AddDef;
   import ninjakiwi.monkeyTown.btdModule.towers.upgrades.UpgradeDef;
   import ninjakiwi.monkeyTown.btdModule.towers.upgrades.WeaponModDef;
   import ninjakiwi.monkeyTown.btdModule.utils.GameSpeedTimer;
   import ninjakiwi.monkeyTown.btdModule.weapons.Spread;
   
   public class SuperMonkeyFanClub extends Ability
   {
      
      private static var affectedTowerTimers:Dictionary = new Dictionary();
       
      
      private var oldDef:TowerDef = null;
      
      public function SuperMonkeyFanClub()
      {
         super();
      }
      
      override public function execute(param1:Tower, param2:AbilityDef) : void
      {
         var superUpgrade:UpgradeDef = null;
         var t:Tower = null;
         var mc:Effect = null;
         var foundExistingFanClubUpgrade:Boolean = false;
         var item:UpgradeDef = null;
         var timer:GameSpeedTimer = null;
         var previousSpreadAngle:Number = NaN;
         var matchingTimer:GameSpeedTimer = null;
         var tower:Tower = param1;
         var def:AbilityDef = param2;
         superUpgrade = new UpgradeDef().Id("SuperMonkeyFanClubUpgrade").Add(new AddDef().Display(Vector.<TowerDisplayMod>([new TowerDisplayMod().UseFor(DartMonkey).Display(SuperMonkey),new TowerDisplayMod().UseFor(TripleShot).Display(SuperMonkey),new TowerDisplayMod().UseFor(DartSuperCall).Display(SuperMonkey),new TowerDisplayMod().UseFor(DartLongerRazor).Display(SuperMonkey),new TowerDisplayMod().UseFor(DartLongSharp).Display(SuperMonkey)])).RangeOfVisibility(40).WeaponMod(new WeaponModDef().ReloadTimeAsScale(true).ReloadTime(0.05)));
         var convertTowers:Vector.<Tower> = new Vector.<Tower>();
         convertTowers.push(tower);
         for each(t in tower.level.allTowers)
         {
            if(t != tower)
            {
               if(t.def.id == "DartMonkey" || t.def.id == "TripleDarts" || t.def.id == "SuperMonkeyFanClub")
               {
                  convertTowers.push(t);
                  if(convertTowers.length >= 10)
                  {
                     break;
                  }
               }
            }
         }
         mc = new Effect();
         mc.initialise(DartMonkeyFullScreen,4);
         tower.level.addEntity(mc);
         for each(t in convertTowers)
         {
            foundExistingFanClubUpgrade = false;
            for each(item in t.upgrades)
            {
               if(item.id == "SuperMonkeyFanClubUpgrade")
               {
                  matchingTimer = affectedTowerTimers[t] as GameSpeedTimer;
                  if(!matchingTimer || false == matchingTimer.running)
                  {
                     continue;
                  }
                  matchingTimer.current = 0;
                  mc = new Effect();
                  mc.initialise(DartMonkeyLightningblast,3);
                  mc.x = t.x;
                  mc.y = t.y;
                  tower.level.addEntity(mc);
                  foundExistingFanClubUpgrade = true;
                  break;
               }
            }
            if(!foundExistingFanClubUpgrade)
            {
               timer = new GameSpeedTimer(15);
               timer.extra = {
                  "oldDef":t.def,
                  "tower":t
               };
               t.addUpgrade(superUpgrade);
               previousSpreadAngle = 0;
               if(t.def.id == "TripleDarts" || t.def.id == "SuperMonkeyFanClub")
               {
                  previousSpreadAngle = Spread(t.def.weapons[0]).angle;
                  Spread(t.def.weapons[0]).Angle(0);
               }
               mc = new Effect();
               mc.initialise(DartMonkeyLightningblast,3);
               mc.x = t.x;
               mc.y = t.y;
               tower.level.addEntity(mc);
               affectedTowerTimers[t] = timer;
               timer.addEventListener(GameSpeedTimer.COMPLETE,function onEnd(param1:Event):void
               {
                  if(tower.level.allTowers.indexOf(t) === -1)
                  {
                     return;
                  }
                  (param1.target as GameSpeedTimer).extra.tower.removeUpgrade(superUpgrade);
                  if(t.def.id == "TripleDarts" || t.def.id == "SuperMonkeyFanClub")
                  {
                     if(t.def.weapons.length != 0)
                     {
                        Spread(t.def.weapons[0]).Angle(previousSpreadAngle);
                     }
                  }
                  timer.removeEventListener(GameSpeedTimer.COMPLETE,onEnd);
               });
            }
         }
         super.execute(tower,def);
      }
   }
}

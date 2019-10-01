package ninjakiwi.monkeyTown.btdModule.towers
{
   import assest.towers.Blizzard;
   import assest.towers.FastFire;
   import assest.towers.Ninja;
   import assests.effects.Bombtoweraura;
   import assests.effects.BoomerangAura;
   import assests.effects.DartlingGunAura;
   import assests.effects.GlueGunnerRain;
   import assests.effects.IceTowerSnowStorm;
   import assests.effects.MonkeyAceNuclearBlast;
   import assests.effects.MonkeyApprenticeFieryRing;
   import assests.effects.MonkeyVillagePulse;
   import assests.effects.MortarTowerArtillaryRain;
   import assests.effects.SniperBeacon;
   import assests.effects.SpikeFactoryAura;
   import assests.effects.SuperMonkeyShockwave;
   import assests.effects.TackTowerSpiral;
   import assets.PlayUI.ADS;
   import assets.PlayUI.Battery;
   import assets.PlayUI.BigOne;
   import assets.PlayUI.Bloonjitsu;
   import assets.PlayUI.CallToArms;
   import assets.PlayUI.Carrier;
   import assets.PlayUI.CrippleMOAB;
   import assets.PlayUI.DartStorm;
   import assets.PlayUI.DeadlyPrecision;
   import assets.PlayUI.Destroyer;
   import assets.PlayUI.DoomRay;
   import assets.PlayUI.DoubleShurikens;
   import assets.PlayUI.EnergyBeacon;
   import assets.PlayUI.ExtraRangeTacks;
   import assets.PlayUI.FlashBombs;
   import assets.PlayUI.GroundZero;
   import assets.PlayUI.HydraRockets;
   import assets.PlayUI.InvestmentAdvisory;
   import assets.PlayUI.MAOBShredder;
   import assets.PlayUI.MIB;
   import assets.PlayUI.MOABMauler;
   import assets.PlayUI.MonkeyBank;
   import assets.PlayUI.NevaMissAce;
   import assets.PlayUI.PermaFrost;
   import assets.PlayUI.Phoenix;
   import assets.PlayUI.PineappleExpress;
   import assets.PlayUI.Pirates;
   import assets.PlayUI.ResearchFacility;
   import assets.PlayUI.Ricochet;
   import assets.PlayUI.SemiAuto;
   import assets.PlayUI.Sentry;
   import assets.PlayUI.SignalFlare;
   import assets.PlayUI.SniperMonkey;
   import assets.PlayUI.Spectre;
   import assets.PlayUI.SunGod;
   import assets.PlayUI.TechTerror;
   import assets.PlayUI.Temple;
   import assets.PlayUI.TurboCharge;
   import assets.PlayUI.ViralFrost;
   import assets.PlayUI.Whirlwind;
   import assets.ability.ActivatedAbilityBombTower;
   import assets.ability.ActivatedAbilityBoomerangThrower;
   import assets.ability.ActivatedAbilityDartMonkey;
   import assets.ability.ActivatedAbilityDartlingGun;
   import assets.ability.ActivatedAbilityGlueGunner;
   import assets.ability.ActivatedAbilityIceTower;
   import assets.ability.ActivatedAbilityMonkeyAce;
   import assets.ability.ActivatedAbilityMonkeyApprentice;
   import assets.ability.ActivatedAbilityMonkeyBuccaneer;
   import assets.ability.ActivatedAbilityMonkeyEngineer;
   import assets.ability.ActivatedAbilityMonkeyVillage;
   import assets.ability.ActivatedAbilityMortarTower;
   import assets.ability.ActivatedAbilityNinjaMonkey;
   import assets.ability.ActivatedAbilitySniperMonkey;
   import assets.ability.ActivatedAbilitySpikeFactory;
   import assets.ability.ActivatedAbilitySuperMonkey;
   import assets.ability.ActivatedAbilityTackTower;
   import assets.detailView.Apprentice;
   import assets.detailView.BloonLiquefier;
   import assets.detailView.BloonTrap;
   import assets.detailView.BombRange;
   import assets.detailView.BoomerangMonkey;
   import assets.detailView.Buccaneer;
   import assets.detailView.CleansingFoam;
   import assets.detailView.DepletedPlutonium;
   import assets.detailView.Engineer;
   import assets.detailView.EnhancedVision;
   import assets.detailView.EvenFasterTack;
   import assets.detailView.ExtraRangeTack;
   import assets.detailView.FanClub;
   import assets.detailView.FastProductionSpikes;
   import assets.detailView.FastSniper;
   import assets.detailView.FasterEngineering;
   import assets.detailView.FasterProductionSpikes;
   import assets.detailView.FasterShootingBuccaneer;
   import assets.detailView.FasterSpin;
   import assets.detailView.FasterTack;
   import assets.detailView.FireBall;
   import assets.detailView.GlueHoser;
   import assets.detailView.GlueMonkey;
   import assets.detailView.HotRangas;
   import assets.detailView.LargerArea;
   import assets.detailView.Lightning;
   import assets.detailView.LongLifeNanas;
   import assets.detailView.MOABShredder;
   import assets.detailView.Maelstrom;
   import assets.detailView.MonkeyAce;
   import assets.detailView.MortarAccuracy;
   import assets.detailView.MortarBiggerBlast;
   import assets.detailView.MortarMonkey;
   import assets.detailView.MortarReload;
   import assets.detailView.MultiBoomerang;
   import assets.detailView.NIN;
   import assets.detailView.NinjaMonkey;
   import assets.detailView.Overclock;
   import assets.detailView.PineAppleExpress;
   import assets.detailView.Pineapple;
   import assets.detailView.RapidFireAce;
   import assets.detailView.SharperDartsAce;
   import assets.detailView.SnowMonkey;
   import assets.detailView.SpikeBallFactory;
   import assets.detailView.SpikeFactory;
   import assets.detailView.SpikeMineFactory;
   import assets.detailView.Sprockets;
   import assets.detailView.SuperLasers;
   import assets.detailView.SuperPlasma;
   import assets.detailView.SuperRangeTacks;
   import assets.detailView.TripleDarts;
   import assets.detailView.ValuableNanas;
   import assets.occupiedSpace.AceSpace;
   import assets.occupiedSpace.BananaFarmSpace;
   import assets.occupiedSpace.Large;
   import assets.occupiedSpace.Medium;
   import assets.occupiedSpace.MortarMonkeySpace;
   import assets.occupiedSpace.Small;
   import assets.occupiedSpace.TempleSpace;
   import assets.occupiedSpace.VillageSpace;
   import assets.projectile.Acorn;
   import assets.projectile.ApprenticeBreath;
   import assets.projectile.ApprenticeDisspate;
   import assets.projectile.BananaCrate;
   import assets.projectile.Bananas;
   import assets.projectile.BigBomb;
   import assets.projectile.BladeMaelstrom;
   import assets.projectile.BlobYellow;
   import assets.projectile.Bomb;
   import assets.projectile.BombCluster;
   import assets.projectile.Boomerang;
   import assets.projectile.BuccaneerDart;
   import assets.projectile.BurnyLargeExplosion;
   import assets.projectile.BurnyMediumExplosion;
   import assets.projectile.BurnyNuclearExplosion;
   import assets.projectile.BurnySlightlyLargerExplosion;
   import assets.projectile.Dart;
   import assets.projectile.DissloverShot;
   import assets.projectile.FireDissRed;
   import assets.projectile.Fireball;
   import assets.projectile.FlashBomb;
   import assets.projectile.FragShard;
   import assets.projectile.Glaive;
   import assets.projectile.GlueShot;
   import assets.projectile.GlueSplat;
   import assets.projectile.GrapeShot;
   import assets.projectile.HotGlaive;
   import assets.projectile.HotRang;
   import assets.projectile.HydraMissile;
   import assets.projectile.IceBurst;
   import assets.projectile.IceBurstLarge;
   import assets.projectile.IceBurstMedium;
   import assets.projectile.IntenseMagic;
   import assets.projectile.LargeExplosion;
   import assets.projectile.LargeSpikeBall;
   import assets.projectile.Laser;
   import assets.projectile.LaserCannon;
   import assets.projectile.MOAB;
   import assets.projectile.MOABAssassin;
   import assets.projectile.MagicBolt;
   import assets.projectile.MediumExplosion;
   import assets.projectile.Missile;
   import assets.projectile.Nail;
   import assets.projectile.NuclearExplosion;
   import assets.projectile.PineappleBomb;
   import assets.projectile.Plasma;
   import assets.projectile.RingOfFire;
   import assets.projectile.RoadSpikes;
   import assets.projectile.RoboDart;
   import assets.projectile.RoboLaser;
   import assets.projectile.Shuriken;
   import assets.projectile.SlightlyLargerExplosion;
   import assets.projectile.SpectreBomb;
   import assets.projectile.SpikeBall;
   import assets.projectile.SpikeFactoryBall;
   import assets.projectile.SpikeFactorySpikes;
   import assets.projectile.SpikeMineBall;
   import assets.projectile.SunBeam;
   import assets.projectile.Tack;
   import assets.projectile.Tempest;
   import assets.projectile.TerrorBlast;
   import assets.projectile.TerrorShot;
   import assets.projectile.TinyTornado;
   import assets.projectile.Tornado;
   import assets.sound.AbsoluteZeroIceTower;
   import assets.sound.CrateDropPlaneEntrance;
   import assets.sound.GlueStrike;
   import assets.sound.GrapplingHookExtend;
   import assets.sound.MIBCallToArms;
   import assets.sound.MoabAssassinMissile;
   import assets.sound.SuperHeroUpgrade;
   import assets.sound.TechnoTerrorAbility;
   import assets.sound.TurboBoomerang;
   import assets.tower.BuccaneerCannonsLeft;
   import assets.tower.BuccaneerCannonsRight;
   import assets.tower.HarpoonLeft;
   import assets.tower.HarpoonRight;
   import assets.tower.HighCal;
   import assets.tower.TechnoTerrorLeftArm;
   import assets.tower.TechnoTerrorRightArm;
   import assets.towers.AbsoluteZero;
   import assets.towers.AirBase;
   import assets.towers.AircraftCarrier;
   import assets.towers.AntennaBase;
   import assets.towers.ArcticWind;
   import assets.towers.ArtilleryBattery;
   import assets.towers.BananaFarm;
   import assets.towers.BananaInvestmentsAdvisory;
   import assets.towers.BananaRepublic;
   import assets.towers.BananaResearchFacility;
   import assets.towers.Beacon;
   import assets.towers.BionicBoomer;
   import assets.towers.BionicGlaiver;
   import assets.towers.BladeShooter;
   import assets.towers.BloonAreaDenialSystem;
   import assets.towers.BloonBuster;
   import assets.towers.BloonDissolver;
   import assets.towers.BloonImpact;
   import assets.towers.BloonLiquifier;
   import assets.towers.BombTower;
   import assets.towers.BombTowerBiggerRange;
   import assets.towers.BoomerangMulti;
   import assets.towers.BoomerangThrower;
   import assets.towers.Bubbles1;
   import assets.towers.BuccaneerFastGrape;
   import assets.towers.BuccaneerFaster;
   import assets.towers.BuccaneerGrape;
   import assets.towers.CannonShip;
   import assets.towers.CannonShipCannonsLeft;
   import assets.towers.CannonShipCannonsRight;
   import assets.towers.ChinaShop;
   import assets.towers.ChinaShopNightVis;
   import assets.towers.ClusterBombs;
   import assets.towers.ClusterMissile;
   import assets.towers.CrippleMoab;
   import assets.towers.CrippleMoabNightVis;
   import assets.towers.DartLongSharp;
   import assets.towers.DartLongerRazor;
   import assets.towers.DartMonkey;
   import assets.towers.DartSuperCall;
   import assets.towers.DartlingFocused;
   import assets.towers.DartlingGun;
   import assets.towers.DepletedBloontoniumDarts;
   import assets.towers.DragonsBreath;
   import assets.towers.EnergyBeaconRadar;
   import assets.towers.EngineerBloonTrap;
   import assets.towers.EngineerFastBuild;
   import assets.towers.EngineerFoamGun;
   import assets.towers.EngineerFoamGunner;
   import assets.towers.EngineerLargerArea;
   import assets.towers.EngineerMonkey;
   import assets.towers.EngineerNailGun;
   import assets.towers.EngineerNineInchNails;
   import assets.towers.EngineerOverclock;
   import assets.towers.EngineerSentry;
   import assets.towers.EngineerSentryBuilder;
   import assets.towers.EngineerSentryFeet;
   import assets.towers.EngineerSprockets;
   import assets.towers.EvenFasterProduction;
   import assets.towers.FasterBiggerStacks;
   import assets.towers.FasterMineSpike;
   import assets.towers.FasterProduction;
   import assets.towers.FasterSpikeBall;
   import assets.towers.FasterWhiteHotSpikes;
   import assets.towers.FireCircle;
   import assets.towers.Flare;
   import assets.towers.GlaiveLord;
   import assets.towers.GlaiveRicochet;
   import assets.towers.GlueGunner;
   import assets.towers.GlueHose;
   import assets.towers.GlueStickySoak;
   import assets.towers.GlueStriker;
   import assets.towers.HeavyDart;
   import assets.towers.HighCalNightVis;
   import assets.towers.HotGlaiveLord;
   import assets.towers.HotGlaiveRicochet;
   import assets.towers.HotGlaiveThrower;
   import assets.towers.HydraRocketPods;
   import assets.towers.IceShards;
   import assets.towers.IceTower;
   import assets.towers.IntenseFireball;
   import assets.towers.Juggernaut;
   import assets.towers.LaserMonkey;
   import assets.towers.LeftBack;
   import assets.towers.LeftFront;
   import assets.towers.LightningSense;
   import assets.towers.LongerCannonsLeft;
   import assets.towers.LongerCannonsRight;
   import assets.towers.LongerNest;
   import assets.towers.MineSpike;
   import assets.towers.MissileBuster;
   import assets.towers.MoabAssassin;
   import assets.towers.MoabMauler;
   import assets.towers.MoabShreder;
   import assets.towers.MoneyBank;
   import assets.towers.MonkeyAceRapid;
   import assets.towers.MonkeyApprentice;
   import assets.towers.MonkeyBuccaneer;
   import assets.towers.MonkeyGodHead;
   import assets.towers.MonkeyIntelligenceBurau;
   import assets.towers.MonkeyPirates;
   import assets.towers.MonkeyTown;
   import assets.towers.MonkeyTownFort;
   import assets.towers.MonkeyVillage;
   import assets.towers.MortarTower;
   import assets.towers.MortarTowerAccurate;
   import assets.towers.NevaMissTargeting;
   import assets.towers.NightVision;
   import assets.towers.NinjaDouble;
   import assets.towers.Notes;
   import assets.towers.OperationDartStorm;
   import assets.towers.PermaFreeze;
   import assets.towers.PiratesCannonsLeft;
   import assets.towers.PiratesCannonsRight;
   import assets.towers.PlasmaVision;
   import assets.towers.RadarScanner;
   import assets.towers.RayOfDoom;
   import assets.towers.RedHotRangs;
   import assets.towers.RightBack;
   import assets.towers.RightFront;
   import assets.towers.RoboMonkey;
   import assets.towers.RoboMonkeyLeftArm;
   import assets.towers.RoboMonkeyRightArm;
   import assets.towers.Sabotage;
   import assets.towers.SeekingShurikens;
   import assets.towers.SemiAutomatic;
   import assets.towers.SharpShuriken;
   import assets.towers.SharperSpyPlane;
   import assets.towers.SnapFreeze;
   import assets.towers.Sniper;
   import assets.towers.SniperSupply;
   import assets.towers.SnowFlakes;
   import assets.towers.SonicBoom;
   import assets.towers.SonicBoomMulti;
   import assets.towers.SonicGlaiveThrower;
   import assets.towers.SpikeOPult;
   import assets.towers.SpikeStorm;
   import assets.towers.SummonPhoenix;
   import assets.towers.SummonWhirlwind;
   import assets.towers.SunAvatar;
   import assets.towers.SuperMonkey;
   import assets.towers.SuperMonkeyRange;
   import assets.towers.SupplyDrop;
   import assets.towers.TackSprayer;
   import assets.towers.TackTower;
   import assets.towers.TackTowerEvenFaster;
   import assets.towers.TackTowerFaster;
   import assets.towers.TechnologicalTerror;
   import assets.towers.TempestCloud;
   import assets.towers.TempestTornado;
   import assets.towers.TempleOfTheMonkeyGod;
   import assets.towers.TheBigOne;
   import assets.towers.TripleShot;
   import assets.towers.TurboGlaiver;
   import assets.towers.ViralFog;
   import assets.towers.ViralForst;
   import assets.towers.WhiteHotMoabShreder;
   import assets.towers.WhiteHotSpikeStorm;
   import assets.towers.WhiteHotTacks;
   import assets.upgrades.BananaPlantation;
   import assets.upgrades.BiggerBlast;
   import assets.upgrades.BiggerBombs;
   import assets.upgrades.BiggerStacks;
   import assets.upgrades.BombTowerExtraRange;
   import assets.upgrades.BunchoMonkeys;
   import assets.upgrades.BurnyStuff;
   import assets.upgrades.CorrosiveGlue;
   import assets.upgrades.CrowsNest;
   import assets.upgrades.DeepFreeze;
   import assets.upgrades.Distraction;
   import assets.upgrades.DoubleShot;
   import assets.upgrades.EnhancedFreeze;
   import assets.upgrades.EpicRange;
   import assets.upgrades.EvenFaster;
   import assets.upgrades.ExtraRange;
   import assets.upgrades.FastEngineering;
   import assets.upgrades.FastProduction;
   import assets.upgrades.FasterBarrelSpin;
   import assets.upgrades.FasterShoot;
   import assets.upgrades.FasterShooting;
   import assets.upgrades.FiringFaster;
   import assets.upgrades.FocusedFiring;
   import assets.upgrades.FragBombs;
   import assets.upgrades.FullMetalJacket;
   import assets.upgrades.GlaiveRiccochet;
   import assets.upgrades.GlaiveThrower;
   import assets.upgrades.GlueSoak;
   import assets.upgrades.GlueSplatter;
   import assets.upgrades.IncreasedAccuracy;
   import assets.upgrades.JungleDrums;
   import assets.upgrades.LargerServiceArea;
   import assets.upgrades.LightningBolt;
   import assets.upgrades.LongLifeBananas;
   import assets.upgrades.LongRangeDarts;
   import assets.upgrades.LongerCannons;
   import assets.upgrades.MissileLauncher;
   import assets.upgrades.MonkeyBeacon;
   import assets.upgrades.MonkeyFort;
   import assets.upgrades.MonkeyIntelligenceBureau;
   import assets.upgrades.MonkeySense;
   import assets.upgrades.MoreBananas;
   import assets.upgrades.NightVisionGoggles;
   import assets.upgrades.NineInchNails;
   import assets.upgrades.NinjaDiscipline;
   import assets.upgrades.Permafrost;
   import assets.upgrades.PineapplePresent;
   import assets.upgrades.PlasmaBlasts;
   import assets.upgrades.PlasmaCannon;
   import assets.upgrades.PointFiveOh;
   import assets.upgrades.PowerfulDarts;
   import assets.upgrades.RapidFire;
   import assets.upgrades.RapidReload;
   import assets.upgrades.RayofDoom;
   import assets.upgrades.RazorSharpDarts;
   import assets.upgrades.RingofFire;
   import assets.upgrades.SabbotageSupplyLines;
   import assets.upgrades.SanpFreeze;
   import assets.upgrades.SeekingShuriken;
   import assets.upgrades.SemiAutomaticRifle;
   import assets.upgrades.SentryGun;
   import assets.upgrades.SharpDarts;
   import assets.upgrades.SharpShurikens;
   import assets.upgrades.SharperDarts;
   import assets.upgrades.SpikeBalls;
   import assets.upgrades.SpikeMines;
   import assets.upgrades.SpyPlane;
   import assets.upgrades.StickierGlue;
   import assets.upgrades.SuperRange;
   import assets.upgrades.SuperRangeSM;
   import assets.upgrades.Technological;
   import assets.upgrades.TempleoftheMonkeyGod;
   import assets.upgrades.ValuableBananas2;
   import assets.upgrades.VeryLongRange;
   import assets.upgrades.WhiteHotSpikes;
   import assets.upgrades.bananaInvestmentsAdvisory;
   import assets.upgrades.bananaRepublic;
   import assets.upgrades.laserBlasts;
   import flash.display.MovieClip;
   import flash.utils.Dictionary;
   import ninjakiwi.monkeyTown.btdModule.abilities.MOABTakedown;
   import ninjakiwi.monkeyTown.btdModule.abilities.MoabAssasin;
   import ninjakiwi.monkeyTown.btdModule.abilities.OverclockPick;
   import ninjakiwi.monkeyTown.btdModule.abilities.ProjectileHitAll;
   import ninjakiwi.monkeyTown.btdModule.abilities.SuperMonkeyFanClub;
   import ninjakiwi.monkeyTown.btdModule.abilities.Turbo;
   import ninjakiwi.monkeyTown.btdModule.abilities.def.AbilityDef;
   import ninjakiwi.monkeyTown.btdModule.abilities.def.BloonAreaDenialSystemDef;
   import ninjakiwi.monkeyTown.btdModule.abilities.def.MIBCallToArmsDef;
   import ninjakiwi.monkeyTown.btdModule.abilities.def.MOABTakedownDef;
   import ninjakiwi.monkeyTown.btdModule.abilities.def.MaelstromDef;
   import ninjakiwi.monkeyTown.btdModule.abilities.def.MoabAssassinDef;
   import ninjakiwi.monkeyTown.btdModule.abilities.def.OverclockPickDef;
   import ninjakiwi.monkeyTown.btdModule.abilities.def.ProjectileHitAllDef;
   import ninjakiwi.monkeyTown.btdModule.abilities.def.SabotageDef;
   import ninjakiwi.monkeyTown.btdModule.abilities.def.SpawnProjectileDef;
   import ninjakiwi.monkeyTown.btdModule.abilities.def.SpikeStormDef;
   import ninjakiwi.monkeyTown.btdModule.abilities.def.SummonPhoenixDef;
   import ninjakiwi.monkeyTown.btdModule.abilities.def.SuperMonkeyFanClubDef;
   import ninjakiwi.monkeyTown.btdModule.abilities.def.SupplyDropDef;
   import ninjakiwi.monkeyTown.btdModule.abilities.def.TurboDef;
   import ninjakiwi.monkeyTown.btdModule.bloons.Bloon;
   import ninjakiwi.monkeyTown.btdModule.math.CubicBezierDef;
   import ninjakiwi.monkeyTown.btdModule.math.Vector2;
   import ninjakiwi.monkeyTown.btdModule.projectiles.behavior.BehaviorDef;
   import ninjakiwi.monkeyTown.btdModule.projectiles.behavior.collision.CollisionSpawnProjectile;
   import ninjakiwi.monkeyTown.btdModule.projectiles.behavior.collision.RoadSpikeCollision;
   import ninjakiwi.monkeyTown.btdModule.projectiles.behavior.collision.SpawnSpreadCollision;
   import ninjakiwi.monkeyTown.btdModule.projectiles.behavior.destroy.RemoveSpikeSpread;
   import ninjakiwi.monkeyTown.btdModule.projectiles.behavior.destroy.SpawnProjectile;
   import ninjakiwi.monkeyTown.btdModule.projectiles.behavior.lifespanOver.LifeSpanOverBoomerangSpecialty;
   import ninjakiwi.monkeyTown.btdModule.projectiles.behavior.process.CleansingFoamProcess;
   import ninjakiwi.monkeyTown.btdModule.projectiles.behavior.process.FollowPath;
   import ninjakiwi.monkeyTown.btdModule.projectiles.behavior.process.Friction;
   import ninjakiwi.monkeyTown.btdModule.projectiles.behavior.process.GoToNextTarget;
   import ninjakiwi.monkeyTown.btdModule.projectiles.behavior.process.Target;
   import ninjakiwi.monkeyTown.btdModule.projectiles.behavior.roundOver.RoundOverDestroy;
   import ninjakiwi.monkeyTown.btdModule.projectiles.def.BurnEffectDef;
   import ninjakiwi.monkeyTown.btdModule.projectiles.def.DamageEffectDef;
   import ninjakiwi.monkeyTown.btdModule.projectiles.def.GlueEffectDef;
   import ninjakiwi.monkeyTown.btdModule.projectiles.def.IceEffectDef;
   import ninjakiwi.monkeyTown.btdModule.projectiles.def.ProjectileDef;
   import ninjakiwi.monkeyTown.btdModule.projectiles.def.StunEffectDef;
   import ninjakiwi.monkeyTown.btdModule.projectiles.def.WindEffectDef;
   import ninjakiwi.monkeyTown.btdModule.towers.behavior.destroy.RemoveAceAircraft;
   import ninjakiwi.monkeyTown.btdModule.towers.behavior.destroy.SentryDestroy;
   import ninjakiwi.monkeyTown.btdModule.towers.behavior.destroy.UnSacrifice;
   import ninjakiwi.monkeyTown.btdModule.towers.behavior.initialise.ResetRotation;
   import ninjakiwi.monkeyTown.btdModule.towers.behavior.initialise.Sacrifice;
   import ninjakiwi.monkeyTown.btdModule.towers.behavior.initialise.SpawnAce;
   import ninjakiwi.monkeyTown.btdModule.towers.behavior.process.CreateBloonTrap;
   import ninjakiwi.monkeyTown.btdModule.towers.behavior.process.GlaiveLordProcess;
   import ninjakiwi.monkeyTown.btdModule.towers.behavior.process.RayDamage;
   import ninjakiwi.monkeyTown.btdModule.towers.behavior.process.RotateAddonToTarget;
   import ninjakiwi.monkeyTown.btdModule.towers.behavior.process.RotateToMouse;
   import ninjakiwi.monkeyTown.btdModule.towers.behavior.process.RotateToTarget;
   import ninjakiwi.monkeyTown.btdModule.towers.behavior.roundOver.Intrest;
   import ninjakiwi.monkeyTown.btdModule.towers.behavior.roundOver.RetractArcticWind;
   import ninjakiwi.monkeyTown.btdModule.towers.behavior.roundOver.RetractGlaives;
   import ninjakiwi.monkeyTown.btdModule.towers.behavior.roundOver.RetractMonkeyAce;
   import ninjakiwi.monkeyTown.btdModule.towers.behavior.roundOver.RetractRay;
   import ninjakiwi.monkeyTown.btdModule.towers.behavior.roundOver.StopAnimation;
   import ninjakiwi.monkeyTown.btdModule.towers.behavior.roundStart.BananaEmitter;
   import ninjakiwi.monkeyTown.btdModule.towers.behavior.roundStart.DeployMonkeyAce;
   import ninjakiwi.monkeyTown.btdModule.towers.behavior.roundStart.DeployRay;
   import ninjakiwi.monkeyTown.btdModule.towers.behavior.roundStart.SpawnArcticWind;
   import ninjakiwi.monkeyTown.btdModule.towers.behavior.roundStart.SpawnGlaives;
   import ninjakiwi.monkeyTown.btdModule.towers.behavior.roundStart.SwapForProjectile;
   import ninjakiwi.monkeyTown.btdModule.towers.def.AltDisplayAddonDef;
   import ninjakiwi.monkeyTown.btdModule.towers.def.AreaEffectDef;
   import ninjakiwi.monkeyTown.btdModule.towers.def.DisplayAddonDef;
   import ninjakiwi.monkeyTown.btdModule.towers.def.TowerDef;
   import ninjakiwi.monkeyTown.btdModule.towers.def.TowerDisplayMod;
   import ninjakiwi.monkeyTown.btdModule.towers.upgrades.AbilityModDef;
   import ninjakiwi.monkeyTown.btdModule.towers.upgrades.AddDef;
   import ninjakiwi.monkeyTown.btdModule.towers.upgrades.BananaModDef;
   import ninjakiwi.monkeyTown.btdModule.towers.upgrades.BehaviorModDef;
   import ninjakiwi.monkeyTown.btdModule.towers.upgrades.BurnEffectModDef;
   import ninjakiwi.monkeyTown.btdModule.towers.upgrades.DamageEffectModDef;
   import ninjakiwi.monkeyTown.btdModule.towers.upgrades.GlueEffectModDef;
   import ninjakiwi.monkeyTown.btdModule.towers.upgrades.IceEffectModDef;
   import ninjakiwi.monkeyTown.btdModule.towers.upgrades.ProjectileBehaviorModDef;
   import ninjakiwi.monkeyTown.btdModule.towers.upgrades.ProjectileDisplayMod;
   import ninjakiwi.monkeyTown.btdModule.towers.upgrades.ProjectileModDef;
   import ninjakiwi.monkeyTown.btdModule.towers.upgrades.UpgradeDef;
   import ninjakiwi.monkeyTown.btdModule.towers.upgrades.UpgradePathDef;
   import ninjakiwi.monkeyTown.btdModule.towers.upgrades.WeaponModDef;
   import ninjakiwi.monkeyTown.btdModule.towers.upgrades.WeaponReplaceDef;
   import ninjakiwi.monkeyTown.btdModule.towers.upgrades.WindEffectModDef;
   import ninjakiwi.monkeyTown.btdModule.weapons.CastLightning;
   import ninjakiwi.monkeyTown.btdModule.weapons.CastRay;
   import ninjakiwi.monkeyTown.btdModule.weapons.Circular;
   import ninjakiwi.monkeyTown.btdModule.weapons.CreateSentry;
   import ninjakiwi.monkeyTown.btdModule.weapons.FireAtMouse;
   import ninjakiwi.monkeyTown.btdModule.weapons.FireAtMouseSpread;
   import ninjakiwi.monkeyTown.btdModule.weapons.FireAtReticle;
   import ninjakiwi.monkeyTown.btdModule.weapons.Independent;
   import ninjakiwi.monkeyTown.btdModule.weapons.Instant;
   import ninjakiwi.monkeyTown.btdModule.weapons.LaunchAircraft;
   import ninjakiwi.monkeyTown.btdModule.weapons.LaunchBee;
   import ninjakiwi.monkeyTown.btdModule.weapons.Sequence;
   import ninjakiwi.monkeyTown.btdModule.weapons.SideSingle;
   import ninjakiwi.monkeyTown.btdModule.weapons.SideSpread;
   import ninjakiwi.monkeyTown.btdModule.weapons.Single;
   import ninjakiwi.monkeyTown.btdModule.weapons.SingleSpread;
   import ninjakiwi.monkeyTown.btdModule.weapons.SingleSpreadFlame;
   import ninjakiwi.monkeyTown.btdModule.weapons.SpikeSpread;
   import ninjakiwi.monkeyTown.btdModule.weapons.Spread;
   import ninjakiwi.monkeyTown.btdModule.weapons.SuckBloon;
   import ninjakiwi.monkeyTown.btdModule.weapons.Surround;
   import ninjakiwi.monkeyTown.btdModule.weapons.Weapon;
   
   public class TowerFactory
   {
      
      public static const TOWER_DART:String = "DartMonkey";
      
      public static const TOWER_TACK:String = "TackTower";
      
      public static const TOWER_SNIPER:String = "SniperMonkey";
      
      public static const TOWER_BOOMERANG:String = "BoomerangThrower";
      
      public static const TOWER_NINJA:String = "NinjaMonkey";
      
      public static const TOWER_BOMB:String = "BombTower";
      
      public static const TOWER_ICE:String = "IceTower";
      
      public static const TOWER_GLUE:String = "GlueGunner";
      
      public static const TOWER_BUCCANEER:String = "MonkeyBuccaneer";
      
      public static const TOWER_PLANE:String = "MonkeyAce";
      
      public static const TOWER_SUPER:String = "SuperMonkey";
      
      public static const TOWER_APPRENTICE:String = "MonkeyApprentice";
      
      public static const TOWER_VILLAGE:String = "MonkeyVillage";
      
      public static const TOWER_FARM:String = "BananaFarm";
      
      public static const TOWER_MORTAR:String = "MortarTower";
      
      public static const TOWER_DARTLING:String = "DartlingGun";
      
      public static const TOWER_SPIKEFACTORY:String = "SpikeFactory";
      
      public static const TOWER_ROADSPIKE:String = "RoadSpikes";
      
      public static const TOWER_PINEAPPLE:String = "ExplodingPineapple";
      
      public static const TOWER_WHIRPOOL:String = "Whirpool";
      
      public static const TOWER_ENGINEER:String = "Engineer";
      
      public static const TOWER_DART_PULT:String = "Spike-o-pult";
      
      public static const TOWER_DART_JUGGERNAUT:String = "Juggernaut";
      
      public static const TOWER_DART_TRIPLE:String = "TripleDarts";
      
      public static const TOWER_DART_FANCLUB:String = "SuperMonkeyFanClub";
      
      public static const TOWER_TACK_SPRAYER:String = "TackSprayer";
      
      public static const TOWER_TACK_FIRE:String = "RingOfFire";
      
      public static const TOWER_TACK_BLADE:String = "BladeShooter";
      
      public static const TOWER_TACK_MAELSTROM:String = "BladeMaelstrom";
      
      public static const TOWER_SNIPER_PRECISION:String = "DeadlyPrecision";
      
      public static const TOWER_SNIPER_CRIPPLE:String = "CrippleMOAB";
      
      public static const TOWER_SNIPER_AUTOMATIC:String = "SemiAutomaticRifle";
      
      public static const TOWER_SNIPER_SUPPLYDROP:String = "SupplyDropSniper";
      
      public static const TOWER_BOOMERANG_BOMBER:String = "BionicBoomer";
      
      public static const TOWER_BOOMERANG_TURBO:String = "TurboCharge";
      
      public static const TOWER_BOOMERANG_GLAIVE:String = "GlaiveRiccochet";
      
      public static const TOWER_BOOMERANG_GLAIVELORD:String = "GlaiveLord";
      
      public static const TOWER_NINJA_DOUBLE:String = "DoubleShot";
      
      public static const TOWER_NINJA_JITSU:String = "Bloonjitsu";
      
      public static const TOWER_NINJA_FLASHBOMB:String = "FlashBomb";
      
      public static const TOWER_NINJA_SABOTAGE:String = "SabotageSupplyLines";
      
      public static const TOWER_BOMB_CLUSTER:String = "ClusterBombTower";
      
      public static const TOWER_BOMB_IMPACT:String = "BloonImpactBombTower";
      
      public static const TOWER_BOMB_MOABMAULER:String = "MoabMauler";
      
      public static const TOWER_BOMB_MOABASSASSIN:String = "MoabAssassin";
      
      public static const TOWER_ICE_SHARDS:String = "IceShards";
      
      public static const TOWER_ICE_VIRAL:String = "ViralFrost";
      
      public static const TOWER_ICE_WIND:String = "ArcticWind";
      
      public static const TOWER_ICE_ZERO:String = "AbsoluteZero";
      
      public static const TOWER_GLUE_HOSE:String = "GlueHose";
      
      public static const TOWER_GLUE_STRIKER:String = "GlueStriker";
      
      public static const TOWER_GLUE_DISOLVER:String = "BloonDisolver";
      
      public static const TOWER_GLUE_LIQUEFIER:String = "BloonLiquefier";
      
      public static const TOWER_BUCCANEER_DESTROYER:String = "Destroyer";
      
      public static const TOWER_BUCCANEER_AIRCRAFT:String = "AircraftCarrier";
      
      public static const TOWER_BUCCANEER_CANNON:String = "CannonShip";
      
      public static const TOWER_BUCCANEER_PIRATES:String = "MonkeyPirates";
      
      public static const TOWER_PLANE_NEVERMISS:String = "NevaMissTargeting";
      
      public static const TOWER_PLANE_SPECTRE:String = "Spectre";
      
      public static const TOWER_PLANE_DARTSTORM:String = "OperationDartStorm";
      
      public static const TOWER_PLANE_GROUNDZERO:String = "GroundZero";
      
      public static const TOWER_SUPER_AVATAR:String = "SunAvatar";
      
      public static const TOWER_SUPER_TEMPLE:String = "TempleOfTheMonkeyGod";
      
      public static const TOWER_SUPER_ROBO:String = "RoboMonkey";
      
      public static const TOWER_SUPER_TERROR:String = "TechnologicalTerror";
      
      public static const TOWER_APPRENTICE_WIND:String = "SummonWhirlwind";
      
      public static const TOWER_APPRENTICE_TORNADO:String = "TempestTornado";
      
      public static const TOWER_APPRENTICE_FIRE:String = "DragonsBreath";
      
      public static const TOWER_APPRENTICE_PHOENIX:String = "SummonPhoenix";
      
      public static const TOWER_VILLAGE_BEACON:String = "EnergyBeacon";
      
      public static const TOWER_VILLAGE_TOWN:String = "MonkeyTown";
      
      public static const TOWER_VILLAGE_MIB:String = "MonkeyIntelligenceBureau";
      
      public static const TOWER_VILLAGE_CALLTOARMS:String = "MIBCallToArms";
      
      public static const TOWER_FARM_BANK:String = "MonkeyBank";
      
      public static const TOWER_FARM_BIA:String = "BananaInvestmentsAdvisory";
      
      public static const TOWER_FARM_REPUBLIC:String = "BananaRepublic";
      
      public static const TOWER_FARM_RESEARCH:String = "BananaResearchFacility";
      
      public static const TOWER_MORTAR_FLARE:String = "SignalFlare";
      
      public static const TOWER_MORTAR_ARTILLERY:String = "ArtilleryBattery";
      
      public static const TOWER_MORTAR_BUSTER:String = "BloonBuster";
      
      public static const TOWER_MORTAR_THEBIGONE:String = "TheBigOne";
      
      public static const TOWER_DARTLING_LASER:String = "LaserCannon";
      
      public static const TOWER_DARTLING_RAYOFDOOM:String = "RayOfDoom";
      
      public static const TOWER_DARTLING_ROCKETS:String = "HydraRocketPods";
      
      public static const TOWER_DARTLING_DENIAL:String = "BloonAreaDenialSystem";
      
      public static const TOWER_SPIKEFACTORY_BALL:String = "SpikedBallFactory";
      
      public static const TOWER_SPIKEFACTORY_MINES:String = "SpikedMines";
      
      public static const TOWER_SPIKEFACTORY_MOAB:String = "MoabShrederSpikes";
      
      public static const TOWER_SPIKEFACTORY_STORM:String = "SpikeStorm";
       
      
      public var baseTowers:Vector.<TowerDef>;
      
      public var upgrades:Vector.<UpgradePathDef>;
      
      public var weapons:Dictionary;
      
      public function TowerFactory()
      {
         this.baseTowers = new Vector.<TowerDef>();
         this.upgrades = new Vector.<UpgradePathDef>();
         this.weapons = new Dictionary();
         super();
         var _loc1_:FollowPath = new FollowPath().Path([new CubicBezierDef().A(new Vector2()).B(new Vector2()).C(new Vector2().X(112).Y(55)).D(new Vector2().X(131).Y(-27)),new CubicBezierDef().A(new Vector2().X(131).Y(-27)).B(new Vector2().X(151).Y(-109)).C(new Vector2().X(45).Y(-159)).D(new Vector2().X(-13).Y(-11))]);
         var _loc2_:AreaEffectDef = new AreaEffectDef().CostScale(0.9);
         var _loc3_:AreaEffectDef = new AreaEffectDef().Upgrade(new UpgradeDef().Id("VisibilityScale").Add(new AddDef().RangeOfVisibility(1.15).RangeOfVisibilityAsScale(true)));
         var _loc4_:AreaEffectDef = new AreaEffectDef().Upgrade(new UpgradeDef().Id("ReloadScale").Add(new AddDef().WeaponMod(new WeaponModDef().ReloadTime(1 / 1.15).ReloadTimeAsScale(true))));
         var _loc5_:AreaEffectDef = new AreaEffectDef().Upgrade(new UpgradeDef().Id("PierceAdd").Add(new AddDef().WeaponMod(new WeaponModDef().ProjectileMod(new ProjectileModDef().Pierce(1)))));
         var _loc6_:AreaEffectDef = new AreaEffectDef().Upgrade(new UpgradeDef().Id("CooldownReduce").Add(new AddDef().AbilityMod(new AbilityModDef().Cooldown(0.8).CooldownAsScale(true))));
         var _loc7_:AreaEffectDef = new AreaEffectDef().Upgrade(new UpgradeDef().Id("PopCashScale").Add(new AddDef().WeaponMod(new WeaponModDef().ProjectileMod(new ProjectileModDef().PopCashScale(0.5)))));
         var _loc8_:AreaEffectDef = new AreaEffectDef().Upgrade(new UpgradeDef().Id("PopCamo").Add(new AddDef().RemoveFromTargetMask(Vector.<int>([Bloon.IMMUNITY_NO_DETECTION])).WeaponMod(new WeaponModDef().ProjectileMod(new ProjectileModDef().RemoveFromEffectMask(Vector.<int>([Bloon.IMMUNITY_NO_DETECTION]))))));
         var _loc9_:AreaEffectDef = new AreaEffectDef().Upgrade(new UpgradeDef().Id("PopAll").Add(new AddDef().RemoveFromTargetMask(new <int>[Bloon.IMMUNITY_ICE]).WeaponMod(new WeaponModDef().ProjectileMod(new ProjectileModDef().DamageEffectMod(new DamageEffectModDef().CanBreakIce(true).RemoveFromCantBreak(Bloon.allBloonTypes)).RemoveFromEffectMask(new <int>[Bloon.IMMUNITY_ICE])))));
         var _loc10_:AreaEffectDef = new AreaEffectDef().Upgrade(new UpgradeDef().Id("PierceAdd2").Add(new AddDef().WeaponMod(new WeaponModDef().ProjectileMod(new ProjectileModDef().Pierce(1)))));
         var _loc11_:ProjectileDef = new ProjectileDef().Display(Dart).Pierce(1).DamageEffect(new DamageEffectDef().Damage(1).CantBreak(Vector.<int>([Bloon.LEAD,Bloon.DDT,Bloon.BOSS_DREADBLOON])).CanBreakIce(false));
         var _loc12_:ProjectileDef = new ProjectileDef().Display(Nail).Pierce(2).DamageEffect(new DamageEffectDef().Damage(1).CantBreak(Vector.<int>([Bloon.LEAD,Bloon.BOSS_DREADBLOON])).CanBreakIce(false));
         var _loc13_:ProjectileDef = new ProjectileDef().Display(Nail).Pierce(3).DamageEffect(new DamageEffectDef().Damage(1).CantBreak(Vector.<int>([Bloon.LEAD,Bloon.DDT,Bloon.BOSS_DREADBLOON])).CanBreakIce(false));
         var _loc14_:ProjectileDef = new ProjectileDef().Display(Nail).Pierce(8).DamageEffect(new DamageEffectDef().Damage(1).CantBreak(Vector.<int>([Bloon.LEAD,Bloon.DDT,Bloon.BOSS_DREADBLOON])).CanBreakIce(true));
         var _loc15_:ProjectileDef = new ProjectileDef().Display(Bubbles1).Pierce(999999).Radius(30).RemoveCamo(true).RemoveRegen(true).EffectMask(Vector.<int>([Bloon.IMMUNITY_NONE])).DamageEffect(new DamageEffectDef().Damage(1).CantBreak(Vector.<int>([Bloon.RED,Bloon.BLUE,Bloon.GREEN,Bloon.YELLOW,Bloon.PINK,Bloon.BLACK,Bloon.WHITE,Bloon.ZEBRA,Bloon.RAINBOW,Bloon.CERAMIC,Bloon.MOAB,Bloon.BFB,Bloon.BOSS,Bloon.DDT,Bloon.BOSS_DREADBLOON])).CanBreakIce(false)).Behavior(new ninjakiwi.monkeyTown.btdModule.projectiles.behavior.BehaviorDef().RoundOver(new RoundOverDestroy()).Process(new CleansingFoamProcess()).Destroy(new RemoveSpikeSpread())).ZOffset(-3);
         var _loc16_:ProjectileDef = new ProjectileDef().Display(Dart).Pierce(1).Radius(5).EffectMask(Vector.<int>([Bloon.IMMUNITY_NONE])).DamageEffect(new DamageEffectDef().Damage(1).CantBreak(Vector.<int>([Bloon.LEAD,Bloon.DDT,Bloon.BOSS_DREADBLOON])).CanBreakIce(false));
         var _loc17_:ProjectileDef = new ProjectileDef().Display(Acorn).Pierce(1).DamageEffect(new DamageEffectDef().Damage(1).CantBreak(Vector.<int>([Bloon.LEAD,Bloon.DDT,Bloon.BOSS_DREADBLOON])).CanBreakIce(false));
         var _loc18_:ProjectileDef = new ProjectileDef().Display(Shuriken).Pierce(2).Radius(4).EffectMask(Vector.<int>([Bloon.IMMUNITY_NONE])).DamageEffect(new DamageEffectDef().Damage(1).CantBreak(Vector.<int>([Bloon.LEAD,Bloon.DDT,Bloon.BOSS_DREADBLOON])).CanBreakIce(false));
         var _loc19_:ProjectileDef = new ProjectileDef().Display(Shuriken).Pierce(2).Radius(4).EffectMask(Vector.<int>([Bloon.IMMUNITY_NONE])).DamageEffect(new DamageEffectDef().Damage(1).CantBreak(Vector.<int>([Bloon.LEAD,Bloon.DDT,Bloon.BOSS_DREADBLOON])).CanBreakIce(false)).Behavior(new ninjakiwi.monkeyTown.btdModule.projectiles.behavior.BehaviorDef().Process(new Target().SeekAngle(Math.PI / 2 * 0.8).TurnTime(0.1).SeekTarget(true))).WindEffect(new WindEffectDef().Chance(0.1));
         var _loc20_:ProjectileDef = new ProjectileDef().Display(Shuriken).Pierce(4).Radius(4).EffectMask(Vector.<int>([Bloon.IMMUNITY_NONE])).DamageEffect(new DamageEffectDef().Damage(1).CantBreak(Vector.<int>([Bloon.LEAD,Bloon.DDT,Bloon.BOSS_DREADBLOON])).CanBreakIce(false));
         var _loc21_:ProjectileDef = new ProjectileDef().Display(Dart).Pierce(4).DamageEffect(new DamageEffectDef().Damage(1).CantBreak(Vector.<int>([Bloon.LEAD,Bloon.DDT,Bloon.BOSS_DREADBLOON])).CanBreakIce(false));
         var _loc22_:ProjectileDef = new ProjectileDef().Display(SunBeam).Pierce(15).Radius(15).AdditiveBlend(true).DamageEffect(new DamageEffectDef().Damage(1).CanBreakIce(true));
         var _loc23_:ProjectileDef = new ProjectileDef().Display(RoboDart).Pierce(3).Radius(5).DamageEffect(new DamageEffectDef().Damage(1).CanBreakIce(true));
         var _loc24_:ProjectileDef = new ProjectileDef().Display(TerrorShot).Pierce(5).Radius(8).AdditiveBlend(true).DamageEffect(new DamageEffectDef().Damage(1).CanBreakIce(true));
         var _loc25_:ProjectileDef = new ProjectileDef().Display(TerrorBlast).Pierce(9999).Radius(200).DamageEffect(new DamageEffectDef().Damage(1000).CanBreakIce(true).Kill(true));
         var _loc26_:ProjectileDef = new ProjectileDef().Display(assets.projectile.LaserCannon).Pierce(13).DamageEffect(new DamageEffectDef().Damage(1).CantBreak(Vector.<int>([Bloon.LEAD,Bloon.DDT,Bloon.BOSS_DREADBLOON])).CanBreakIce(true));
         var _loc27_:ProjectileDef = new ProjectileDef().Display(assets.projectile.LaserCannon).Pierce(13).Radius(6).EffectMask(Vector.<int>([Bloon.IMMUNITY_NONE])).DamageEffect(new DamageEffectDef().Damage(1).CantBreak(Vector.<int>([Bloon.LEAD,Bloon.DDT,Bloon.BOSS_DREADBLOON])).CanBreakIce(true));
         var _loc28_:ProjectileDef = new ProjectileDef().Display(assets.projectile.LaserCannon).Pierce(13).Radius(6).EffectMask(Vector.<int>([Bloon.IMMUNITY_NONE])).DamageEffect(new DamageEffectDef().Damage(1).CanBreakIce(true));
         var _loc29_:ProjectileDef = new ProjectileDef().Display(Dart).Pierce(15).DamageEffect(new DamageEffectDef().Damage(1).CantBreak(Vector.<int>([Bloon.LEAD,Bloon.DDT,Bloon.BOSS_DREADBLOON])).CanBreakIce(false));
         var _loc30_:ProjectileDef = new ProjectileDef().Display(Dart).Pierce(50).DamageEffect(new DamageEffectDef().Damage(1).CantBreak(Vector.<int>([Bloon.LEAD,Bloon.DDT,Bloon.BOSS_DREADBLOON])).CanBreakIce(false));
         var _loc31_:ProjectileDef = new ProjectileDef().Display(Dart).Pierce(15).EffectMask(Vector.<int>([Bloon.IMMUNITY_NONE])).DamageEffect(new DamageEffectDef().Damage(1).CantBreak(Vector.<int>([Bloon.LEAD,Bloon.DDT,Bloon.BOSS_DREADBLOON])).CanBreakIce(false));
         var _loc32_:ProjectileDef = new ProjectileDef().Display(Dart).Pierce(8).Behavior(new ninjakiwi.monkeyTown.btdModule.projectiles.behavior.BehaviorDef().Process(new Target())).DamageEffect(new DamageEffectDef().Damage(1).CantBreak(Vector.<int>([Bloon.LEAD,Bloon.DDT,Bloon.BOSS_DREADBLOON])).CanBreakIce(false));
         var _loc33_:ProjectileDef = new ProjectileDef().Display(assets.projectile.SpikeBall).Pierce(18).Radius(5).EffectMask(Vector.<int>([Bloon.IMMUNITY_NONE])).DamageEffect(new DamageEffectDef().Damage(1).CantBreak(Vector.<int>([Bloon.LEAD,Bloon.DDT,Bloon.BOSS_DREADBLOON])).CanBreakIce(false));
         var _loc34_:ProjectileDef = new ProjectileDef().Display(LargeSpikeBall).Pierce(100).Radius(23).EffectMask(Vector.<int>([Bloon.IMMUNITY_NONE])).DamageEffect(new DamageEffectDef().Damage(1).CeramicScale(5).CanBreakIce(true));
         var _loc35_:ProjectileDef = new ProjectileDef().Display(Boomerang).Pierce(3).Radius(10).DamageEffect(new DamageEffectDef().Damage(1).CantBreak(Vector.<int>([Bloon.LEAD,Bloon.DDT,Bloon.BOSS_DREADBLOON])).CanBreakIce(false)).Behavior(new ninjakiwi.monkeyTown.btdModule.projectiles.behavior.BehaviorDef().Process(_loc1_).LifespanOver(new LifeSpanOverBoomerangSpecialty()));
         var _loc36_:ProjectileDef = new ProjectileDef().Display(HotRang).Pierce(3).Radius(10).DamageEffect(new DamageEffectDef().Damage(1).CanBreakIce(true)).Behavior(new ninjakiwi.monkeyTown.btdModule.projectiles.behavior.BehaviorDef().Process(_loc1_).LifespanOver(new LifeSpanOverBoomerangSpecialty()));
         var _loc37_:ProjectileDef = new ProjectileDef().Display(Glaive).Pierce(40).Radius(10).DamageEffect(new DamageEffectDef().Damage(1).CantBreak(Vector.<int>([Bloon.LEAD,Bloon.DDT,Bloon.BOSS_DREADBLOON])).CanBreakIce(false)).Behavior(new ninjakiwi.monkeyTown.btdModule.projectiles.behavior.BehaviorDef().Process(new GoToNextTarget()));
         var _loc38_:ProjectileDef = new ProjectileDef().Display(Glaive).Pierce(9999).Radius(10).EffectMask(Vector.<int>([Bloon.IMMUNITY_NONE])).DamageEffect(new DamageEffectDef().Damage(1).CantBreak(Vector.<int>([Bloon.LEAD,Bloon.DDT,Bloon.BOSS_DREADBLOON])).CanBreakIce(false)).Behavior(new ninjakiwi.monkeyTown.btdModule.projectiles.behavior.BehaviorDef().Process(new GoToNextTarget()));
         var _loc39_:ProjectileDef = new ProjectileDef().Display(Glaive).Pierce(1).Radius(10).DamageEffect(new DamageEffectDef().Damage(1).CantBreak(Vector.<int>([Bloon.LEAD,Bloon.DDT,Bloon.BOSS_DREADBLOON])).CanBreakIce(false)).Behavior(new ninjakiwi.monkeyTown.btdModule.projectiles.behavior.BehaviorDef().Process(_loc1_).Collision(new CollisionSpawnProjectile().Projectile(_loc37_)).LifespanOver(new LifeSpanOverBoomerangSpecialty()));
         var _loc40_:ProjectileDef = new ProjectileDef().Display(Glaive).Pierce(1).Radius(10).EffectMask(Vector.<int>([Bloon.IMMUNITY_NONE])).DamageEffect(new DamageEffectDef().Damage(1).CantBreak(Vector.<int>([Bloon.LEAD,Bloon.DDT,Bloon.BOSS_DREADBLOON])).CanBreakIce(false)).Behavior(new ninjakiwi.monkeyTown.btdModule.projectiles.behavior.BehaviorDef().Process(_loc1_).Collision(new CollisionSpawnProjectile().Projectile(_loc38_)).LifespanOver(new LifeSpanOverBoomerangSpecialty()));
         var _loc41_:ProjectileDef = new ProjectileDef().Display(Tack).Pierce(1).DamageEffect(new DamageEffectDef().Damage(1).CantBreak(Vector.<int>([Bloon.LEAD,Bloon.DDT,Bloon.BOSS_DREADBLOON])).CanBreakIce(false));
         var _loc42_:ProjectileDef = new ProjectileDef().Display(FragShard).Pierce(1).DamageEffect(new DamageEffectDef().Damage(1).CantBreak(Vector.<int>([Bloon.LEAD,Bloon.DDT,Bloon.BOSS_DREADBLOON])).CanBreakIce(false));
         var _loc43_:ProjectileDef = new ProjectileDef().Display(assets.projectile.BladeMaelstrom).Pierce(2).Radius(5).DamageEffect(new DamageEffectDef().Damage(1).CantBreak(Vector.<int>([Bloon.LEAD,Bloon.DDT,Bloon.BOSS_DREADBLOON])).CanBreakIce(false));
         var _loc44_:ProjectileDef = new ProjectileDef().Display(assets.projectile.RingOfFire).Pierce(60).Radius(80).DamageEffect(new DamageEffectDef().Damage(1).CanBreakIce(true));
         var _loc45_:ProjectileDef = new ProjectileDef().Display(GlueShot).Pierce(1).Radius(15).EffectMask(Vector.<int>([Bloon.IMMUNITY_NO_DETECTION,Bloon.IMMUNITY_GLUE])).GlueEffect(new GlueEffectDef().Lifespan(11.43).SpeedScale(0.5));
         var _loc46_:ProjectileDef = new ProjectileDef().Display(GlueSplat).Pierce(5).Radius(60).EffectMask(Vector.<int>([Bloon.IMMUNITY_NO_DETECTION,Bloon.IMMUNITY_GLUE])).GlueEffect(new GlueEffectDef().Lifespan(11.43).SpeedScale(0.5));
         var _loc47_:ProjectileDef = new ProjectileDef().Display(GlueSplat).Pierce(11).Radius(60).EffectMask(Vector.<int>([Bloon.IMMUNITY_NO_DETECTION,Bloon.IMMUNITY_GLUE])).GlueEffect(new GlueEffectDef().Lifespan(22.86).SpeedScale(0.4));
         var _loc48_:ProjectileDef = new ProjectileDef().Display(BlobYellow).Pierce(1).EffectMask(Vector.<int>([Bloon.IMMUNITY_NO_DETECTION])).GlueEffect(new GlueEffectDef().Lifespan(22.86).SpeedScale(0.4)).Behavior(new ninjakiwi.monkeyTown.btdModule.projectiles.behavior.BehaviorDef().Collision(new CollisionSpawnProjectile().Projectile(_loc47_)));
         var _loc49_:ProjectileDef = new ProjectileDef().Display(GlueShot).Pierce(99999).Radius(99999).EffectMask(Vector.<int>([Bloon.IMMUNITY_NO_DETECTION,Bloon.IMMUNITY_GLUE])).GlueEffect(new GlueEffectDef().Lifespan(22.86).SpeedScale(0.3));
         var _loc50_:ProjectileDef = new ProjectileDef().Display(DissloverShot).Pierce(1).EffectMask(Vector.<int>([Bloon.IMMUNITY_NO_DETECTION,Bloon.IMMUNITY_GLUE])).GlueEffect(new GlueEffectDef().Lifespan(11.43).SpeedScale(0.5).Soak(true).CorosionInterval(0.5));
         var _loc51_:ProjectileDef = new ProjectileDef().Display(DissloverShot).Pierce(1).EffectMask(Vector.<int>([Bloon.IMMUNITY_NO_DETECTION,Bloon.IMMUNITY_GLUE])).DamageEffect(new DamageEffectDef().Damage(1).CanBreakIce(true)).GlueEffect(new GlueEffectDef().Lifespan(11.43).SpeedScale(0.5).Soak(true).CorosionInterval(0.1));
         var _loc52_:ProjectileDef = new ProjectileDef().Display(IceBurst).Pierce(50).Radius(60).EffectMask(Vector.<int>([Bloon.IMMUNITY_NO_DETECTION,Bloon.IMMUNITY_ICE])).IceEffect(new IceEffectDef().Lifespan(1.43));
         var _loc53_:ProjectileDef = new ProjectileDef().Display(IceBurstLarge).Pierce(50).Radius(105).EffectMask(Vector.<int>([Bloon.IMMUNITY_NO_DETECTION,Bloon.IMMUNITY_ICE])).IceEffect(new IceEffectDef().Lifespan(1.43 + 0.57).FreezeLayers(2)).DamageEffect(new DamageEffectDef().Damage(1).CanBreakIce(true));
         var _loc54_:ProjectileDef = new ProjectileDef().Display(IceBurst).Pierce(99999).Radius(99999).EffectMask(Vector.<int>([Bloon.IMMUNITY_NO_DETECTION,Bloon.IMMUNITY_ICE])).IceEffect(new IceEffectDef().Lifespan(4).Permafrost(0.5).FreezeLayers(2));
         var _loc55_:ProjectileDef = new ProjectileDef().Display(IceBurst).Pierce(50).Radius(60).EffectMask(Vector.<int>([Bloon.IMMUNITY_NO_DETECTION,Bloon.IMMUNITY_ICE])).IceEffect(new IceEffectDef().Lifespan(2).FreezeLayers(2).Shards(true).Permafrost(0.5));
         var _loc56_:ProjectileDef = new ProjectileDef().Display(IceBurstLarge).Pierce(50).Radius(105).EffectMask(Vector.<int>([Bloon.IMMUNITY_NO_DETECTION,Bloon.IMMUNITY_ICE])).IceEffect(new IceEffectDef().Lifespan(2).Viral(true).FreezeLayers(2)).DamageEffect(new DamageEffectDef().Damage(1).CanBreakIce(true));
         var _loc57_:ProjectileDef = new ProjectileDef().Display(MediumExplosion).Pierce(40).Radius(60).DamageEffect(new DamageEffectDef().Damage(1).CanBreakIce(true).CantBreak(Vector.<int>([Bloon.BLACK,Bloon.DDT,Bloon.ZEBRA])).ShowPop(false));
         var _loc58_:ProjectileDef = new ProjectileDef().Display(MediumExplosion).Pierce(40).Radius(60).EffectMask(Vector.<int>([Bloon.IMMUNITY_NONE])).DamageEffect(new DamageEffectDef().Damage(1).CanBreakIce(true).ShowPop(false));
         var _loc59_:ProjectileDef = new ProjectileDef().Display(LargeExplosion).Pierce(40).Radius(75).EffectMask(Vector.<int>([Bloon.IMMUNITY_NONE])).DamageEffect(new DamageEffectDef().Damage(1).CanBreakIce(true).CantBreak(Vector.<int>([Bloon.BLACK,Bloon.DDT,Bloon.ZEBRA])).ShowPop(false));
         var _loc60_:ProjectileDef = new ProjectileDef().Display(LargeExplosion).Pierce(40).Radius(75).DamageEffect(new DamageEffectDef().Damage(1).CanBreakIce(true).CantBreak(Vector.<int>([Bloon.BLACK,Bloon.DDT,Bloon.ZEBRA])).ShowPop(false));
         var _loc61_:ProjectileDef = new ProjectileDef().Display(LargeExplosion).Pierce(40).Radius(60).DamageEffect(new DamageEffectDef().Damage(1).CanBreakIce(true).CantBreak(Vector.<int>([Bloon.BLACK,Bloon.DDT,Bloon.ZEBRA])).ShowPop(false));
         var _loc62_:ProjectileDef = new ProjectileDef().Display(LargeExplosion).Pierce(40).Radius(60).EffectMask(Vector.<int>([Bloon.IMMUNITY_NONE])).DamageEffect(new DamageEffectDef().Damage(1).CanBreakIce(true).CantBreak(Vector.<int>([Bloon.BLACK,Bloon.DDT,Bloon.ZEBRA])).ShowPop(false));
         var _loc63_:ProjectileDef = new ProjectileDef().Display(BurnyLargeExplosion).Pierce(40).Radius(75).EffectMask(Vector.<int>([Bloon.IMMUNITY_NONE])).DamageEffect(new DamageEffectDef().Damage(1).CanBreakIce(true).CantBreak(Vector.<int>([Bloon.BLACK,Bloon.DDT,Bloon.ZEBRA])).ShowPop(false)).BurnEffect(new BurnEffectDef().Lifespan(6).BurnInterval(2)).RemoveCamo(true);
         var _loc64_:ProjectileDef = new ProjectileDef().Display(LargeExplosion).Pierce(40).Radius(75).DamageEffect(new DamageEffectDef().Damage(1).CanBreakIce(true).CantBreak(Vector.<int>([Bloon.BLACK,Bloon.DDT,Bloon.ZEBRA])).ShowPop(false));
         var _loc65_:ProjectileDef = new ProjectileDef().Display(LargeExplosion).Pierce(100).Radius(75).DamageEffect(new DamageEffectDef().Damage(2).CanBreakIce(true).ShowPop(false));
         var _loc66_:ProjectileDef = new ProjectileDef().Display(MediumExplosion).Pierce(40).Radius(60).DamageEffect(new DamageEffectDef().Damage(1).CanBreakIce(true).CantBreak(Vector.<int>([Bloon.BLACK,Bloon.DDT,Bloon.ZEBRA])).ShowPop(false));
         var _loc67_:ProjectileDef = new ProjectileDef().Display(SlightlyLargerExplosion).Pierce(40).Radius(98).DamageEffect(new DamageEffectDef().Damage(2).CanBreakIce(true).CantBreak(Vector.<int>([Bloon.BLACK,Bloon.DDT,Bloon.ZEBRA])).ShowPop(false));
         var _loc68_:ProjectileDef = new ProjectileDef().Display(BurnyMediumExplosion).Pierce(40).Radius(60).EffectMask(Vector.<int>([Bloon.IMMUNITY_NONE])).DamageEffect(new DamageEffectDef().Damage(4).CanBreakIce(true).CantBreak(Vector.<int>([Bloon.BLACK,Bloon.DDT,Bloon.ZEBRA])).ShowPop(false)).BurnEffect(new BurnEffectDef().Lifespan(6).BurnInterval(2));
         var _loc69_:ProjectileDef = new ProjectileDef().Display(NuclearExplosion).Pierce(100).Radius(150).DamageEffect(new DamageEffectDef().Damage(5).CanBreakIce(true).ShowPop(false));
         var _loc70_:ProjectileDef = new ProjectileDef().Display(LargeExplosion).Pierce(50).Radius(75).DamageEffect(new DamageEffectDef().Damage(1).CanBreakIce(true).CantBreak(Vector.<int>([Bloon.BLACK,Bloon.ZEBRA,Bloon.DDT])).MOABScale(10).BossScale(10).ShowPop(false));
         var _loc71_:ProjectileDef = new ProjectileDef().Display(LargeExplosion).Pierce(40).Radius(75).DamageEffect(new DamageEffectDef().Damage(1).CanBreakIce(true).ShowPop(false)).StunEffect(new StunEffectDef().Lifespan(0.5).CantEffect(Vector.<int>([Bloon.MOAB,Bloon.BFB,Bloon.BOSS,Bloon.DDT])));
         var _loc72_:ProjectileDef = new ProjectileDef().Display(LargeExplosion).Pierce(10000).Radius(1000).StunEffect(new StunEffectDef().Lifespan(5)).BurnEffect(new BurnEffectDef().Lifespan(5).BurnInterval(1));
         var _loc73_:ProjectileDef = new ProjectileDef().Display(MediumExplosion).Pierce(40).Radius(60).DamageEffect(new DamageEffectDef().Damage(1).CanBreakIce(true).ShowPop(false)).StunEffect(new StunEffectDef().Lifespan(0.5).CantEffect(Vector.<int>([Bloon.MOAB,Bloon.BFB,Bloon.BOSS,Bloon.DDT])));
         var _loc74_:ProjectileDef = new ProjectileDef().Display(Bomb).Pierce(1).Radius(5).Behavior(new ninjakiwi.monkeyTown.btdModule.projectiles.behavior.BehaviorDef().Collision(new CollisionSpawnProjectile().Projectile(_loc57_)));
         var _loc75_:ProjectileDef = new ProjectileDef().Display(Bomb).Pierce(1).Radius(5).EffectMask(Vector.<int>([Bloon.IMMUNITY_NONE])).Behavior(new ninjakiwi.monkeyTown.btdModule.projectiles.behavior.BehaviorDef().Collision(new CollisionSpawnProjectile().Projectile(_loc59_)));
         var _loc76_:ProjectileDef = new ProjectileDef().Display(SpectreBomb).Pierce(1).Radius(5).Behavior(new ninjakiwi.monkeyTown.btdModule.projectiles.behavior.BehaviorDef().Collision(new CollisionSpawnProjectile().Projectile(_loc65_)));
         var _loc77_:ProjectileDef = new ProjectileDef().Display(BombCluster).Pierce(1).Radius(5).EffectMask(Vector.<int>([Bloon.IMMUNITY_ALL])).Behavior(new ninjakiwi.monkeyTown.btdModule.projectiles.behavior.BehaviorDef().Destroy(new ninjakiwi.monkeyTown.btdModule.projectiles.behavior.destroy.SpawnProjectile().Projectile(_loc66_)));
         var _loc78_:ProjectileDef = new ProjectileDef().Display(MovieClip).Pierce(1).Radius(5).EffectMask(Vector.<int>([Bloon.IMMUNITY_ALL])).Behavior(new ninjakiwi.monkeyTown.btdModule.projectiles.behavior.BehaviorDef().Destroy(new ninjakiwi.monkeyTown.btdModule.projectiles.behavior.destroy.SpawnProjectile().Projectile(_loc60_)));
         var _loc79_:ProjectileDef = new ProjectileDef().Display(MovieClip).Pierce(1).Radius(5).EffectMask(Vector.<int>([Bloon.IMMUNITY_ALL])).Behavior(new ninjakiwi.monkeyTown.btdModule.projectiles.behavior.BehaviorDef().Destroy(new ninjakiwi.monkeyTown.btdModule.projectiles.behavior.destroy.SpawnProjectile().Projectile(_loc63_)));
         var _loc80_:ProjectileDef = new ProjectileDef().Display(MovieClip).Pierce(1).Radius(5).EffectMask(Vector.<int>([Bloon.IMMUNITY_ALL])).Behavior(new ninjakiwi.monkeyTown.btdModule.projectiles.behavior.BehaviorDef().Destroy(new ninjakiwi.monkeyTown.btdModule.projectiles.behavior.destroy.SpawnProjectile().Projectile(_loc67_)));
         var _loc81_:ProjectileDef = new ProjectileDef().Display(MovieClip).Pierce(1).Radius(5).EffectMask(Vector.<int>([Bloon.IMMUNITY_ALL])).Behavior(new ninjakiwi.monkeyTown.btdModule.projectiles.behavior.BehaviorDef().Destroy(new ninjakiwi.monkeyTown.btdModule.projectiles.behavior.destroy.SpawnProjectile().Projectile(_loc69_)));
         var _loc82_:ProjectileDef = new ProjectileDef().Display(HydraMissile).Pierce(1).Radius(8).EffectMask(Vector.<int>([Bloon.IMMUNITY_NONE])).Behavior(new ninjakiwi.monkeyTown.btdModule.projectiles.behavior.BehaviorDef().Collision(new CollisionSpawnProjectile().Projectile(_loc58_)));
         var _loc83_:ProjectileDef = new ProjectileDef().Display(PineappleBomb).Behavior(new ninjakiwi.monkeyTown.btdModule.projectiles.behavior.BehaviorDef().Destroy(new ninjakiwi.monkeyTown.btdModule.projectiles.behavior.destroy.SpawnProjectile().Projectile(_loc61_)));
         var _loc84_:ProjectileDef = new ProjectileDef().Display(PineappleBomb).Behavior(new ninjakiwi.monkeyTown.btdModule.projectiles.behavior.BehaviorDef().Destroy(new ninjakiwi.monkeyTown.btdModule.projectiles.behavior.destroy.SpawnProjectile().Projectile(_loc62_)));
         var _loc85_:ProjectileDef = new ProjectileDef().Display(Dart).Pierce(1).DamageEffect(new DamageEffectDef().Damage(2).CantBreak(Vector.<int>([Bloon.LEAD,Bloon.DDT,Bloon.BOSS_DREADBLOON])));
         var _loc86_:ProjectileDef = new ProjectileDef().Display(Dart).Pierce(1).EffectMask(Vector.<int>([Bloon.IMMUNITY_NONE])).DamageEffect(new DamageEffectDef().Damage(2));
         var _loc87_:ProjectileDef = new ProjectileDef().Display(Dart).Pierce(1).DamageEffect(new DamageEffectDef().Damage(18));
         var _loc88_:ProjectileDef = new ProjectileDef().Display(Dart).Pierce(1).DamageEffect(new DamageEffectDef().Damage(18)).StunEffect(new StunEffectDef().Lifespan(3).Inherit(false).CantEffect(Vector.<int>([Bloon.RED,Bloon.BLUE,Bloon.GREEN,Bloon.YELLOW,Bloon.PINK,Bloon.BLACK,Bloon.WHITE,Bloon.LEAD,Bloon.ZEBRA,Bloon.RAINBOW,Bloon.CERAMIC,Bloon.DDT])));
         var _loc89_:ProjectileDef = new ProjectileDef().Display(assets.projectile.RoadSpikes).Pierce(11).Radius(25).EffectMask(Vector.<int>([Bloon.IMMUNITY_NONE])).Behavior(new ninjakiwi.monkeyTown.btdModule.projectiles.behavior.BehaviorDef().RoundOver(new RoundOverDestroy()).Collision(new RoadSpikeCollision())).CanMultiEffect(true).DamageEffect(new DamageEffectDef().Damage(1).CanBreakIce(false).CantBreak(Vector.<int>([Bloon.LEAD,Bloon.DDT,Bloon.BOSS_DREADBLOON])));
         var _loc90_:ProjectileDef = new ProjectileDef().Display(SpikeFactorySpikes).Pierce(5).Radius(25).EffectMask(Vector.<int>([Bloon.IMMUNITY_NONE])).Behavior(new ninjakiwi.monkeyTown.btdModule.projectiles.behavior.BehaviorDef().RoundOver(new RoundOverDestroy()).Collision(new RoadSpikeCollision()).Process(new Friction()).Destroy(new RemoveSpikeSpread())).CanMultiEffect(true).DamageEffect(new DamageEffectDef().Damage(1).CanBreakIce(false).CantBreak(Vector.<int>([Bloon.LEAD,Bloon.DDT,Bloon.BOSS_DREADBLOON])));
         var _loc91_:ProjectileDef = new ProjectileDef().Display(SpikeFactorySpikes).Pierce(5).Radius(25).EffectMask(Vector.<int>([Bloon.IMMUNITY_NONE])).Behavior(new ninjakiwi.monkeyTown.btdModule.projectiles.behavior.BehaviorDef().RoundOver(new RoundOverDestroy()).Collision(new RoadSpikeCollision()).Process(new Friction()).Destroy(new RemoveSpikeSpread())).CanMultiEffect(true).DamageEffect(new DamageEffectDef().Damage(1).CanBreakIce(false).CantBreak(Vector.<int>([Bloon.LEAD,Bloon.DDT,Bloon.BOSS_DREADBLOON])).MOABScale(4).BossScale(2));
         var _loc92_:ProjectileDef = new ProjectileDef().Display(SpikeFactoryBall).Pierce(16).Radius(25).EffectMask(Vector.<int>([Bloon.IMMUNITY_NONE])).Behavior(new ninjakiwi.monkeyTown.btdModule.projectiles.behavior.BehaviorDef().RoundOver(new RoundOverDestroy()).Collision(new RoadSpikeCollision()).Process(new Friction()).Destroy(new RemoveSpikeSpread())).CanMultiEffect(true).DamageEffect(new DamageEffectDef().Damage(1).CanBreakIce(true).CeramicScale(3));
         var _loc93_:ProjectileDef = new ProjectileDef().Display(SpikeMineBall).Pierce(16).Radius(25).EffectMask(Vector.<int>([Bloon.IMMUNITY_NONE])).Behavior(new ninjakiwi.monkeyTown.btdModule.projectiles.behavior.BehaviorDef().RoundOver(new RoundOverDestroy()).Collision(new RoadSpikeCollision()).Process(new Friction()).Destroy(new ninjakiwi.monkeyTown.btdModule.projectiles.behavior.destroy.SpawnProjectile().Projectile(_loc68_).Next(new RemoveSpikeSpread()))).CanMultiEffect(true).DamageEffect(new DamageEffectDef().Damage(1).CanBreakIce(true).CeramicScale(3));
         var _loc94_:ProjectileDef = new ProjectileDef().Display(MOAB).Pierce(1).Radius(15).Behavior(new ninjakiwi.monkeyTown.btdModule.projectiles.behavior.BehaviorDef().Collision(new CollisionSpawnProjectile().Projectile(_loc70_)));
         var _loc95_:ProjectileDef = new ProjectileDef().Display(assets.projectile.MOABAssassin).Pierce(1).Radius(15).Behavior(new ninjakiwi.monkeyTown.btdModule.projectiles.behavior.BehaviorDef().Collision(new CollisionSpawnProjectile().Projectile(_loc70_)));
         var _loc96_:ProjectileDef = new ProjectileDef().Display(BombCluster).Pierce(1).Radius(5).EffectMask(Vector.<int>([Bloon.IMMUNITY_ALL])).Behavior(new ninjakiwi.monkeyTown.btdModule.projectiles.behavior.BehaviorDef().Destroy(new ninjakiwi.monkeyTown.btdModule.projectiles.behavior.destroy.SpawnProjectile().Projectile(_loc73_)));
         var _loc97_:ProjectileDef = new ProjectileDef().Display(Bomb).Pierce(1).Radius(5).Behavior(new ninjakiwi.monkeyTown.btdModule.projectiles.behavior.BehaviorDef().Collision(new CollisionSpawnProjectile().Projectile(_loc57_).Next(new SpawnSpreadCollision().Projectile(_loc77_))));
         var _loc98_:ProjectileDef = new ProjectileDef().Display(Bomb).Pierce(1).Radius(5).Behavior(new ninjakiwi.monkeyTown.btdModule.projectiles.behavior.BehaviorDef().Collision(new CollisionSpawnProjectile().Projectile(_loc71_).Next(new SpawnSpreadCollision().Projectile(_loc96_))));
         var _loc99_:ProjectileDef = new ProjectileDef().Display(MagicBolt).Pierce(2).Radius(5).DamageEffect(new DamageEffectDef().Damage(1).CanBreakIce(true));
         var _loc100_:ProjectileDef = new ProjectileDef().Display(assets.projectile.IntenseMagic).Pierce(7).Radius(10).DamageEffect(new DamageEffectDef().Damage(1).CanBreakIce(true));
         var _loc101_:ProjectileDef = new ProjectileDef().Display(assets.projectile.IntenseMagic).Pierce(7).Radius(10).EffectMask(Vector.<int>([Bloon.IMMUNITY_NONE])).DamageEffect(new DamageEffectDef().Damage(1).CanBreakIce(true));
         var _loc102_:ProjectileDef = new ProjectileDef().Pierce(99999).Radius(10).Display(FireDissRed);
         var _loc103_:ProjectileDef = new ProjectileDef().Display(ApprenticeDisspate).Pierce(1).Radius(5).EffectMask(Vector.<int>([Bloon.IMMUNITY_ALL])).AdditiveBlend(true);
         var _loc104_:ProjectileDef = new ProjectileDef().Display(ApprenticeBreath).Pierce(4).Radius(10).AdditiveBlend(true).EffectMask(Vector.<int>([Bloon.IMMUNITY_NONE])).DamageEffect(new DamageEffectDef().Damage(1).CanBreakIce(true)).Behavior(new ninjakiwi.monkeyTown.btdModule.projectiles.behavior.BehaviorDef().Destroy(new ninjakiwi.monkeyTown.btdModule.projectiles.behavior.destroy.SpawnProjectile().Projectile(_loc103_).Lifespan(10 / 30)));
         var _loc105_:ProjectileDef = new ProjectileDef().Display(Dart).Pierce(30).DamageEffect(new DamageEffectDef().Damage(1).CanBreakIce(true));
         var _loc106_:ProjectileDef = new ProjectileDef().Display(Dart).Pierce(30).EffectMask(Vector.<int>([Bloon.IMMUNITY_NONE])).DamageEffect(new DamageEffectDef().Damage(1).CanBreakIce(true));
         var _loc107_:ProjectileDef = new ProjectileDef().Display(TinyTornado).Pierce(20).Radius(16).WindEffect(new WindEffectDef().Speed(300));
         var _loc108_:ProjectileDef = new ProjectileDef().Display(Tornado).Pierce(20).Radius(30).WindEffect(new WindEffectDef().Speed(300));
         var _loc109_:ProjectileDef = new ProjectileDef().Display(assets.projectile.Tempest).Pierce(70).Radius(40).WindEffect(new WindEffectDef().Speed(300)).DamageEffect(new DamageEffectDef().Damage(1).CanBreakIce(true));
         var _loc110_:ProjectileDef = new ProjectileDef().Display(assets.projectile.Tempest).Pierce(70).Radius(40).WindEffect(new WindEffectDef().Speed(300)).EffectMask(Vector.<int>([Bloon.IMMUNITY_NONE])).DamageEffect(new DamageEffectDef().Damage(1).CanBreakIce(true));
         var _loc111_:ProjectileDef = new ProjectileDef().Display(LargeExplosion).Pierce(30).Radius(65).DamageEffect(new DamageEffectDef().Damage(1).CanBreakIce(true).ShowPop(false));
         var _loc112_:ProjectileDef = new ProjectileDef().Display(assets.projectile.Fireball).Pierce(1).Radius(8).Behavior(new ninjakiwi.monkeyTown.btdModule.projectiles.behavior.BehaviorDef().Collision(new CollisionSpawnProjectile().Projectile(_loc57_)));
         var _loc113_:ProjectileDef = new ProjectileDef().Display(assets.projectile.Fireball).Pierce(1).Radius(8).EffectMask(Vector.<int>([Bloon.IMMUNITY_NONE])).Behavior(new ninjakiwi.monkeyTown.btdModule.projectiles.behavior.BehaviorDef().Collision(new CollisionSpawnProjectile().Projectile(_loc57_)));
         var _loc114_:ProjectileDef = new ProjectileDef().Display(LargeExplosion).Pierce(60).Radius(120).EffectMask(Vector.<int>([Bloon.IMMUNITY_NONE])).DamageEffect(new DamageEffectDef().Damage(1).CanBreakIce(true).ShowPop(false)).StunEffect(new StunEffectDef().Lifespan(1).Inherit(false).CantEffect(Vector.<int>([Bloon.MOAB,Bloon.BFB,Bloon.BOSS,Bloon.DDT])));
         var _loc115_:ProjectileDef = new ProjectileDef().Display(assets.projectile.FlashBomb).Pierce(1).Radius(5).EffectMask(Vector.<int>([Bloon.IMMUNITY_NONE])).Behavior(new ninjakiwi.monkeyTown.btdModule.projectiles.behavior.BehaviorDef().Collision(new CollisionSpawnProjectile().Projectile(_loc114_)));
         var _loc116_:ProjectileDef = new ProjectileDef().Display(BuccaneerDart).Pierce(5).Radius(8).DamageEffect(new DamageEffectDef().Damage(1).CantBreak(Vector.<int>([Bloon.LEAD,Bloon.DDT,Bloon.BOSS_DREADBLOON])).CanBreakIce(false));
         var _loc117_:ProjectileDef = new ProjectileDef().Display(BuccaneerDart).Pierce(5).EffectMask(Vector.<int>([Bloon.IMMUNITY_NONE])).DamageEffect(new DamageEffectDef().Damage(1).CantBreak(Vector.<int>([Bloon.LEAD,Bloon.DDT,Bloon.BOSS_DREADBLOON])).CanBreakIce(false));
         var _loc118_:ProjectileDef = new ProjectileDef().Display(assets.projectile.GrapeShot).Pierce(2).DamageEffect(new DamageEffectDef().Damage(1).CantBreak(Vector.<int>([Bloon.LEAD,Bloon.DDT,Bloon.BOSS_DREADBLOON])).CanBreakIce(false));
         var _loc119_:ProjectileDef = new ProjectileDef().Display(assets.projectile.GrapeShot).Pierce(2).EffectMask(Vector.<int>([Bloon.IMMUNITY_NONE])).DamageEffect(new DamageEffectDef().Damage(1).CantBreak(Vector.<int>([Bloon.LEAD,Bloon.DDT,Bloon.BOSS_DREADBLOON])).CanBreakIce(false));
         var _loc120_:Single = new Single().Range(161).Power(805).ReloadTime(0.9).Projectile(_loc11_).IsBaseWeapon(true);
         var _loc121_:Single = new Single("NailGun").Range(600).Power(1050).ReloadTime(0.645).Projectile(_loc13_).Rotate(true).IsBaseWeapon(true);
         var _loc122_:Single = new Single("NailGunSprockets").Range(600).Power(1050).ReloadTime(0.516).Projectile(_loc14_).Rotate(true).IsBaseWeapon(true);
         var _loc123_:Single = new Single("SentryWeapon").Range(161).Power(805).ReloadTime(0.8).Projectile(_loc12_).Rotate(true);
         var _loc124_:Single = new Single("SentryWeaponSprocket").Range(161).Power(805).ReloadTime(0.53).Projectile(_loc12_).Rotate(true).IsBaseWeapon(true);
         var _loc125_:CreateSentry = new CreateSentry("SentryCreate").ReloadTime(10).Sentry("Sentry").RequiresTarget(false);
         var _loc126_:CreateSentry = new CreateSentry().ReloadTime(6).Sentry("Sentry").RequiresTarget(false);
         var _loc127_:SuckBloon = new SuckBloon().Range(600).Power(1050).ReloadTime(0.29).Rotate(true).IsBaseWeapon(true);
         var _loc128_:SuckBloon = new SuckBloon().Range(600).Power(1050).ReloadTime(0.29 * 0.75).Rotate(true).IsBaseWeapon(true);
         var _loc129_:SuckBloon = new SuckBloon().Range(600).Power(1050).ReloadTime(0.29 / 3).Rotate(true).IsBaseWeapon(true);
         var _loc130_:SpikeSpread = new SpikeSpread().Power(115).ReloadTime(2.5).Projectile(_loc15_).Rotate(false).RequiresTarget(false);
         var _loc131_:CastRay = new CastRay().Range(180).Power(900).ReloadTime(0.058).Projectile(_loc11_).Rotate(false);
         var _loc132_:Single = new Single().Range(500).Power(700).ReloadTime(0.058).Projectile(_loc11_).IsBaseWeapon(true);
         var _loc133_:Spread = new Spread().Range(500).Power(875).ReloadTime(0.058).Projectile(_loc22_).Rotate(true).Count(3).Angle(0.4).IsBaseWeapon(true);
         var _loc134_:Single = new Single().Range(500).Power(875).ReloadTime(0.058).Projectile(_loc22_).Rotate(false).IsBaseWeapon(true);
         var _loc135_:Single = new Single().Range(500).Power(700).ReloadTime(0.058).Projectile(_loc23_).Rotate(false).IsBaseWeapon(true);
         var _loc136_:Single = new Single().Range(500).Power(700).ReloadTime(0.04).Projectile(_loc24_).Rotate(false).IsBaseWeapon(true);
         var _loc137_:Independent = new Independent().Range(500).ReloadTime(0.04).Offsets(Vector.<Vector2>([new Vector2(0,-16),new Vector2(0,16)])).ChildWeapons(Vector.<Weapon>([_loc135_,_loc135_]));
         var _loc138_:Independent = new Independent().Range(500).ReloadTime(0.032).Offsets(Vector.<Vector2>([new Vector2(10,-32),new Vector2(10,32)])).ChildWeapons(Vector.<Weapon>([_loc136_,_loc136_])).IsBaseWeapon(true);
         var _loc139_:FireAtMouse = new FireAtMouse().Range(1050).Power(875).ReloadTime(0.2).Projectile(_loc16_).Spread(0.4).IsBaseWeapon(true);
         var _loc140_:FireAtMouse = new FireAtMouse().Range(1250).Power(875).ReloadTime(0.086).Projectile(_loc27_).Spread(0.15).IsBaseWeapon(true);
         var _loc141_:FireAtMouse = new FireAtMouse().Range(1250).Power(1225).ReloadTime(0.2).Projectile(_loc82_).Spread(0.4).IsBaseWeapon(true);
         var _loc142_:FireAtMouseSpread = new FireAtMouseSpread().Range(1250).Power(1225).ReloadTime(0.2).Projectile(_loc82_).Spread(0.4);
         var _loc143_:FireAtReticle = new FireAtReticle("mortarWeapon").Range(1250).Power(600).ReloadTime(2.1).Projectile(_loc78_).Spread(60).IsBaseWeapon(true);
         var _loc144_:FireAtReticle = new FireAtReticle("signalFlareWeapon").Range(1250).Power(600).ReloadTime(1.61).Projectile(_loc79_).Spread(60).IsBaseWeapon(true);
         var _loc145_:FireAtReticle = new FireAtReticle("artilleryBatteryWeapon").Range(1250).Power(600).ReloadTime(0.52).Projectile(_loc79_).Spread(60).IsBaseWeapon(true);
         var _loc146_:FireAtReticle = new FireAtReticle("bloonBusterWeapon").Range(1250).Power(600).ReloadTime(2.1).Projectile(_loc80_).Spread(20).IsBaseWeapon(true);
         var _loc147_:FireAtReticle = new FireAtReticle("theBigOneWeapon").Range(1250).Power(600).ReloadTime(1.8).Projectile(_loc81_).Spread(20).IsBaseWeapon(true);
         var _loc148_:Instant = new Instant("sniperWeapon").ReloadTime(2.2).Projectile(_loc85_).IsBaseWeapon(true);
         this.weapons[_loc148_.id] = _loc148_;
         var _loc149_:Instant = new Instant("sniperAutomaticWeapon").ReloadTime(0.5).Projectile(_loc86_).IsBaseWeapon(true);
         this.weapons[_loc149_.id] = _loc149_;
         var _loc150_:Instant = new Instant("sniperDeadlyWeapon").ReloadTime(2.2).Projectile(_loc87_).IsBaseWeapon(true);
         this.weapons[_loc150_.id] = _loc150_;
         var _loc151_:Instant = new Instant("sniperCrippleWeapon").ReloadTime(2.2).Projectile(_loc88_).IsBaseWeapon(true);
         this.weapons[_loc151_.id] = _loc151_;
         var _loc152_:Single = new Single().Range(360).Power(630).ReloadTime(0.6).Projectile(_loc18_).IsBaseWeapon(true).IsBaseWeapon(true);
         var _loc153_:Spread = new Spread().Range(360).Power(630).ReloadTime(0.475).Projectile(_loc20_).Count(2).Angle(0.2).Offset(0.2).IsBaseWeapon(true);
         var _loc154_:Spread = new Spread().Range(360).Power(630).ReloadTime(0.45).Projectile(_loc20_).Count(5).Angle(0.5).Offset(0.1).IsBaseWeapon(true);
         var _loc155_:Single = new Single().Range(360).Power(630).ReloadTime(0.6).Projectile(_loc19_).IsBaseWeapon(true);
         var _loc156_:Single = new Single().Range(360).Power(630).ReloadTime(0.6).Projectile(_loc115_);
         var _loc157_:Sequence = new Sequence().Range(360).ReloadTime(0.6).ChildWeapons(Vector.<Weapon>([_loc155_,_loc155_,_loc155_,_loc156_]));
         var _loc158_:Spread = new Spread().Range(1000).Power(280).ReloadTime(1.8).Projectile(_loc29_).Count(8).Angle(Math.PI * 2 * 7 / 8).Proxied(true).Rotate(false).IsBaseWeapon(true);
         var _loc159_:Spread = new Spread().Range(1000).Power(280).ReloadTime(1).Projectile(_loc31_).Count(16).Angle(Math.PI * 2 * 15 / 16).Proxied(true).Rotate(false).IsBaseWeapon(true);
         var _loc160_:Spread = new Spread().Range(1000).Power(280).ReloadTime(1.08).Projectile(_loc32_).Count(8).Angle(Math.PI * 2 * 7 / 8).Proxied(true).Rotate(false).IsBaseWeapon(true);
         var _loc161_:Single = new Single().Power(800).Range(1000).Projectile(_loc76_).Proxied(true).Rotate(false).IsBaseWeapon(true);
         var _loc162_:Single = new Single().Power(1100).Range(1000).Projectile(_loc30_).Proxied(true).Rotate(false).IsBaseWeapon(true);
         var _loc163_:Sequence = new Sequence("spectreWeapon").Range(1000).ReloadTime(0.04).Proxied(true).ChildWeapons(Vector.<Weapon>([_loc162_,_loc161_])).IsBaseWeapon(true);
         var _loc164_:Spread = new Spread().Range(161).Power(805).ReloadTime(0.9).Projectile(_loc21_).Angle(0.43).Count(3).IsBaseWeapon(true);
         var _loc165_:Single = new Single().Range(161).Power(805).ReloadTime(0.23).Projectile(_loc11_).IsBaseWeapon(true);
         var _loc166_:Single = new Single().Range(440).Power(385).ReloadTime(1.54).Projectile(_loc33_).IsBaseWeapon(true);
         var _loc167_:Single = new Single().Range(440).Power(560).ReloadTime(1.4).Projectile(_loc34_).IsBaseWeapon(true);
         var _loc168_:Spread = new Spread().Range(520).Power(700).ReloadTime(1.33).Projectile(_loc35_).Count(1).Angle(0.5).IsBaseWeapon(true);
         var _loc169_:Spread = new Spread().Range(520).Power(700).ReloadTime(0.36).Projectile(_loc36_).Count(1).Angle(0.5).IsBaseWeapon(true);
         var _loc170_:Spread = new Spread().Range(520).Power(700).ReloadTime(1.17).Projectile(_loc39_).Count(1).Angle(0.5).IsBaseWeapon(true);
         var _loc171_:Spread = new Spread().Range(520).Power(700).ReloadTime(1.17).Projectile(_loc40_).Count(1).Angle(0.5).IsBaseWeapon(true);
         var _loc172_:Circular = new Circular("tackWeapon").Range(70).Power(350).ReloadTime(1.66).Projectile(_loc41_).Count(8).IsBaseWeapon(true);
         this.weapons[_loc172_.id] = _loc172_;
         var _loc173_:Circular = new Circular("tackSprayerWeapon").Range(70).Power(350).ReloadTime(0.66).Projectile(_loc41_).Count(16).IsBaseWeapon(true);
         this.weapons[_loc173_.id] = _loc173_;
         var _loc174_:Surround = new Surround("ringOfFireWeapon").Range(80).ReloadTime(0.33).Projectile(_loc44_).Lifespan(0.25).IsBaseWeapon(true);
         this.weapons[_loc174_.id] = _loc174_;
         var _loc175_:Circular = new Circular("bladeShooterWeapon").Range(88).Power(490).ReloadTime(1.51).Projectile(_loc43_).Count(8).IsBaseWeapon(true);
         this.weapons[_loc175_.id] = _loc175_;
         var _loc176_:Single = new Single().Range(225).Power(630).ReloadTime(1).Projectile(_loc45_).IsBaseWeapon(true);
         var _loc177_:SingleSpread = new SingleSpread().Range(225).Power(630).ReloadTime(0.28).Projectile(_loc48_).Spread(0.4).IsBaseWeapon(true);
         var _loc178_:Single = new Single().Range(225).Power(630).ReloadTime(1).Projectile(_loc50_).IsBaseWeapon(true);
         var _loc179_:Single = new Single().Range(225).Power(630).ReloadTime(1).Projectile(_loc51_).IsBaseWeapon(true);
         var _loc180_:Surround = new Surround().Range(60).ReloadTime(2.1).Projectile(_loc52_).Lifespan(0.1).IsBaseWeapon(true).IsBaseWeapon(true);
         var _loc181_:Surround = new Surround().Range(105).ReloadTime(2.1).Projectile(_loc53_).Lifespan(0.1).IsBaseWeapon(true);
         var _loc182_:Surround = new Surround().Range(60).ReloadTime(2.1).Projectile(_loc55_).Lifespan(0.1).IsBaseWeapon(true);
         var _loc183_:Surround = new Surround().Range(105).ReloadTime(2.1).Projectile(_loc56_).Lifespan(0.1).IsBaseWeapon(true);
         var _loc184_:Single = new Single().Range(234).Power(455).ReloadTime(1.54).Projectile(_loc74_).IsBaseWeapon(true);
         var _loc185_:Surround = new Surround().Range(999).ReloadTime(3).Lifespan(3).Projectile(_loc83_).Proxied(true).Lifespan(0.1);
         var _loc186_:Surround = new Surround().Range(999).ReloadTime(3).Lifespan(3).Projectile(_loc83_).Proxied(true).Lifespan(0.1);
         var _loc187_:Single = new Single().Range(234).Power(455).ReloadTime(1.17).Projectile(_loc94_).IsBaseWeapon(true);
         var _loc188_:Single = new Single().Range(234).Power(455).ReloadTime(1.17).Projectile(_loc95_).IsBaseWeapon(true);
         var _loc189_:Single = new Single().Range(234).Power(455).ReloadTime(1.54).Projectile(_loc97_).IsBaseWeapon(true);
         var _loc190_:Single = new Single().Range(234).Power(455).ReloadTime(1.54).Projectile(_loc98_);
         var _loc191_:Single = new Single("MagicBoltWeapon").Range(240).Power(460).Projectile(_loc99_).ReloadTime(1.1).IsBaseWeapon(true);
         var _loc192_:Single = new Single("IntenseMagicBoltWeapon").Range(240).Power(460).Projectile(_loc100_).ReloadTime(1.1).IsBaseWeapon(true);
         var _loc193_:Single = new Single("IntenseMagicBoltWeapon").Range(240).Power(460).Projectile(_loc101_).ReloadTime(1.1).IsBaseWeapon(true);
         var _loc194_:SingleSpreadFlame = new SingleSpreadFlame().Range(120).Power(160).ReloadTime(0.08).Projectile(_loc104_).Spread(0.4);
         var _loc195_:Single = new Single().Range(240).Power(460).Projectile(_loc112_).ReloadTime(2.1);
         var _loc196_:Single = new Single().Range(240).Power(460).Projectile(_loc113_).ReloadTime(2.1);
         var _loc197_:Sequence = new Sequence().ReloadTime(1.1).ChildWeapons(Vector.<Weapon>([_loc191_]));
         var _loc198_:CastLightning = new CastLightning().Range(120).Power(3600).Projectile(_loc105_).ReloadTime(2.2);
         var _loc199_:CastLightning = new CastLightning().Range(120).Power(3600).Projectile(_loc106_).ReloadTime(2.2);
         var _loc200_:Single = new Single().Range(120).Power(300).Projectile(_loc108_).ReloadTime(2.5);
         var _loc201_:Single = new Single().Range(240).Power(300).Projectile(_loc109_).ReloadTime(1.75);
         var _loc202_:Single = new Single().Range(240).Power(300).Projectile(_loc110_).ReloadTime(1.75);
         var _loc203_:Sequence = new Sequence().ReloadTime(1.1).ChildWeapons(Vector.<Weapon>([_loc192_,_loc198_,_loc200_]));
         var _loc204_:Sequence = new Sequence().ReloadTime(1.1).ChildWeapons(Vector.<Weapon>([_loc192_,_loc198_,_loc201_]));
         var _loc205_:SideSingle = new SideSingle().Range(300).Power(525).ReloadTime(1).Projectile(_loc116_).FireFromRight("cannon_right").FireFromLeft("cannon_left").IsBaseWeapon(true);
         var _loc206_:SideSingle = new SideSingle().Range(300).Power(525).ReloadTime(1).Projectile(_loc117_).FireFromRight("cannon_right").FireFromLeft("cannon_left").IsBaseWeapon(true);
         var _loc207_:SideSingle = new SideSingle().Range(300).Power(525).ReloadTime(0.14).Projectile(_loc116_).FireFromRight("cannon_frontRight").FireFromLeft("cannon_frontLeft").IsBaseWeapon(true);
         var _loc208_:Spread = new Spread().ReloadTime(0.6).Angle(Math.PI * 2 * 7 / 8).Count(8).Projectile(_loc29_).Power(200).Range(1235).Rotate(false).IsBaseWeapon(true);
         var _loc209_:Single = new Single().ReloadTime(0.15).Projectile(_loc29_).Power(500).Range(1235).Rotate(false).IsBaseWeapon(true);
         var _loc210_:LaunchBee = new LaunchBee().ReloadTime(0.57);
         var _loc211_:Single = new Single().ReloadTime(0.714).Projectile(_loc17_).Power(595).Range(170);
         var _loc212_:LaunchAircraft = new LaunchAircraft().ReloadTime(2).AircraftWeapon(Vector.<Weapon>([_loc208_,_loc209_,_loc209_]));
         var _loc213_:SideSpread = new SideSpread().Range(300).Power(525).ReloadTime(0.75).Projectile(_loc118_).Count(4).Angle(Math.PI / 2).FireFromRight("cannon_backRight").FireFromLeft("cannon_backLeft");
         var _loc214_:SideSpread = new SideSpread().Range(300).Power(525).ReloadTime(0.75).Projectile(_loc119_).Count(4).Angle(Math.PI / 2).FireFromRight("cannon_backRight").FireFromLeft("cannon_backLeft");
         var _loc215_:SideSingle = new SideSingle().Range(234).Power(300).ReloadTime(1.3).Projectile(_loc74_).FireFromRight("cannon_right").FireFromLeft("cannon_left");
         var _loc216_:SideSingle = new SideSingle().Range(234).Power(300).ReloadTime(1.2).Projectile(_loc75_).FireFromRight("cannon_right").FireFromLeft("cannon_left");
         var _loc217_:SpikeSpread = new SpikeSpread().Power(115).ReloadTime(2.29).Projectile(_loc90_).Rotate(false).IsBaseWeapon(true);
         var _loc218_:SpikeSpread = new SpikeSpread().Power(115).ReloadTime(0.5).Projectile(_loc91_).Rotate(false).IsBaseWeapon(true);
         var _loc219_:SpikeSpread = new SpikeSpread().Power(115).ReloadTime(2.29).Projectile(_loc92_).Rotate(false).IsBaseWeapon(true);
         var _loc220_:SpikeSpread = new SpikeSpread().Power(115).ReloadTime(1).Projectile(_loc93_).Rotate(false).IsBaseWeapon(true);
         var _loc221_:TowerDef = new TowerDef("DartMonkey").Label("Dart Monkey").Description("Shoots a single dart that pops a single bloon. A good, cheap tower suitable for the early rounds.").Display(assets.towers.DartMonkey).Detail(assets.detailView.DartMonkey).DetailSmall(assets.PlayUI.DartMonkey).OccupiedSpace(Small).RangeOfVisibility(100).Behavior(new ninjakiwi.monkeyTown.btdModule.towers.behavior.BehaviorDef().Process(new RotateToTarget())).Weapons(Vector.<Weapon>([_loc120_])).WeaponOffsets(Vector.<Vector2>([new Vector2(6,9)]));
         this.baseTowers.push(_loc221_);
         var _loc222_:TowerDef = new TowerDef("Spike-o-pult").Label("Spike-o-pult").Display(assets.towers.SpikeOPult).OccupiedSpace(Small).Detail(assets.detailView.SpikeOPult).DetailSmall(assets.PlayUI.SpikeOPult).RangeOfVisibility(150).TargetMask(Vector.<int>([Bloon.IMMUNITY_NONE])).Behavior(new ninjakiwi.monkeyTown.btdModule.towers.behavior.BehaviorDef().Process(new RotateToTarget())).Weapons(Vector.<Weapon>([_loc166_]));
         this.baseTowers.push(_loc222_);
         var _loc223_:TowerDef = new TowerDef("Juggernaut").Label("Juggernaut").Display(assets.towers.Juggernaut).OccupiedSpace(Small).Detail(assets.detailView.Juggernaut).DetailSmall(assets.PlayUI.Juggernaut).RangeOfVisibility(175).TargetMask(Vector.<int>([Bloon.IMMUNITY_NONE])).Behavior(new ninjakiwi.monkeyTown.btdModule.towers.behavior.BehaviorDef().Process(new RotateToTarget())).Weapons(Vector.<Weapon>([_loc167_]));
         this.baseTowers.push(_loc223_);
         var _loc224_:TowerDef = new TowerDef("TripleDarts").Label("Dart Monkey").Display(TripleShot).OccupiedSpace(Small).RangeOfVisibility(100).Detail(assets.detailView.TripleDarts).DetailSmall(assets.PlayUI.TripleDarts).Behavior(new ninjakiwi.monkeyTown.btdModule.towers.behavior.BehaviorDef().Process(new RotateToTarget())).WeaponOffsets(Vector.<Vector2>([new Vector2(6,9)])).Weapons(Vector.<Weapon>([_loc164_]));
         this.baseTowers.push(_loc224_);
         var _loc225_:TowerDef = new TowerDef("SuperMonkeyFanClub").Label("Dart Monkey").Display(DartSuperCall).OccupiedSpace(Small).RangeOfVisibility(100).Detail(assets.detailView.FanClub).DetailSmall(assets.PlayUI.FanClub).Behavior(new ninjakiwi.monkeyTown.btdModule.towers.behavior.BehaviorDef().Process(new RotateToTarget()).RoundOver(new StopAnimation())).Weapons(Vector.<Weapon>([_loc164_])).Abilities(Vector.<AbilityDef>([new SuperMonkeyFanClubDef("SuperMonkeyFanClub").Cooldown(45).Sound(SuperHeroUpgrade).Thumb(ActivatedAbilityDartMonkey).Label("Super Monkey Fan Club Ability").Description("Converts up to 10 nearby dart monkeys into Super Monkeys for 15 seconds").AbilityClass(SuperMonkeyFanClub)])).WeaponOffsets(Vector.<Vector2>([new Vector2(6,9)]));
         this.baseTowers.push(_loc225_);
         var _loc226_:TowerDef = new TowerDef("TackTower").Label("Tack Shooter").Description("Shoots 8 tacks spread in all directions, each tack can pop 1 bloon. Has short range and medium-slow fire rate.").Display(assets.towers.TackTower).Detail(assets.detailView.TackTower).OccupiedSpace(Small).RangeOfVisibility(70).DetailSmall(assets.PlayUI.TackTower).CanPriorityTarget(false).Weapons(Vector.<Weapon>([_loc172_]));
         this.baseTowers.push(_loc226_);
         var _loc227_:TowerDef = new TowerDef("TackSprayer").Label("Tack Sprayer").Display(assets.towers.TackSprayer).OccupiedSpace(Small).RangeOfVisibility(70).Detail(assets.detailView.TackSprayer).DetailSmall(assets.PlayUI.TackSprayer).CanPriorityTarget(false).Weapons(Vector.<Weapon>([_loc173_]));
         this.baseTowers.push(_loc227_);
         var _loc228_:TowerDef = new TowerDef("RingOfFire").Label("Ring of Fire").Display(assets.towers.RingOfFire).OccupiedSpace(Small).RangeOfVisibility(80).Detail(assets.detailView.RingOfFire).DetailSmall(assets.PlayUI.RingOfFire).CanPriorityTarget(false).Weapons(Vector.<Weapon>([_loc174_]));
         this.baseTowers.push(_loc228_);
         var _loc229_:TowerDef = new TowerDef("BladeShooter").Label("Blade Shooter").Display(assets.towers.BladeShooter).OccupiedSpace(Small).RangeOfVisibility(88).Detail(assets.detailView.BladeShooter).DetailSmall(assets.PlayUI.BladeShooter).CanPriorityTarget(false).Weapons(Vector.<Weapon>([_loc175_]));
         this.baseTowers.push(_loc229_);
         var _loc230_:TowerDef = new TowerDef("BladeMaelstrom").Label("Blade Shooter").Display(assets.towers.BladeMaelstrom).OccupiedSpace(Small).RangeOfVisibility(88).Detail(assets.detailView.Maelstrom).DetailSmall(assets.PlayUI.Maelstrom).CanPriorityTarget(false).Weapons(Vector.<Weapon>([_loc175_])).Abilities(Vector.<AbilityDef>([new MaelstromDef("Maelstrom").Cooldown(20).Sound(assets.sound.BladeMaelstrom).Thumb(ActivatedAbilityTackTower).Label("Blade Maelstrom Ability").Description("Covers the area in an unstoppable storm of blades.").Effect(TackTowerSpiral).AbilityClass(ninjakiwi.monkeyTown.btdModule.abilities.Maelstrom)]));
         this.baseTowers.push(_loc230_);
         var _loc231_:TowerDef = new TowerDef("GlueGunner").Label("Glue Gunner").Description("Shoots a glob of monkey glue at a single bloon. Glued bloons move more slowly than normal.").Display(GlueGunner).Detail(assets.detailView.GlueMonkey).OccupiedSpace(Small).DetailSmall(assets.PlayUI.GlueMonkey).RangeOfVisibility(140).TargetMask(Vector.<int>([Bloon.IMMUNITY_NO_DETECTION,Bloon.IMMUNITY_GLUE])).SacrificeType(Sacrifice.SACRIFICE_TYPE_GLUE).Behavior(new ninjakiwi.monkeyTown.btdModule.towers.behavior.BehaviorDef().Process(new RotateToTarget())).Weapons(Vector.<Weapon>([_loc176_])).WeaponOffsets(Vector.<Vector2>([new Vector2(10,5)]));
         this.baseTowers.push(_loc231_);
         var _loc232_:TowerDef = new TowerDef("GlueHose").Label("Glue Hose").Description("").Display(assets.towers.GlueHose).OccupiedSpace(Small).RangeOfVisibility(140).Detail(assets.detailView.GlueHoser).DetailSmall(assets.PlayUI.GlueHoser).TargetMask(Vector.<int>([Bloon.IMMUNITY_NO_DETECTION,Bloon.IMMUNITY_GLUE])).SacrificeType(Sacrifice.SACRIFICE_TYPE_GLUE).Behavior(new ninjakiwi.monkeyTown.btdModule.towers.behavior.BehaviorDef().Process(new RotateToTarget())).Weapons(Vector.<Weapon>([_loc177_])).WeaponOffsets(Vector.<Vector2>([new Vector2(10,5)]));
         this.baseTowers.push(_loc232_);
         var _loc233_:TowerDef = new TowerDef("GlueStriker").Label("Glue Striker").Description("").Display(assets.towers.GlueStriker).OccupiedSpace(Small).RangeOfVisibility(140).Detail(assets.detailView.GlueStriker).DetailSmall(assets.PlayUI.GlueStriker).TargetMask(Vector.<int>([Bloon.IMMUNITY_NO_DETECTION,Bloon.IMMUNITY_GLUE])).SacrificeType(Sacrifice.SACRIFICE_TYPE_GLUE).Behavior(new ninjakiwi.monkeyTown.btdModule.towers.behavior.BehaviorDef().Process(new RotateToTarget())).Weapons(Vector.<Weapon>([_loc177_])).Abilities(Vector.<AbilityDef>([new ProjectileHitAllDef("ProjectileHitAllGlue").Projectile(_loc49_).Cooldown(45).FullscreenEffect(GlueGunnerRain).Sound(GlueStrike).Thumb(ActivatedAbilityGlueGunner).Label("Glue Strike Ability").Description("Glues all bloons on the screen.").AbilityClass(ProjectileHitAll)])).WeaponOffsets(Vector.<Vector2>([new Vector2(10,5)]));
         this.baseTowers.push(_loc233_);
         var _loc234_:TowerDef = new TowerDef("BloonDisolver").Label("Bloon Dissolver").Description("").Display(assets.towers.BloonDissolver).OccupiedSpace(Small).RangeOfVisibility(140).Detail(assets.detailView.BloonDissolver).DetailSmall(assets.PlayUI.BloonDissolver).TargetMask(Vector.<int>([Bloon.IMMUNITY_NO_DETECTION,Bloon.IMMUNITY_GLUE])).SacrificeType(Sacrifice.SACRIFICE_TYPE_GLUE).Behavior(new ninjakiwi.monkeyTown.btdModule.towers.behavior.BehaviorDef().Process(new RotateToTarget())).Weapons(Vector.<Weapon>([_loc178_])).WeaponOffsets(Vector.<Vector2>([new Vector2(10,5)]));
         this.baseTowers.push(_loc234_);
         var _loc235_:TowerDef = new TowerDef("BloonLiquefier").Label("Bloon Liquefier").Description("").Display(BloonLiquifier).OccupiedSpace(Small).RangeOfVisibility(140).Detail(assets.detailView.BloonLiquefier).DetailSmall(assets.PlayUI.BloonLiquefier).TargetMask(Vector.<int>([Bloon.IMMUNITY_NO_DETECTION,Bloon.IMMUNITY_GLUE])).SacrificeType(Sacrifice.SACRIFICE_TYPE_GLUE).Behavior(new ninjakiwi.monkeyTown.btdModule.towers.behavior.BehaviorDef().Process(new RotateToTarget())).Weapons(Vector.<Weapon>([_loc179_])).WeaponOffsets(Vector.<Vector2>([new Vector2(10,5)]));
         this.baseTowers.push(_loc235_);
         var _loc236_:TowerDef = new TowerDef("IceTower").Label("Ice Tower").Description("Freezes bloons in its burst radius for a short time. Frozen bloons are immune to sharp objects.").Display(IceTower).Detail(assets.detailView.SnowMonkey).OccupiedSpace(Small).RangeOfVisibility(60).DetailSmall(assets.PlayUI.SnowMonkey).CanPriorityTarget(false).TargetMask(Vector.<int>([Bloon.IMMUNITY_NO_DETECTION,Bloon.IMMUNITY_ICE])).SacrificeType(Sacrifice.SACRIFICE_TYPE_FREEZE).Weapons(Vector.<Weapon>([_loc180_])).DisplayAddons(Vector.<DisplayAddonDef>([new DisplayAddonDef().Clip(SnowFlakes).Z(1)]));
         this.baseTowers.push(_loc236_);
         var _loc237_:TowerDef = new TowerDef("IceShards").Label("Ice Tower").Description("Creates razor sharp pieces of ice on frozen bloons, that when popped, fly out and pop more nearby bloons.").Display(assets.towers.IceShards).OccupiedSpace(Small).CanPriorityTarget(false).RangeOfVisibility(60).DetailSmall(assets.PlayUI.IceShards).Detail(assets.detailView.IceShards).TargetMask(Vector.<int>([Bloon.IMMUNITY_NO_DETECTION,Bloon.IMMUNITY_ICE])).SacrificeType(Sacrifice.SACRIFICE_TYPE_FREEZE).Weapons(Vector.<Weapon>([_loc182_])).DisplayAddons(Vector.<DisplayAddonDef>([new DisplayAddonDef().Clip(SnowFlakes).Z(1)]));
         this.baseTowers.push(_loc237_);
         var _loc238_:TowerDef = new TowerDef("ViralFrost").Label("Ice Tower").Description("Creates razor sharp pieces of ice on frozen bloons, that when popped, fly out and pop more nearby bloons.").Display(ViralForst).OccupiedSpace(Small).CanPriorityTarget(false).RangeOfVisibility(105).DetailSmall(assets.PlayUI.ViralFrost).Detail(assets.detailView.ViralFrost).TargetMask(Vector.<int>([Bloon.IMMUNITY_NO_DETECTION,Bloon.IMMUNITY_ICE])).SacrificeType(Sacrifice.SACRIFICE_TYPE_FREEZE).Weapons(Vector.<Weapon>([_loc183_])).Behavior(new ninjakiwi.monkeyTown.btdModule.towers.behavior.BehaviorDef().RoundStart(new SpawnArcticWind()).RoundOver(new RetractArcticWind())).DisplayAddons(Vector.<DisplayAddonDef>([new DisplayAddonDef().Clip(ViralFog).Z(1)]));
         this.baseTowers.push(_loc238_);
         var _loc239_:TowerDef = new TowerDef("ArcticWind").Label("Ice Tower").Description("").Display(assets.towers.ArcticWind).OccupiedSpace(Small).CanPriorityTarget(false).RangeOfVisibility(105).DetailSmall(assets.PlayUI.ArcticWind).Detail(assets.detailView.ArcticWind).TargetMask(Vector.<int>([Bloon.IMMUNITY_NO_DETECTION,Bloon.IMMUNITY_ICE])).SacrificeType(Sacrifice.SACRIFICE_TYPE_FREEZE).Weapons(Vector.<Weapon>([_loc181_])).Behavior(new ninjakiwi.monkeyTown.btdModule.towers.behavior.BehaviorDef().RoundStart(new SpawnArcticWind()).RoundOver(new RetractArcticWind())).DisplayAddons(Vector.<DisplayAddonDef>([new DisplayAddonDef().Clip(Blizzard).Z(1)]));
         this.baseTowers.push(_loc239_);
         var _loc240_:TowerDef = new TowerDef("AbsoluteZero").Label("Ice Tower").Description("").Display(assets.towers.AbsoluteZero).OccupiedSpace(Small).RangeOfVisibility(60).CanPriorityTarget(false).DetailSmall(assets.PlayUI.AbsoluteZero).Detail(assets.detailView.AbsoluteZero).TargetMask(Vector.<int>([Bloon.IMMUNITY_NO_DETECTION,Bloon.IMMUNITY_ICE])).SacrificeType(Sacrifice.SACRIFICE_TYPE_FREEZE).Weapons(Vector.<Weapon>([_loc182_])).Abilities(Vector.<AbilityDef>([new ProjectileHitAllDef("ProjectileHitAllIce").Projectile(_loc54_).Cooldown(45).FullscreenEffect(IceTowerSnowStorm).Sound(AbsoluteZeroIceTower).Thumb(ActivatedAbilityIceTower).Label("Absolute Zero Ability").Description("Freezes the entire screen of bloons for 4 seconds. Does not affect MOAB-class bloons.").AbilityClass(ProjectileHitAll)]));
         this.baseTowers.push(_loc240_);
         var _loc241_:TowerDef = new TowerDef("BombTower").Label("Bomb Shooter").Description("Shoots a single bomb that explodes in a radius burst on impact. Good range, medium-slow fire rate. Can pop lead bloons but not black bloons.").Display(assets.towers.BombTower).Detail(assets.detailView.BombTower).OccupiedSpace(Medium).RangeOfVisibility(120).DetailSmall(assets.PlayUI.BombTower).SacrificeType(Sacrifice.SACRIFICE_TYPE_EXPLOSION).Weapons(Vector.<Weapon>([_loc184_])).Behavior(new ninjakiwi.monkeyTown.btdModule.towers.behavior.BehaviorDef().Process(new RotateToTarget()));
         this.baseTowers.push(_loc241_);
         var _loc242_:TowerDef = new TowerDef("ClusterBombTower").Label("Cluster Bomb Shooter").Description("Shoots a single bomb that explodes in a radius burst on impact. Good range, medium-slow fire rate. Can pop lead bloons but not black bloons.").Display(assets.towers.ClusterBombs).OccupiedSpace(Medium).RangeOfVisibility(150).DetailSmall(assets.PlayUI.ClusterBombs).Detail(assets.detailView.ClusterBombs).SacrificeType(Sacrifice.SACRIFICE_TYPE_EXPLOSION).Weapons(Vector.<Weapon>([_loc189_])).Behavior(new ninjakiwi.monkeyTown.btdModule.towers.behavior.BehaviorDef().Process(new RotateToTarget()));
         this.baseTowers.push(_loc242_);
         var _loc243_:TowerDef = new TowerDef("BloonImpactBombTower").Label("Cluster Bomb Shooter").Description("").Display(assets.towers.BloonImpact).OccupiedSpace(Medium).RangeOfVisibility(150).DetailSmall(assets.PlayUI.BloonImpact).Detail(assets.detailView.BloonImpact).SacrificeType(Sacrifice.SACRIFICE_TYPE_EXPLOSION).Weapons(Vector.<Weapon>([_loc190_])).Behavior(new ninjakiwi.monkeyTown.btdModule.towers.behavior.BehaviorDef().Process(new RotateToTarget()));
         this.baseTowers.push(_loc243_);
         var _loc244_:TowerDef = new TowerDef("MoabMauler").Label("MOAB Mauler").Description("").Display(MoabMauler).OccupiedSpace(Medium).RangeOfVisibility(125).DetailSmall(assets.PlayUI.MOABMauler).Detail(assets.detailView.MOABMauler).SacrificeType(Sacrifice.SACRIFICE_TYPE_EXPLOSION).Weapons(Vector.<Weapon>([_loc187_])).Behavior(new ninjakiwi.monkeyTown.btdModule.towers.behavior.BehaviorDef().Process(new RotateToTarget()));
         this.baseTowers.push(_loc244_);
         var _loc245_:TowerDef = new TowerDef("MoabAssassin").Label("MOAB Assassin").Description("").Display(MoabAssassin).OccupiedSpace(Medium).DetailSmall(assets.PlayUI.MOABAssassin).Detail(assets.detailView.MOABAssassin).RangeOfVisibility(125).SacrificeType(Sacrifice.SACRIFICE_TYPE_EXPLOSION).Weapons(Vector.<Weapon>([_loc188_])).Abilities(Vector.<AbilityDef>([new MoabAssassinDef("MoabAssassin").Cooldown(45).Effect(Bombtoweraura).Sound(MoabAssassinMissile).Thumb(ActivatedAbilityBombTower).Label("MOAB Assassin Ability").Description("Super deadly missile seeks the nearest MOAB-class bloon and destroys it instantly. Does 1000 damage to ZOMG bloons instead of destroying them.").AbilityClass(MoabAssasin)])).Behavior(new ninjakiwi.monkeyTown.btdModule.towers.behavior.BehaviorDef().Process(new RotateToTarget()));
         this.baseTowers.push(_loc245_);
         var _loc246_:TowerDef = new TowerDef("BoomerangThrower").Label("Boomerang Thrower").Description("Throws a single boomerang in an arc back round to the monkey. Each boomerang can pop 3 bloons.").Display(assets.towers.BoomerangThrower).Detail(assets.detailView.BoomerangMonkey).OccupiedSpace(Medium).RangeOfVisibility(130).DetailSmall(assets.PlayUI.BoomerangMonkey).Behavior(new ninjakiwi.monkeyTown.btdModule.towers.behavior.BehaviorDef().Process(new RotateToTarget())).Weapons(Vector.<Weapon>([_loc168_])).WeaponOffsets(Vector.<Vector2>([new Vector2(26,8)]));
         this.baseTowers.push(_loc246_);
         var _loc247_:TowerDef = new TowerDef("BionicBoomer").Label("Boomerang Thrower").Description("Throws a single boomerang in an arc back round to the monkey. Each boomerang can pop 3 bloons.").Display(assets.towers.BionicBoomer).OccupiedSpace(Medium).RangeOfVisibility(130).DetailSmall(assets.PlayUI.BionicBoomer).Detail(assets.detailView.BionicBoomer).Behavior(new ninjakiwi.monkeyTown.btdModule.towers.behavior.BehaviorDef().Process(new RotateToTarget())).Weapons(Vector.<Weapon>([_loc169_]));
         this.baseTowers.push(_loc247_);
         var _loc248_:TowerDef = new TowerDef("TurboCharge").Label("Boomerang Thrower").Description("").Display(assets.towers.BionicBoomer).OccupiedSpace(Medium).RangeOfVisibility(130).DetailSmall(assets.PlayUI.TurboCharge).Detail(assets.detailView.TurboCharge).Behavior(new ninjakiwi.monkeyTown.btdModule.towers.behavior.BehaviorDef().Process(new RotateToTarget())).Weapons(Vector.<Weapon>([_loc169_])).Abilities(Vector.<AbilityDef>([new TurboDef("Turbo").Cooldown(45).Sound(TurboBoomerang).Effect(BoomerangAura).Thumb(ActivatedAbilityBoomerangThrower).Label("Turbo Charge Ability").Description("Increase attack speed to hypersonic for 10 seconds.").AbilityClass(Turbo)]));
         this.baseTowers.push(_loc248_);
         var _loc249_:TowerDef = new TowerDef("GlaiveRiccochet").Label("Boomerang Thrower").Description("Throws a single boomerang in an arc back round to the monkey. Each boomerang can pop 3 bloons.").Display(GlaiveRicochet).OccupiedSpace(Medium).RangeOfVisibility(130).DetailSmall(assets.PlayUI.Ricochet).Detail(assets.detailView.Ricochet).Behavior(new ninjakiwi.monkeyTown.btdModule.towers.behavior.BehaviorDef().Process(new RotateToTarget())).Weapons(Vector.<Weapon>([_loc170_]));
         this.baseTowers.push(_loc249_);
         var _loc250_:TowerDef = new TowerDef("GlaiveLord").Label("Glaive Lord").Description("Throws a single boomerang in an arc back round to the monkey. Each boomerang can pop 3 bloons.").Display(assets.towers.GlaiveLord).OccupiedSpace(Medium).RangeOfVisibility(130).DetailSmall(assets.PlayUI.GlaiveLord).Detail(assets.detailView.GlaiveLord).TargetMask(Vector.<int>([Bloon.IMMUNITY_NONE])).Weapons(Vector.<Weapon>([_loc171_])).Behavior(new ninjakiwi.monkeyTown.btdModule.towers.behavior.BehaviorDef().RoundStart(new SpawnGlaives()).RoundOver(new RetractGlaives()).Process(new GlaiveLordProcess()));
         this.baseTowers.push(_loc250_);
         var _loc251_:TowerDef = new TowerDef("MonkeyVillage").Label("Monkey Village").Description("Monkey Village does not attack bloons but instead lowers cost of all towers and upgrades in radius by 10%. Has many useful upgrades that help nearby towers.").Display(assets.towers.MonkeyVillage).Detail(assets.detailView.MonkeyVillage).OccupiedSpace(VillageSpace).RangeOfVisibility(120).DetailSmall(assets.PlayUI.MonkeyVillage).CanPriorityTarget(false).AreaEffects(Vector.<AreaEffectDef>([_loc2_]));
         this.baseTowers.push(_loc251_);
         var _loc252_:TowerDef = new TowerDef("EnergyBeacon").Label("Monkey Town").Description("").Display(assets.towers.MonkeyTown).OccupiedSpace(VillageSpace).RangeOfVisibility(150).DetailSmall(assets.PlayUI.EnergyBeacon).Detail(assets.detailView.EnergyBeacon).AreaEffects(Vector.<AreaEffectDef>([_loc2_,_loc3_,_loc4_,_loc6_,_loc7_])).DisplayAddons(Vector.<DisplayAddonDef>([new DisplayAddonDef().Clip(Beacon),new DisplayAddonDef().Clip(assets.towers.EnergyBeacon).Z(2)])).Weapons(Vector.<Weapon>([_loc131_])).WeaponOffsets(Vector.<Vector2>([new Vector2(0,-59)]));
         this.baseTowers.push(_loc252_);
         var _loc253_:TowerDef = new TowerDef("MonkeyTown").Label("Monkey Town").Description("").Display(assets.towers.MonkeyTown).OccupiedSpace(VillageSpace).RangeOfVisibility(135).CanPriorityTarget(false).DetailSmall(assets.PlayUI.MonkeyTown).Detail(assets.detailView.MonkeyTown).AreaEffects(Vector.<AreaEffectDef>([_loc2_,_loc3_,_loc4_,_loc7_])).DisplayAddons(Vector.<DisplayAddonDef>([new DisplayAddonDef().Clip(Beacon)]));
         this.baseTowers.push(_loc253_);
         var _loc254_:TowerDef = new TowerDef("MonkeyIntelligenceBureau").Label("Monkey Intelligence Bureau").Description("").Display(MonkeyIntelligenceBurau).OccupiedSpace(VillageSpace).RangeOfVisibility(145).CanPriorityTarget(false).DetailSmall(assets.PlayUI.MIB).Detail(assets.detailView.MIB).AreaEffects(Vector.<AreaEffectDef>([_loc2_,_loc5_,_loc8_,_loc9_,_loc10_])).DisplayAddons(Vector.<DisplayAddonDef>([new DisplayAddonDef().Clip(assets.towers.RadarScanner).Z(2)]));
         this.baseTowers.push(_loc254_);
         var _loc255_:TowerDef = new TowerDef("MIBCallToArms").Label("Monkey Intelligence Bureau").Description("").Display(MonkeyIntelligenceBurau).OccupiedSpace(VillageSpace).RangeOfVisibility(155).DetailSmall(assets.PlayUI.CallToArms).Detail(assets.detailView.CallToArms).CanPriorityTarget(false).AreaEffects(Vector.<AreaEffectDef>([_loc2_,_loc5_,_loc8_,_loc9_,_loc10_])).DisplayAddons(Vector.<DisplayAddonDef>([new DisplayAddonDef().Clip(assets.towers.RadarScanner).Z(2)])).Abilities(Vector.<AbilityDef>([new MIBCallToArmsDef("MIBCallToArms").Cooldown(50).Sound(assets.sound.MIBCallToArms).Effect(MonkeyVillagePulse).Thumb(ActivatedAbilityMonkeyVillage).Label("Call to Arms Ability").Description("Doubles the attack speed and popping power of all nearby towers for 10 seconds.").AbilityClass(ninjakiwi.monkeyTown.btdModule.abilities.MIBCallToArms)]));
         this.baseTowers.push(_loc255_);
         var _loc256_:TowerDef = new TowerDef(TOWER_APPRENTICE).Label("Monkey Apprentice").Description("Trained in the arts of monkey magic, the Monkey Apprentice weaves magical bolts of power that pop bloons. Each shot can pop 2 bloons. Can upgrade to cast additional spells.").Display(MonkeyApprentice).Detail(assets.detailView.Apprentice).OccupiedSpace(Small).RangeOfVisibility(120).DetailSmall(assets.PlayUI.Apprentice).SacrificeType(Sacrifice.SACRIFICE_TYPE_WIND).Weapons(Vector.<Weapon>([_loc191_])).Behavior(new ninjakiwi.monkeyTown.btdModule.towers.behavior.BehaviorDef().Process(new RotateToTarget()));
         this.baseTowers.push(_loc256_);
         var _loc257_:TowerDef = new TowerDef("SummonWhirlwind").Label("Disciple of Air").Description("").Display(assets.towers.SummonWhirlwind).OccupiedSpace(Small).DetailSmall(assets.PlayUI.Whirlwind).Detail(assets.detailView.Whirlwind).RangeOfVisibility(120).SacrificeType(Sacrifice.SACRIFICE_TYPE_WIND).Weapons(Vector.<Weapon>([_loc192_,_loc198_,_loc200_])).Behavior(new ninjakiwi.monkeyTown.btdModule.towers.behavior.BehaviorDef().Process(new RotateToTarget()));
         this.baseTowers.push(_loc257_);
         var _loc258_:TowerDef = new TowerDef("TempestTornado").Label("Master of Air").Description("").Display(assets.towers.TempestTornado).OccupiedSpace(Small).DetailSmall(assets.PlayUI.Tempest).Detail(assets.detailView.Tempest).RangeOfVisibility(120).SacrificeType(Sacrifice.SACRIFICE_TYPE_WIND).Weapons(Vector.<Weapon>([_loc192_,_loc198_,_loc201_])).Behavior(new ninjakiwi.monkeyTown.btdModule.towers.behavior.BehaviorDef().Process(new RotateToTarget())).DisplayAddons(Vector.<DisplayAddonDef>([new DisplayAddonDef().Clip(TempestCloud).Z(-1).Rotate(false)]));
         this.baseTowers.push(_loc258_);
         var _loc259_:TowerDef = new TowerDef("DragonsBreath").Label("Disciple of Fire").Description("").Display(assets.towers.DragonsBreath).OccupiedSpace(Small).DetailSmall(assets.PlayUI.DragonsBreath).Detail(assets.detailView.DragonsBreath).RangeOfVisibility(120).SacrificeType(Sacrifice.SACRIFICE_TYPE_WIND).TargetMask(Vector.<int>([Bloon.IMMUNITY_NONE])).Weapons(Vector.<Weapon>([_loc194_,_loc191_,_loc195_])).WeaponOffsets(Vector.<Vector2>([new Vector2(60,0)])).Behavior(new ninjakiwi.monkeyTown.btdModule.towers.behavior.BehaviorDef().Process(new RotateToTarget()));
         this.baseTowers.push(_loc259_);
         var _loc260_:TowerDef = new TowerDef("SummonPhoenix").Label("Master of Fire").Description("").Display(assets.towers.SummonPhoenix).OccupiedSpace(Small).RangeOfVisibility(120).DetailSmall(assets.PlayUI.Phoenix).Detail(assets.detailView.Phoenix).SacrificeType(Sacrifice.SACRIFICE_TYPE_WIND).TargetMask(Vector.<int>([Bloon.IMMUNITY_NONE])).Weapons(Vector.<Weapon>([_loc194_,_loc191_,_loc195_])).Abilities(Vector.<AbilityDef>([new SummonPhoenixDef("SummonPhoenix").Cooldown(60).Sound(assets.sound.SummonPhoenix).Effect(MonkeyApprenticeFieryRing).Thumb(ActivatedAbilityMonkeyApprentice).Label("Summon Phoenix Ability").Description("Creates a super powerful flying phoenix that flies around wreaking bloon havoc for 25 seconds.").AbilityClass(ninjakiwi.monkeyTown.btdModule.abilities.SummonPhoenix)])).WeaponOffsets(Vector.<Vector2>([new Vector2(60,0)])).Behavior(new ninjakiwi.monkeyTown.btdModule.towers.behavior.BehaviorDef().Process(new RotateToTarget())).DisplayAddons(Vector.<DisplayAddonDef>([new DisplayAddonDef().Clip(FireCircle).Z(-1).Rotate(false)]));
         this.baseTowers.push(_loc260_);
         var _loc261_:TowerDef = new TowerDef("BananaFarm").Label("Banana Farm").Description("Banana Farms grow bananas that you can collect to turn into cash. When your farm produces some bananas, collect them by moving your mouse over them. Don\'t leave them too long however, or they will spoil!").Display(assets.towers.BananaFarm).Detail(assets.detailView.BananaFarm).OccupiedSpace(BananaFarmSpace).RangeOfVisibility(120).DetailSmall(assets.PlayUI.BananaFarm).CanPriorityTarget(false).Behavior(new ninjakiwi.monkeyTown.btdModule.towers.behavior.BehaviorDef().RoundStart(new BananaEmitter().CashPerPacket(30).CashPerRound(120).Lifespan(10).Display(Bananas)));
         this.baseTowers.push(_loc261_);
         var _loc262_:TowerDef = new TowerDef("MonkeyBank").Label("Monkey Bank").Description("").Display(MoneyBank).OccupiedSpace(BananaFarmSpace).RangeOfVisibility(120).DetailSmall(assets.PlayUI.MonkeyBank).Detail(assets.detailView.MonkeyBank).CanPriorityTarget(false).Behavior(new ninjakiwi.monkeyTown.btdModule.towers.behavior.BehaviorDef().RoundStart(new BananaEmitter().CashPerPacket(15).CashPerRound(675).CashScale(1).Lifespan(20).MaxFunds(7500).IntrestMultiplier(1.1).BankFunds(true)).RoundOver(new Intrest().IsCalledOnReInit(false)));
         this.baseTowers.push(_loc262_);
         var _loc263_:TowerDef = new TowerDef("BananaInvestmentsAdvisory").Label("Banana Investments Advisory").Description("").Display(BananaInvestmentsAdvisory).OccupiedSpace(BananaFarmSpace).RangeOfVisibility(120).CanPriorityTarget(false).DetailSmall(assets.PlayUI.InvestmentAdvisory).Detail(assets.detailView.InvestmentAdvisory).Behavior(new ninjakiwi.monkeyTown.btdModule.towers.behavior.BehaviorDef().RoundStart(new BananaEmitter().CashPerPacket(30).CashPerRound(1500).CashScale(1).Lifespan(20).MaxFunds(30000).IntrestMultiplier(1.2).BankFunds(true)).RoundOver(new Intrest().IsCalledOnReInit(false)));
         this.baseTowers.push(_loc263_);
         var _loc264_:TowerDef = new TowerDef("BananaRepublic").Label("Banana Republic").Description("").CanPriorityTarget(false).Display(assets.towers.BananaRepublic).OccupiedSpace(BananaFarmSpace).RangeOfVisibility(120).DetailSmall(assets.PlayUI.BananaRepublic).Detail(assets.detailView.BananaRepublic).Behavior(new ninjakiwi.monkeyTown.btdModule.towers.behavior.BehaviorDef().RoundStart(new BananaEmitter().CashPerPacket(30).CashPerRound(750).Lifespan(10).Display(Bananas)));
         this.baseTowers.push(_loc264_);
         var _loc265_:TowerDef = new TowerDef("BananaResearchFacility").Label("Banana Research Facility").Description("").Display(assets.towers.BananaResearchFacility).OccupiedSpace(BananaFarmSpace).RangeOfVisibility(120).CanPriorityTarget(false).DetailSmall(assets.PlayUI.ResearchFacility).Detail(assets.detailView.ResearchFacility).Behavior(new ninjakiwi.monkeyTown.btdModule.towers.behavior.BehaviorDef().RoundStart(new BananaEmitter().CashPerPacket(300).CashPerRound(3000).Lifespan(10).Display(BananaCrate)));
         this.baseTowers.push(_loc265_);
         var _loc266_:TowerDef = new TowerDef("MonkeyBuccaneer").Label("Monkey Buccaneer").Description("Monkey Buccaneers can only be placed on water. Shoots a single, heavy dart that can pop up to 5 bloons each.").Display(MonkeyBuccaneer).Detail(assets.detailView.Buccaneer).OccupiedSpace(Medium).DetailSmall(assets.PlayUI.Buccaneer).RangeOfVisibility(180).IsBoat(true).IsLand(false).DisplayAddons(Vector.<DisplayAddonDef>([new DisplayAddonDef().Clip(BuccaneerCannonsRight).Z(-1).Ref("cannon_right").Loop(false),new DisplayAddonDef().Clip(BuccaneerCannonsLeft).Z(-1).Ref("cannon_left").Loop(false)])).Weapons(Vector.<Weapon>([_loc205_]));
         this.baseTowers.push(_loc266_);
         var _loc267_:TowerDef = new TowerDef("Destroyer").Label("Destroyer").Description("").DetailSmall(assets.PlayUI.Destroyer).Detail(assets.detailView.Destroyer).Display(assets.towers.Destroyer).OccupiedSpace(Medium).RangeOfVisibility(210).IsBoat(true).IsLand(false).DisplayAddons(Vector.<DisplayAddonDef>([new DisplayAddonDef().Clip(RightFront).Z(-1).Ref("cannon_frontRight").Loop(false),new DisplayAddonDef().Clip(RightBack).Z(-1).Ref("cannon_backRight").Loop(false),new DisplayAddonDef().Clip(LeftFront).Z(-1).Ref("cannon_frontLeft").Loop(false),new DisplayAddonDef().Clip(LeftBack).Z(-1).Ref("cannon_backLeft").Loop(false)])).Weapons(Vector.<Weapon>([_loc207_]));
         this.baseTowers.push(_loc267_);
         var _loc268_:TowerDef = new TowerDef("AircraftCarrier").Label("Aircraft Carrier").Description("").Display(assets.towers.AircraftCarrier).OccupiedSpace(Medium).DetailSmall(assets.PlayUI.Carrier).Detail(assets.detailView.Carrier).RangeOfVisibility(9999).IsBoat(true).IsLand(false).Weapons(Vector.<Weapon>([_loc212_])).Behavior(new ninjakiwi.monkeyTown.btdModule.towers.behavior.BehaviorDef().Initialise(new ResetRotation()).RoundOver(new StopAnimation()));
         this.baseTowers.push(_loc268_);
         var _loc269_:TowerDef = new TowerDef("CannonShip").Label("Cannon Ship").Description("").Display(assets.towers.CannonShip).OccupiedSpace(Medium).DetailSmall(assets.PlayUI.CannonShip).Detail(assets.detailView.CannonShip).RangeOfVisibility(210).IsBoat(true).IsLand(false).TargetMask(Vector.<int>([Bloon.IMMUNITY_NONE])).DisplayAddons(Vector.<DisplayAddonDef>([new DisplayAddonDef().Clip(CannonShipCannonsRight).Z(-1).Ref("cannon_right").Loop(false),new DisplayAddonDef().Clip(CannonShipCannonsLeft).Z(-1).Ref("cannon_left").Loop(false)])).Weapons(Vector.<Weapon>([_loc206_,_loc214_,_loc216_]));
         this.baseTowers.push(_loc269_);
         var _loc270_:TowerDef = new TowerDef("MonkeyPirates").Label("Monkey Pirates").Description("").Display(assets.towers.MonkeyPirates).OccupiedSpace(Medium).DetailSmall(assets.PlayUI.Pirates).Detail(assets.detailView.Pirates).RangeOfVisibility(210).IsBoat(true).IsLand(false).TargetMask(Vector.<int>([Bloon.IMMUNITY_NONE])).DisplayAddons(Vector.<DisplayAddonDef>([new DisplayAddonDef().Clip(PiratesCannonsRight).Z(-1).Ref("cannon_right").Loop(false),new DisplayAddonDef().Clip(PiratesCannonsLeft).Z(-1).Ref("cannon_left").Loop(false),new DisplayAddonDef().Clip(HarpoonRight).Z(-1).Ref("harpoon_right").Loop(false),new DisplayAddonDef().Clip(HarpoonLeft).Z(-1).Ref("harpoon_left").Loop(false)])).Weapons(Vector.<Weapon>([_loc206_,_loc214_,_loc216_])).Abilities(Vector.<AbilityDef>([new MOABTakedownDef("MOABTakedown").Cooldown(55).Sound(GrapplingHookExtend).Thumb(ActivatedAbilityMonkeyBuccaneer).Label("MOAB Takedown Ability").Description("Takes hold of the nearest MOAB-class bloon with a grappling hook and brings it down. ZOMG bloons are immune to this.").AbilityClass(MOABTakedown)]));
         this.baseTowers.push(_loc270_);
         var _loc271_:TowerDef = new TowerDef("MonkeyAce").Label("Monkey Ace").Description("Patrols the skies above the action, regularly strafing the area with powerful darts in 8 directions.").Display(AirBase).Detail(assets.detailView.MonkeyAce).OccupiedSpace(AceSpace).RangeOfVisibility(50).CanPriorityTarget(false).DetailSmall(assets.PlayUI.MonkeyAce).Behavior(new ninjakiwi.monkeyTown.btdModule.towers.behavior.BehaviorDef().Initialise(new SpawnAce().Display(assets.towers.MonkeyAce)).RoundStart(new DeployMonkeyAce().Display(assets.towers.MonkeyAce)).RoundOver(new RetractMonkeyAce()).Destroy(new RemoveAceAircraft())).Weapons(Vector.<Weapon>([_loc158_])).RequiresTarget(false);
         this.baseTowers.push(_loc271_);
         var _loc272_:TowerDef = new TowerDef("NevaMissTargeting").Label("Monkey Ace").Description("").Display(AirBase).OccupiedSpace(Large).CanPriorityTarget(false).DetailSmall(assets.PlayUI.NevaMissAce).Detail(assets.detailView.NevaMissAce).RangeOfVisibility(50).Behavior(new ninjakiwi.monkeyTown.btdModule.towers.behavior.BehaviorDef().Initialise(new SpawnAce().Display(assets.towers.NevaMissTargeting)).RoundStart(new DeployMonkeyAce().Display(assets.towers.NevaMissTargeting)).RoundOver(new RetractMonkeyAce()).Destroy(new RemoveAceAircraft())).Weapons(Vector.<Weapon>([_loc160_])).RequiresTarget(false);
         this.baseTowers.push(_loc272_);
         var _loc273_:TowerDef = new TowerDef("Spectre").Label("Spectre").Description("").Display(AirBase).OccupiedSpace(Large).RangeOfVisibility(9999).DetailSmall(assets.PlayUI.Spectre).Detail(assets.detailView.Spectre).CanPriorityTarget(false).Behavior(new ninjakiwi.monkeyTown.btdModule.towers.behavior.BehaviorDef().Initialise(new SpawnAce().Display(assets.towers.Spectre)).RoundStart(new DeployMonkeyAce().Display(assets.towers.Spectre)).RoundOver(new RetractMonkeyAce()).Destroy(new RemoveAceAircraft())).Weapons(Vector.<Weapon>([_loc163_]));
         this.baseTowers.push(_loc273_);
         var _loc274_:TowerDef = new TowerDef("OperationDartStorm").Label("Monkey Ace").Description("").Display(AirBase).OccupiedSpace(Large).RangeOfVisibility(50).CanPriorityTarget(false).DetailSmall(assets.PlayUI.DartStorm).Detail(assets.detailView.DartStorm).TargetMask(Vector.<int>([Bloon.IMMUNITY_NONE])).Behavior(new ninjakiwi.monkeyTown.btdModule.towers.behavior.BehaviorDef().Initialise(new SpawnAce().Display(assets.towers.OperationDartStorm)).RoundStart(new DeployMonkeyAce().Display(assets.towers.OperationDartStorm)).RoundOver(new RetractMonkeyAce()).Destroy(new RemoveAceAircraft())).Weapons(Vector.<Weapon>([_loc159_,_loc186_])).RequiresTarget(false);
         this.baseTowers.push(_loc274_);
         var _loc275_:TowerDef = new TowerDef("GroundZero").Label("Monkey Ace").Description("").Display(AirBase).OccupiedSpace(Large).RangeOfVisibility(50).DetailSmall(assets.PlayUI.GroundZero).Detail(assets.detailView.GroundZero).CanPriorityTarget(false).TargetMask(Vector.<int>([Bloon.IMMUNITY_NONE])).Behavior(new ninjakiwi.monkeyTown.btdModule.towers.behavior.BehaviorDef().Initialise(new SpawnAce().Display(assets.towers.SupplyDrop)).RoundStart(new DeployMonkeyAce().Display(assets.towers.SupplyDrop)).RoundOver(new RetractMonkeyAce()).Destroy(new RemoveAceAircraft())).Weapons(Vector.<Weapon>([_loc159_,_loc186_])).Abilities(Vector.<AbilityDef>([new ProjectileHitAllDef("ProjectileHitAllAce").Cooldown(50).Projectile(new ProjectileDef().EffectMask(Vector.<int>([Bloon.IMMUNITY_NONE])).Pierce(999999).DamageEffect(new DamageEffectDef().Kill(true).Damage(350).CanBreakIce(true))).FullscreenEffect(MonkeyAceNuclearBlast).Thumb(ActivatedAbilityMonkeyAce).Label("Ground Zero Ability").Description("Drops a single devastating bomb that destroys all bloons on screen and heavily damages MOAB-class bloons.").AbilityClass(ProjectileHitAll)])).RequiresTarget(false);
         this.baseTowers.push(_loc275_);
         var _loc276_:TowerDef = new TowerDef("SuperMonkey").Label("Super Monkey").Description("Throws darts incredibly fast. Has long range and lots of insanely powerful upgrades.").Display(assets.towers.SuperMonkey).Detail(assets.detailView.SuperMonkey).DetailSmall(assets.PlayUI.SuperMonkey).OccupiedSpace(Large).RangeOfVisibility(140).Behavior(new ninjakiwi.monkeyTown.btdModule.towers.behavior.BehaviorDef().RoundOver(new StopAnimation())).Weapons(Vector.<Weapon>([_loc132_])).WeaponOffsets(Vector.<Vector2>([new Vector2(9,14)]));
         this.baseTowers.push(_loc276_);
         var _loc277_:TowerDef = new TowerDef("RoboMonkey").Label("Robo Monkey").Description("").Display(assets.towers.RoboMonkey).DetailSmall(assets.PlayUI.RoboMonkey).Detail(assets.detailView.RoboMonkey).OccupiedSpace(Large).RangeOfVisibility(210).DisplayAddons(Vector.<DisplayAddonDef>([new DisplayAddonDef().Clip(RoboMonkeyLeftArm).Z(-1).Ref("left").Loop(false),new DisplayAddonDef().Clip(RoboMonkeyRightArm).Z(-1).Ref("right").Loop(false)])).Weapons(Vector.<Weapon>([_loc137_]));
         this.baseTowers.push(_loc277_);
         var _loc278_:TowerDef = new TowerDef("TechnologicalTerror").Label("Technological Terror").Description("").Display(TechnologicalTerror).DetailSmall(assets.PlayUI.TechTerror).Detail(assets.detailView.TechTerror).OccupiedSpace(Large).RangeOfVisibility(210).DisplayAddons(Vector.<DisplayAddonDef>([new DisplayAddonDef().Clip(TechnoTerrorLeftArm).Z(-1).Ref("left").Loop(false),new DisplayAddonDef().Clip(TechnoTerrorRightArm).Z(-1).Ref("right").Loop(false)])).Weapons(Vector.<Weapon>([_loc138_])).Abilities(Vector.<AbilityDef>([new SpawnProjectileDef("SpawnProjectile").Projectile(_loc25_).Cooldown(60).Sound(TechnoTerrorAbility).Thumb(ActivatedAbilitySuperMonkey).Label("Bloon Annihilation Ability").Description("Destroys all bloons within short radius of tower, completely, and utterly. Does 1000 damage to MOAB-class bloons.").Effect(SuperMonkeyShockwave).AbilityClass(ninjakiwi.monkeyTown.btdModule.abilities.SpawnProjectile)]));
         this.baseTowers.push(_loc278_);
         var _loc279_:TowerDef = new TowerDef("SunAvatar").Label("Sun God").Description("").Display(assets.towers.SunAvatar).DetailSmall(assets.PlayUI.SunGod).Detail(assets.detailView.SunGod).OccupiedSpace(Large).RangeOfVisibility(140).Weapons(Vector.<Weapon>([_loc133_]));
         this.baseTowers.push(_loc279_);
         var _loc280_:TowerDef = new TowerDef("TempleOfTheMonkeyGod").Label("Temple of the Monkey God").Description("").Display(TempleOfTheMonkeyGod).OccupiedSpace(TempleSpace).DetailSmall(assets.PlayUI.Temple).Detail(assets.detailView.Temple).RangeOfVisibility(240).TargetMask(Vector.<int>([Bloon.IMMUNITY_NONE])).DisplayAddons(Vector.<DisplayAddonDef>([new DisplayAddonDef().Clip(MonkeyGodHead)])).Behavior(new ninjakiwi.monkeyTown.btdModule.towers.behavior.BehaviorDef().Initialise(new Sacrifice()).Process(new RotateAddonToTarget()).Destroy(new UnSacrifice()).RoundOver(new StopAnimation()));
         this.baseTowers.push(_loc280_);
         var _loc281_:TowerDef = new TowerDef("DartlingGun").Label("Dartling Gun").Description("Shoots darts like a machine gun, super fast but not very accurate. The Dartling Gun will shoot towards wherever your mouse is, so you control how effective it is!").Display(assets.towers.DartlingGun).Detail(assets.detailView.DartlingGun).DetailSmall(assets.PlayUI.DartlingGun).OccupiedSpace(Large).CanPriorityTarget(false).RangeOfVisibility(1250).TargetMask(Vector.<int>([Bloon.IMMUNITY_NONE])).Behavior(new ninjakiwi.monkeyTown.btdModule.towers.behavior.BehaviorDef().Process(new RotateToMouse())).Weapons(Vector.<Weapon>([_loc139_])).WeaponOffsets(Vector.<Vector2>([new Vector2(40,0)])).TargetingSystem(TowerDef.TARGETS_MOUSE).RequiresTarget(false);
         this.baseTowers.push(_loc281_);
         var _loc282_:TowerDef = new TowerDef("LaserCannon").Label("Laser Cannon").Description("").Display(assets.towers.LaserCannon).DetailSmall(assets.PlayUI.LaserCannon).Detail(assets.detailView.LaserCannon).OccupiedSpace(Large).CanPriorityTarget(false).RangeOfVisibility(1250).TargetMask(Vector.<int>([Bloon.IMMUNITY_NONE])).Behavior(new ninjakiwi.monkeyTown.btdModule.towers.behavior.BehaviorDef().Process(new RotateToMouse())).Weapons(Vector.<Weapon>([_loc140_])).WeaponOffsets(Vector.<Vector2>([new Vector2(40,0)])).TargetingSystem(TowerDef.TARGETS_MOUSE).RequiresTarget(false);
         this.baseTowers.push(_loc282_);
         var _loc283_:TowerDef = new TowerDef("RayOfDoom").Label("Ray of Doom").Description("").Display(RayOfDoom).DetailSmall(assets.PlayUI.DoomRay).Detail(assets.detailView.DoomRay).OccupiedSpace(Large).RangeOfVisibility(1250).CanPriorityTarget(false).TargetMask(Vector.<int>([Bloon.IMMUNITY_NONE])).Behavior(new ninjakiwi.monkeyTown.btdModule.towers.behavior.BehaviorDef().Process(new RayDamage().Projectile(_loc28_)).RoundStart(new DeployRay()).RoundOver(new RetractRay())).TargetingSystem(TowerDef.TARGETS_MOUSE).RequiresTarget(false);
         this.baseTowers.push(_loc283_);
         var _loc284_:TowerDef = new TowerDef("HydraRocketPods").Label("Hydra Rocket Pods").Description("").Display(assets.towers.HydraRocketPods).DetailSmall(assets.PlayUI.HydraRockets).Detail(assets.detailView.HydraRockets).OccupiedSpace(Large).RangeOfVisibility(1250).CanPriorityTarget(false).TargetMask(Vector.<int>([Bloon.IMMUNITY_NONE])).Behavior(new ninjakiwi.monkeyTown.btdModule.towers.behavior.BehaviorDef().Process(new RotateToMouse())).Weapons(Vector.<Weapon>([_loc141_])).WeaponOffsets(Vector.<Vector2>([new Vector2(40,0)])).TargetingSystem(TowerDef.TARGETS_MOUSE).RequiresTarget(false);
         this.baseTowers.push(_loc284_);
         var _loc285_:TowerDef = new TowerDef("BloonAreaDenialSystem").Label("Bloon Area Denial System").Description("").Display(assets.towers.BloonAreaDenialSystem).DetailSmall(assets.PlayUI.ADS).Detail(assets.detailView.ADS).OccupiedSpace(Large).CanPriorityTarget(false).RangeOfVisibility(1250).TargetMask(Vector.<int>([Bloon.IMMUNITY_NONE])).Behavior(new ninjakiwi.monkeyTown.btdModule.towers.behavior.BehaviorDef().Process(new RotateToMouse())).Weapons(Vector.<Weapon>([_loc142_])).Abilities(Vector.<AbilityDef>([new BloonAreaDenialSystemDef("BloonAreaDenialSystem").Projectile(_loc82_).Cooldown(30).Effect(DartlingGunAura).Thumb(ActivatedAbilityDartlingGun).Label("Rocket Storm Ability").Description("Rocket Storm shoots out a missile towards the nearest 100 bloons on screen. Ouch.").AbilityClass(ninjakiwi.monkeyTown.btdModule.abilities.BloonAreaDenialSystem)])).WeaponOffsets(Vector.<Vector2>([new Vector2(40,0)])).TargetingSystem(TowerDef.TARGETS_MOUSE).RequiresTarget(false);
         this.baseTowers.push(_loc285_);
         var _loc286_:TowerDef = new TowerDef("MortarTower").Label("Mortar Monkey").Description("Targets a specific bit of ground anywhere on the screen. Launches explosive mortar shells to that spot. Useful for placing far away from the track to make room for other towers.").Display(MortarTower).Detail(assets.detailView.MortarMonkey).DetailSmall(assets.PlayUI.MortarMonkey).OccupiedSpace(MortarMonkeySpace).RangeOfVisibility(1250).CanPriorityTarget(false).SacrificeType(Sacrifice.SACRIFICE_TYPE_EXPLOSION).Weapons(Vector.<Weapon>([_loc143_])).TargetingSystem(TowerDef.TARGETS_RETICLE).RequiresTarget(false);
         this.baseTowers.push(_loc286_);
         var _loc287_:TowerDef = new TowerDef("SignalFlare").Label("Mortar Monkey").Description("").Display(Flare).OccupiedSpace(MortarMonkeySpace).DetailSmall(assets.PlayUI.SignalFlare).Detail(assets.detailView.SignalFlare).RangeOfVisibility(1250).CanPriorityTarget(false).SacrificeType(Sacrifice.SACRIFICE_TYPE_EXPLOSION).TargetMask(Vector.<int>([Bloon.IMMUNITY_NONE])).Weapons(Vector.<Weapon>([_loc144_])).TargetingSystem(TowerDef.TARGETS_RETICLE).RequiresTarget(false);
         this.baseTowers.push(_loc287_);
         var _loc288_:TowerDef = new TowerDef("ArtilleryBattery").Label("Artillery Battery").Description("").Display(assets.towers.ArtilleryBattery).DetailSmall(assets.PlayUI.Battery).Detail(assets.detailView.Battery).OccupiedSpace(MortarMonkeySpace).RangeOfVisibility(1250).CanPriorityTarget(false).SacrificeType(Sacrifice.SACRIFICE_TYPE_EXPLOSION).TargetMask(Vector.<int>([Bloon.IMMUNITY_NONE])).Weapons(Vector.<Weapon>([_loc145_])).Abilities(Vector.<AbilityDef>([new ProjectileHitAllDef("ProjectileHitAllArtllery").Projectile(_loc72_).Cooldown(45).FullscreenEffect(MortarTowerArtillaryRain).Thumb(ActivatedAbilityMortarTower).Label("Pop And Awe Ability").Description("Bombards the screen for 5 seconds, popping every bloon 1 time per second, and immobilizes all bloons during that time. Does not affect MOAB-class bloons.").AbilityClass(ProjectileHitAll)])).TargetingSystem(TowerDef.TARGETS_RETICLE).RequiresTarget(false);
         this.baseTowers.push(_loc288_);
         var _loc289_:TowerDef = new TowerDef("BloonBuster").Label("Mortar Monkey").Description("").Display(assets.towers.BloonBuster).DetailSmall(assets.PlayUI.BloonBuster).Detail(assets.detailView.BloonBuster).OccupiedSpace(MortarMonkeySpace).RangeOfVisibility(1250).CanPriorityTarget(false).SacrificeType(Sacrifice.SACRIFICE_TYPE_EXPLOSION).Weapons(Vector.<Weapon>([_loc146_])).TargetingSystem(TowerDef.TARGETS_RETICLE).RequiresTarget(false);
         this.baseTowers.push(_loc289_);
         var _loc290_:TowerDef = new TowerDef("TheBigOne").Label("Mortar Monkey").Description("").Display(assets.towers.TheBigOne).DetailSmall(assets.PlayUI.BigOne).Detail(assets.detailView.BigOne).OccupiedSpace(MortarMonkeySpace).RangeOfVisibility(1250).CanPriorityTarget(false).SacrificeType(Sacrifice.SACRIFICE_TYPE_EXPLOSION).Weapons(Vector.<Weapon>([_loc147_])).TargetingSystem(TowerDef.TARGETS_RETICLE).RequiresTarget(false);
         this.baseTowers.push(_loc290_);
         var _loc291_:TowerDef = new TowerDef("SniperMonkey").Label("Sniper Monkey").Description("Armed with a high-tech long range rifle, pops 2 layers off of bloons with unlimited range.").Display(Sniper).DetailSmall(assets.PlayUI.SniperMonkey).Detail(assets.detailView.SniperMonkey).OccupiedSpace(Small).RangeOfVisibility(1200).Weapons(Vector.<Weapon>([_loc148_]));
         this.baseTowers.push(_loc291_);
         var _loc292_:TowerDef = new TowerDef("DeadlyPrecision").Label("Sniper Monkey").Description("").Display(ChinaShop).DetailSmall(assets.PlayUI.DeadlyPrecision).Detail(assets.detailView.DeadlyPrecision).OccupiedSpace(Small).RangeOfVisibility(1200).Weapons(Vector.<Weapon>([_loc150_]));
         this.baseTowers.push(_loc292_);
         var _loc293_:TowerDef = new TowerDef("CrippleMOAB").Label("Sniper Monkey").Description("").Display(CrippleMoab).DetailSmall(assets.PlayUI.CrippleMOAB).Detail(assets.detailView.CrippleMOAB).OccupiedSpace(Small).RangeOfVisibility(1200).Weapons(Vector.<Weapon>([_loc151_]));
         this.baseTowers.push(_loc293_);
         var _loc294_:TowerDef = new TowerDef("SemiAutomaticRifle").Label("Sniper Monkey").Description("").Display(SemiAutomatic).DetailSmall(assets.PlayUI.SemiAuto).Detail(assets.detailView.SemiAuto).OccupiedSpace(Small).RangeOfVisibility(1200).TargetMask(Vector.<int>([Bloon.IMMUNITY_NONE])).Weapons(Vector.<Weapon>([_loc149_]));
         this.baseTowers.push(_loc294_);
         var _loc295_:TowerDef = new TowerDef("SupplyDropSniper").Label("Supply Drop Sniper").Description("").Display(SniperSupply).OccupiedSpace(Small).DetailSmall(assets.PlayUI.SupplyDrop).Detail(assets.detailView.SupplyDrop).RangeOfVisibility(1200).TargetMask(Vector.<int>([Bloon.IMMUNITY_NONE])).Weapons(Vector.<Weapon>([_loc149_])).Abilities(Vector.<AbilityDef>([new SupplyDropDef("SupplyDrop").Cooldown(60).Sound(CrateDropPlaneEntrance).Effect(SniperBeacon).Thumb(ActivatedAbilitySniperMonkey).Label("Supply Drop Ability").Description("Drops a crate full of cash.").AbilityClass(ninjakiwi.monkeyTown.btdModule.abilities.SupplyDrop)]));
         this.baseTowers.push(_loc295_);
         var _loc296_:TowerDef = new TowerDef("NinjaMonkey").Label("Ninja Monkey").Description("Stealthy tower that can see Camo Bloons and throws sharp shurikens rapidly.").Display(Ninja).Detail(assets.detailView.NinjaMonkey).DetailSmall(assets.PlayUI.NinjaMonkey).OccupiedSpace(Small).RangeOfVisibility(120).TargetMask(Vector.<int>([Bloon.IMMUNITY_NONE])).Weapons(Vector.<Weapon>([_loc152_])).Behavior(new ninjakiwi.monkeyTown.btdModule.towers.behavior.BehaviorDef().Process(new RotateToTarget()));
         this.baseTowers.push(_loc296_);
         var _loc297_:TowerDef = new TowerDef("DoubleShot").Label("Ninja Monkey").Description("").Display(NinjaDouble).DetailSmall(assets.PlayUI.DoubleShurikens).Detail(assets.detailView.DoubleShurikens).OccupiedSpace(Small).RangeOfVisibility(140).TargetMask(Vector.<int>([Bloon.IMMUNITY_NONE])).Weapons(Vector.<Weapon>([_loc153_])).Behavior(new ninjakiwi.monkeyTown.btdModule.towers.behavior.BehaviorDef().Process(new RotateToTarget()));
         this.baseTowers.push(_loc297_);
         var _loc298_:TowerDef = new TowerDef("Bloonjitsu").Label("Bloonjitsu Master").Description("").DetailSmall(assets.PlayUI.Bloonjitsu).Detail(assets.detailView.Bloonjitsu).Display(assets.towers.Bloonjitsu).OccupiedSpace(Small).RangeOfVisibility(140).TargetMask(Vector.<int>([Bloon.IMMUNITY_NONE])).Weapons(Vector.<Weapon>([_loc154_])).Behavior(new ninjakiwi.monkeyTown.btdModule.towers.behavior.BehaviorDef().Process(new RotateToTarget()));
         this.baseTowers.push(_loc298_);
         var _loc299_:TowerDef = new TowerDef("FlashBomb").Label("Ninja Monkey").Description("").Display(assets.towers.FlashBomb).DetailSmall(assets.PlayUI.FlashBombs).Detail(assets.detailView.FlashBombs).OccupiedSpace(Small).RangeOfVisibility(120).TargetMask(Vector.<int>([Bloon.IMMUNITY_NONE])).Weapons(Vector.<Weapon>([_loc157_])).Behavior(new ninjakiwi.monkeyTown.btdModule.towers.behavior.BehaviorDef().Process(new RotateToTarget()));
         this.baseTowers.push(_loc299_);
         var _loc300_:TowerDef = new TowerDef("SabotageSupplyLines").Label("Ninja Saboteur").Description("").Display(assets.towers.Sabotage).DetailSmall(assets.PlayUI.Sabotage).Detail(assets.detailView.Sabotage).OccupiedSpace(Small).RangeOfVisibility(120).TargetMask(Vector.<int>([Bloon.IMMUNITY_NONE])).Weapons(Vector.<Weapon>([_loc157_])).Abilities(Vector.<AbilityDef>([new SabotageDef("Sabotage").Cooldown(60).Thumb(ActivatedAbilityNinjaMonkey).Label("Sabotage Supply Lines Ability").Description("Sabotage the bloons supply lines for 15 seconds. During the sabotage, all new bloons are crippled to half speed.").AbilityClass(ninjakiwi.monkeyTown.btdModule.abilities.Sabotage)])).Behavior(new ninjakiwi.monkeyTown.btdModule.towers.behavior.BehaviorDef().Process(new RotateToTarget()));
         this.baseTowers.push(_loc300_);
         var _loc301_:TowerDef = new TowerDef("ExplodingPineapple").Label("Exploding Pineapple").Description("This explosive fruit packs a real punch. When placed will explode violently after 3 seconds. Useful for destroying those bloons that require explosives to pop.").Display(PineappleBomb).OccupiedSpace(Small).RangeOfVisibility(100).Detail(Pineapple).CanPlaceOnTrack(true).Behavior(new ninjakiwi.monkeyTown.btdModule.towers.behavior.BehaviorDef().RoundStart(new SwapForProjectile().Projectile(_loc84_).Lifespan(3)));
         this.baseTowers.push(_loc301_);
         var _loc302_:TowerDef = new TowerDef("Engineer").Label("Monkey Engineer").Description("Good at building stuff, the Engineer shoots bloons with a powerful nail gun, and has many useful upgrades that create traps, sentries and other enhancements.").Display(EngineerMonkey).Detail(assets.detailView.Engineer).DetailSmall(assets.PlayUI.Engineer).OccupiedSpace(Small).RangeOfVisibility(130).Weapons(Vector.<Weapon>([_loc121_])).WeaponOffsets(Vector.<Vector2>([new Vector2(10,7)]));
         this.baseTowers.push(_loc302_);
         var _loc303_:TowerDef = new TowerDef("CleansingFoam").Label("Monkey Engineer").Description("").Display(EngineerFoamGunner).Detail(assets.detailView.CleansingFoam).DetailSmall(assets.PlayUI.CleansingFoam).OccupiedSpace(Small).RangeOfVisibility(130).Weapons(Vector.<Weapon>([_loc121_,_loc130_,_loc126_])).DisplayAddons(Vector.<DisplayAddonDef>([new DisplayAddonDef().Clip(EngineerNailGun).Z(-1).Loop(false),new DisplayAddonDef().Clip(EngineerFoamGun).Z(-1).Loop(false)])).WeaponOffsets(Vector.<Vector2>([new Vector2(10,7),new Vector2(10,-7)]));
         this.baseTowers.push(_loc303_);
         var _loc304_:TowerDef = new TowerDef("BloonTrap").Label("Bloon Trap").Description("").Display(EngineerBloonTrap).Detail(assets.detailView.BloonTrap).DetailSmall(assets.PlayUI.BloonTrap).OccupiedSpace(Small).RangeOfVisibility(130).Weapons(Vector.<Weapon>([_loc121_,_loc130_,_loc126_])).Behavior(new ninjakiwi.monkeyTown.btdModule.towers.behavior.BehaviorDef().Process(new CreateBloonTrap())).DisplayAddons(Vector.<DisplayAddonDef>([new DisplayAddonDef().Clip(EngineerNailGun).Z(-1).Loop(false),new DisplayAddonDef().Clip(EngineerFoamGun).Z(-1).Loop(false)])).WeaponOffsets(Vector.<Vector2>([new Vector2(10,7),new Vector2(10,-7)]));
         this.baseTowers.push(_loc304_);
         var _loc305_:TowerDef = new TowerDef("Sprockets").Label("Monkey Engineer").Description("Good at building stuff, the Engineer shoots bloons with a powerful nail gun, and has many useful upgrades that create traps, sentries and other enhancements.").Display(EngineerSprockets).Detail(assets.detailView.Sprockets).DetailSmall(assets.PlayUI.Sprockets).OccupiedSpace(Small).RangeOfVisibility(195).Weapons(Vector.<Weapon>([_loc122_])).WeaponOffsets(Vector.<Vector2>([new Vector2(10,7),new Vector2(10,-7)]));
         this.baseTowers.push(_loc305_);
         var _loc306_:TowerDef = new TowerDef("Overclock").Label("Monkey Engineer").Description("Good at building stuff, the Engineer shoots bloons with a powerful nail gun, and has many useful upgrades that create traps, sentries and other enhancements.").Display(EngineerOverclock).Detail(assets.detailView.Overclock).DetailSmall(assets.PlayUI.Overclock).OccupiedSpace(Small).RangeOfVisibility(195).Weapons(Vector.<Weapon>([_loc122_])).Abilities(Vector.<AbilityDef>([new OverclockPickDef("OverclockPick").Cooldown(45).Thumb(ActivatedAbilityMonkeyEngineer).Label("Overclock").Description("Target tower becomes super powered for 60 seconds.").AbilityClass(OverclockPick)])).WeaponOffsets(Vector.<Vector2>([new Vector2(10,12),new Vector2(10,-12)]));
         this.baseTowers.push(_loc306_);
         var _loc307_:TowerDef = new TowerDef("Sentry").Label("Sentry").Description("").Display(EngineerSentry).Detail(assets.detailView.SpikeFactory).DetailSmall(Sentry).OccupiedSpace(Small).RangeOfVisibility(130).Weapons(Vector.<Weapon>([_loc123_])).DisplayAddons(Vector.<DisplayAddonDef>([new DisplayAddonDef().Clip(EngineerSentryFeet).Z(-1).Loop(false).Rotate(false)])).WeaponOffsets(Vector.<Vector2>([new Vector2(17)])).Behavior(new ninjakiwi.monkeyTown.btdModule.towers.behavior.BehaviorDef().Destroy(new SentryDestroy()));
         this.baseTowers.push(_loc307_);
         var _loc308_:TowerDef = new TowerDef("SentrySprockets").Label("SentrySprockets").Description("").Display(EngineerSentry).Detail(assets.detailView.SpikeFactory).DetailSmall(Sentry).OccupiedSpace(Small).RangeOfVisibility(130).Weapons(Vector.<Weapon>([_loc124_])).DisplayAddons(Vector.<DisplayAddonDef>([new DisplayAddonDef().Clip(EngineerSentryFeet).Z(-1).Loop(false).Rotate(false)])).WeaponOffsets(Vector.<Vector2>([new Vector2(17)])).Behavior(new ninjakiwi.monkeyTown.btdModule.towers.behavior.BehaviorDef().Destroy(new SentryDestroy()));
         this.baseTowers.push(_loc308_);
         var _loc309_:TowerDef = new TowerDef("RoadSpikes").Label("Road Spikes").Description("Place these on the track to pop bloons. Each pack of spikes can pop 11 bloons before being used up. Use these to get bloons that escape past your towers.").Display(assets.projectile.RoadSpikes).OccupiedSpace(Small).RangeOfVisibility(20).DetailSmall(assets.projectile.RoadSpikes).CanPlaceOnTrack(true).Detail(assets.detailView.RoadSpikes).Behavior(new ninjakiwi.monkeyTown.btdModule.towers.behavior.BehaviorDef().RoundStart(new SwapForProjectile().Projectile(_loc89_).Lifespan(999999)));
         this.baseTowers.push(_loc309_);
         var _loc310_:TowerDef = new TowerDef("SpikeFactory").Label("Spike Factory").Description("Generates piles of road spikes on bits of nearby track. Each pile can pop 5 bloons, and unused spikes disappear at the end of each round.").Display(assets.towers.SpikeFactory).Detail(assets.detailView.SpikeFactory).DetailSmall(assets.PlayUI.SpikeFactory).OccupiedSpace(Large).RangeOfVisibility(105).TargetAll(true).CanPriorityTarget(false).TargetMask(Vector.<int>([Bloon.IMMUNITY_NONE])).Weapons(Vector.<Weapon>([_loc217_])).RequiresTarget(false);
         this.baseTowers.push(_loc310_);
         var _loc311_:TowerDef = new TowerDef("SpikedBallFactory").Label("Spiked Ball Factory").Description("").Display(assets.towers.SpikeBall).Detail(assets.detailView.SpikeBallFactory).DetailSmall(assets.PlayUI.SpikeBallFactory).OccupiedSpace(Large).RangeOfVisibility(105).TargetAll(true).CanPriorityTarget(false).TargetMask(Vector.<int>([Bloon.IMMUNITY_NONE])).Weapons(Vector.<Weapon>([_loc219_])).RequiresTarget(false);
         this.baseTowers.push(_loc311_);
         var _loc312_:TowerDef = new TowerDef("SpikedMines").Label("Spiked Mines").Description("").Display(MineSpike).Detail(assets.detailView.SpikeMineFactory).DetailSmall(assets.PlayUI.SpikeMineFactory).OccupiedSpace(Large).RangeOfVisibility(105).TargetAll(true).CanPriorityTarget(false).TargetMask(Vector.<int>([Bloon.IMMUNITY_NONE])).Weapons(Vector.<Weapon>([_loc220_])).RequiresTarget(false);
         this.baseTowers.push(_loc312_);
         var _loc313_:TowerDef = new TowerDef("MoabShrederSpikes").Label("MOAB-SHREDR Spikes").Description("").Display(MoabShreder).Detail(assets.detailView.MOABShredder).DetailSmall(MAOBShredder).OccupiedSpace(Large).RangeOfVisibility(105).TargetAll(true).CanPriorityTarget(false).TargetMask(Vector.<int>([Bloon.IMMUNITY_NONE])).Weapons(Vector.<Weapon>([_loc218_])).RequiresTarget(false);
         this.baseTowers.push(_loc313_);
         var _loc314_:TowerDef = new TowerDef("SpikeStorm").Label("Spike Storm").Description("").Display(assets.towers.SpikeStorm).Detail(assets.detailView.SpikeStorm).DetailSmall(assets.PlayUI.SpikeStorm).OccupiedSpace(Large).RangeOfVisibility(105).TargetAll(true).CanPriorityTarget(false).TargetMask(Vector.<int>([Bloon.IMMUNITY_NONE])).Weapons(Vector.<Weapon>([_loc218_])).Abilities(Vector.<AbilityDef>([new SpikeStormDef("SpikeStorm").Cooldown(40).Sound(assets.sound.SpikeStorm).Effect(SpikeFactoryAura).Thumb(ActivatedAbilitySpikeFactory).Label("Spike Storm").Description("Lays down a thick carpet of Spikes over the whole track").AbilityClass(ninjakiwi.monkeyTown.btdModule.abilities.SpikeStorm)])).RequiresTarget(false);
         this.baseTowers.push(_loc314_);
         var _loc315_:UpgradePathDef = new UpgradePathDef().Base(_loc221_).Upgrades([[new UpgradeDef().Label("Long Range Darts").Description("Makes the Dart Monkey shoot further than normal.").XpGate(30).Thumb(assets.upgrades.LongRangeDarts).Cost(90).Add(new AddDef().RangeOfVisibility(25).Display(Vector.<TowerDisplayMod>([new TowerDisplayMod().UseFor(assets.towers.DartMonkey).Display(DartLongSharp)])).Detail(assets.detailView.LongRangeDarts).DetailSmall(assets.PlayUI.LongRangeDarts)),new UpgradeDef().Label("Enhanced Eyesight").Description("Increase attack range even further and allows Dart Monkey to shoot Camo Bloons.").XpGate(460).Thumb(VeryLongRange).Cost(120).Add(new AddDef().RemoveFromTargetMask(Vector.<int>([Bloon.IMMUNITY_NO_DETECTION])).WeaponMod(new WeaponModDef().ProjectileMod(new ProjectileModDef().RemoveFromEffectMask(Vector.<int>([Bloon.IMMUNITY_NO_DETECTION])))).Display(Vector.<TowerDisplayMod>([new TowerDisplayMod().UseFor(DartLongSharp).Display(DartLongerRazor)])).RangeOfVisibility(25).Detail(assets.detailView.EnhancedVision).DetailSmall(assets.PlayUI.EnhancedVision)),new UpgradeDef().Label("Spike-o-pult").Description("Converts the Dart Monkey into a Spike-o-pult, a powerful tower that hurls a large spiked ball instead of darts. Good range, but slower attack speed. Each ball can pop 18 bloons.").XpGate(1890).Thumb(assets.upgrades.SpikeOPult).Cost(500).Assign(_loc222_),new UpgradeDef().Label("Juggernaut").Description("Hurls a giant unstoppable killer spiked ball that can pop lead bloons and excels at crushing ceramic bloons.").XpGate(6220).RankGate(19).Thumb(assets.upgrades.Juggernaut).Cost(1500).Assign(_loc223_)],[new UpgradeDef().Label("Sharp Shots").Description("Can pop 1 extra bloon per shot.").Cost(140).XpGate(75).Thumb(assets.upgrades.SharpDarts).Add(new AddDef().WeaponMod(new WeaponModDef().ProjectileMod(new ProjectileModDef().Pierce(1))).Display(Vector.<TowerDisplayMod>([new TowerDisplayMod().UseFor(assets.towers.DartMonkey).Display(DartLongSharp)])).Detail(assets.detailView.SharpDarts).DetailSmall(assets.PlayUI.SharpDarts)),new UpgradeDef().Label("Razor Sharp Shots").Description("Can pop 2 extra bloons per shot.").Cost(170).XpGate(580).Thumb(assets.upgrades.RazorSharpDarts).Add(new AddDef().Display(Vector.<TowerDisplayMod>([new TowerDisplayMod().UseFor(DartLongSharp).Display(DartLongerRazor)])).WeaponMod(new WeaponModDef().ProjectileMod(new ProjectileModDef().Pierce(2))).Detail(assets.detailView.RazorSharpDarts).DetailSmall(assets.PlayUI.RazorSharpDarts)),new UpgradeDef().Label("Triple Darts").Description("Throws 3 darts at a time instead of 1.").XpGate(3250).Thumb(assets.upgrades.TripleDarts).Cost(330).Assign(_loc224_),new UpgradeDef().Label("Super Monkey Fan Club").Description("Super Monkey Fan Club Ability: Converts up to 10 nearby dart monkeys into Super Monkeys for 15 seconds").XpGate(9690).RankGate(19).Thumb(BunchoMonkeys).Cost(8000).Assign(_loc225_)]]);
         this.upgrades.push(_loc315_);
         var _loc316_:UpgradePathDef = new UpgradePathDef().Base(_loc310_).Upgrades([[new UpgradeDef().Label("Bigger Stacks").Description("Generates larger piles of spikes per shot.").XpGate(500).Thumb(assets.upgrades.BiggerStacks).Cost(700).Add(new AddDef().WeaponMod(new WeaponModDef().ProjectileMod(new ProjectileModDef().Pierce(5))).Display(Vector.<TowerDisplayMod>([new TowerDisplayMod().UseFor(assets.towers.SpikeFactory).Display(assets.towers.BiggerStacks),new TowerDisplayMod().UseFor(assets.towers.FasterProduction).Display(FasterBiggerStacks)])).Detail(assets.detailView.BiggerStacks).DetailSmall(assets.PlayUI.BiggerStacks)),new UpgradeDef().Label("White Hot Spikes").Description("Cuts through lead like a hot spike through... lead.").Cost(900).XpGate(1500).Thumb(assets.upgrades.WhiteHotSpikes).Add(new AddDef().WeaponMod(new WeaponModDef().ProjectileMod(new ProjectileModDef().DamageEffectMod(new DamageEffectModDef().CanBreakIce(true).RemoveFromCantBreak(Vector.<int>([Bloon.LEAD,Bloon.DDT,Bloon.BOSS_DREADBLOON]))).Display(Vector.<ProjectileDisplayMod>([new ProjectileDisplayMod().UseFor(SpikeFactorySpikes).Display(assets.projectile.WhiteHotSpikes)])))).Display(Vector.<TowerDisplayMod>([new TowerDisplayMod().UseFor(assets.towers.BiggerStacks).Display(assets.towers.WhiteHotTacks),new TowerDisplayMod().UseFor(EvenFasterProduction).Display(FasterWhiteHotSpikes),new TowerDisplayMod().UseFor(MoabShreder).Display(WhiteHotMoabShreder),new TowerDisplayMod().UseFor(assets.towers.SpikeStorm).Display(WhiteHotSpikeStorm)])).Detail(assets.detailView.WhiteHotTacks).DetailSmall(assets.PlayUI.WhiteHotTacks)),new UpgradeDef().Label("Spiked Ball Factory").Description("Modified to produce heavy but viciously sharp spiked balls instead of regular spikes. Do extra damage to ceramic bloons.").XpGate(10000).Thumb(SpikeBalls).Cost(2400).Assign(_loc311_),new UpgradeDef().Label("Spiked Mines").Description("Rigged with heavy explosives, the spiked balls are set to go off when they lose all their spikes.").XpGate(40000).RankGate(45).Thumb(SpikeMines).Cost(14000).Assign(_loc312_)],[new UpgradeDef().Label("Faster Production").Description("Increases the rate of spike production.").Cost(800).XpGate(1000).Thumb(FastProduction).Add(new AddDef().WeaponMod(new WeaponModDef().ReloadTime(0.624).ReloadTimeAsScale(true)).Display(Vector.<TowerDisplayMod>([new TowerDisplayMod().UseFor(assets.towers.SpikeFactory).Display(assets.towers.FasterProduction),new TowerDisplayMod().UseFor(assets.towers.BiggerStacks).Display(FasterBiggerStacks)])).Detail(assets.detailView.FastProductionSpikes).DetailSmall(assets.PlayUI.FastProductionSpikes)),new UpgradeDef().Label("Even Faster Production").Description("By adding sprockets, dongles and widgets, the rate of spike production increases even more.").Cost(1250).XpGate(3500).Thumb(assets.upgrades.FasterProduction).Add(new AddDef().WeaponMod(new WeaponModDef().ReloadTime(0.601).ReloadTimeAsScale(true)).Display(Vector.<TowerDisplayMod>([new TowerDisplayMod().UseFor(assets.towers.FasterProduction).Display(EvenFasterProduction),new TowerDisplayMod().UseFor(assets.towers.WhiteHotTacks).Display(FasterWhiteHotSpikes),new TowerDisplayMod().UseFor(assets.towers.SpikeBall).Display(FasterSpikeBall),new TowerDisplayMod().UseFor(MineSpike).Display(FasterMineSpike)])).Detail(assets.detailView.FasterProductionSpikes).DetailSmall(assets.PlayUI.FasterProductionSpikes)),new UpgradeDef().Label("MOAB-SHREDR Spikes").Description("Super-Hard-Rending-Engine-Driven-Razors are specially engineered to really hurt MOAB-class bloons.").XpGate(17000).Thumb(assets.upgrades.MOABShredder).Cost(3000).Assign(_loc313_),new UpgradeDef().Label("Spike Storm").Description("Lays down a thick carpet of spikes over the whole track.").XpGate(70000).RankGate(45).Thumb(assets.upgrades.SpikeStorm).Cost(6500).Assign(_loc314_)]]);
         this.upgrades.push(_loc316_);
         var _loc317_:UpgradePathDef = new UpgradePathDef().Base(_loc226_).Upgrades([[new UpgradeDef().Label("Faster Shooting").Description("Shoots tacks faster.").Thumb(FasterShoot).Cost(210).XpGate(85).Add(new AddDef().Display(Vector.<TowerDisplayMod>([new TowerDisplayMod().UseFor(assets.towers.TackTower).Display(TackTowerFaster)])).WeaponMod(new WeaponModDef().ReloadTime(-0.43)).Detail(assets.detailView.FasterTack).DetailSmall(assets.PlayUI.FasterTack)),new UpgradeDef().Label("Even Faster Shooting").Description("Shoots tacks even faster!").Thumb(EvenFaster).Cost(300).XpGate(770).Add(new AddDef().Display(Vector.<TowerDisplayMod>([new TowerDisplayMod().UseFor(TackTowerFaster).Display(TackTowerEvenFaster)])).WeaponMod(new WeaponModDef().ReloadTime(-0.57)).Detail(assets.detailView.EvenFasterTack).DetailSmall(assets.PlayUI.EvenFasterTack)),new UpgradeDef().Label("Tack Sprayer").Description("Sprays out 16 tacks per volley instead of the usual 8.").Thumb(assets.upgrades.TackSprayer).Cost(500).XpGate(2842).Assign(_loc227_),new UpgradeDef().Label("Ring of Fire").Thumb(RingofFire).Description("Upgrade to a fast firing burst tower that shoots a deadly ring of flame instead of tacks.").Cost(2500).XpGate(9030).RankGate(20).Assign(_loc228_)],[new UpgradeDef().Label("Extra Range Tacks").Description("Tacks fly out further than normal.").Thumb(ExtraRange).Cost(100).XpGate(305).Add(new AddDef().Display(Vector.<TowerDisplayMod>([new TowerDisplayMod().UseFor(assets.towers.TackTower).Display(TackTowerFaster)])).RangeOfVisibility(10).WeaponMod(new WeaponModDef().Range(10).Power(70)).Detail(ExtraRangeTack).DetailSmall(ExtraRangeTacks)),new UpgradeDef().Label("Super Range Tacks").Description("Tacks go much further than normal.").Thumb(assets.upgrades.SuperRange).Cost(225).XpGate(1260).Add(new AddDef().Display(Vector.<TowerDisplayMod>([new TowerDisplayMod().UseFor(TackTowerFaster).Display(TackTowerEvenFaster)])).RangeOfVisibility(8).WeaponMod(new WeaponModDef().Range(10).Power(70)).Detail(assets.detailView.SuperRangeTacks).DetailSmall(assets.PlayUI.SuperRangeTacks)),new UpgradeDef().Label("Blade Shooter").Description("Converts tower into a blade shooter that shoots out razor sharp blades that are harder for bloons to avoid.").Thumb(assets.upgrades.BladeShooter).Cost(680).XpGate(4785).Assign(_loc229_),new UpgradeDef().Label("Blade Maelstrom").Description("Blade Maelstrom Ability: covers the area in an unstoppable storm of blades.").Thumb(assets.upgrades.BladeMaelstrom).Cost(2700).XpGate(14625).RankGate(20).Assign(_loc230_)]]);
         this.upgrades.push(_loc317_);
         var _loc318_:UpgradePathDef = new UpgradePathDef().Base(_loc231_).Upgrades([[new UpgradeDef().Label("Glue Soak").Description("Glue soaks through all layers of bloons.").Cost(200).XpGate(75).Thumb(assets.upgrades.GlueSoak).Add(new AddDef().Display(Vector.<TowerDisplayMod>([new TowerDisplayMod().UseFor(GlueGunner).Display(GlueStickySoak)])).WeaponMod(new WeaponModDef().ProjectileMod(new ProjectileModDef().GlueEffectMod(new GlueEffectModDef().Soak(true)))).Detail(assets.detailView.GlueSoak).DetailSmall(assets.PlayUI.GlueSoak)),new UpgradeDef().Label("Corrosive Glue").Description("Makes the glue become corrosive, popping bloons every few seconds while glued.").Cost(300).XpGate(705).Thumb(assets.upgrades.CorrosiveGlue).Add(new AddDef().Display(Vector.<TowerDisplayMod>([new TowerDisplayMod().UseFor(GlueStickySoak).Display(assets.towers.CorrosiveGlue)])).WeaponMod(new WeaponModDef().ProjectileMod(new ProjectileModDef().GlueEffectMod(new GlueEffectModDef().Soak(true).CorosionInterval(2.29)))).Detail(assets.detailView.CorrosiveGlue).DetailSmall(assets.PlayUI.CorrosiveGlue)),new UpgradeDef().Label("Bloon Dissolver").Description("Glue contains an extreme solvent that melts bloons. While glued, bloons will pop twice every second.").Cost(3300).XpGate(3095).Thumb(assets.upgrades.BloonDissolver).Assign(_loc234_),new UpgradeDef().Label("Bloon Liquefier").Description("Pops bloons once before glueing. Contains a super strong dissolving glue that pops bloons ten times every second!").Cost(12500).XpGate(13335).RankGate(27).Thumb(assets.upgrades.BloonLiquefier).Assign(_loc235_)],[new UpgradeDef().Label("Stickier Glue").Description("Makes glue effect last much longer.").Cost(120).XpGate(275).Thumb(assets.upgrades.StickierGlue).Add(new AddDef().Display(Vector.<TowerDisplayMod>([new TowerDisplayMod().UseFor(GlueGunner).Display(GlueStickySoak)])).WeaponMod(new WeaponModDef().ProjectileMod(new ProjectileModDef().GlueEffectMod(new GlueEffectModDef().Lifespan(11.43)))).Detail(assets.detailView.StickierGlue).DetailSmall(assets.PlayUI.StickierGlue)),new UpgradeDef().Label("Glue Splatter").Description("Instead of glueing 1 bloon at a time, splatters 6 bloons at a time.").Cost(2200).XpGate(1165).Thumb(assets.upgrades.GlueSplatter).Add(new AddDef().Display(Vector.<TowerDisplayMod>([new TowerDisplayMod().UseFor(GlueStickySoak).Display(assets.towers.GlueSplatter)])).WeaponMod(new WeaponModDef().ProjectileMod(new ProjectileModDef().BehaviorMod(new ProjectileBehaviorModDef().AddCollision(new CollisionSpawnProjectile().Projectile(_loc46_))))).Detail(assets.detailView.GlueSplatter).DetailSmall(assets.PlayUI.GlueSplatter)),new UpgradeDef().Label("Glue Hose").Description("Shoots glue more than 3x as fast!").Cost(3250).XpGate(6175).Thumb(assets.upgrades.GlueHose).Assign(_loc232_),new UpgradeDef().Label("Glue Striker").Description("Glue Strike Ability: glues all bloons on the screen.").Cost(5500).XpGate(22445).RankGate(27).Thumb(assets.upgrades.GlueStriker).Assign(_loc233_)]]);
         this.upgrades.push(_loc318_);
         var _loc319_:UpgradePathDef = new UpgradePathDef().Base(_loc236_).Upgrades([[new UpgradeDef().Label("Enhanced Freeze").Description("This enhanced Ice Tower has a larger freeze area and freezes bloons for longer.").Cost(225).XpGate(90).Thumb(assets.upgrades.EnhancedFreeze).Add(new AddDef().Display(Vector.<TowerDisplayMod>([new TowerDisplayMod().UseFor(IceTower).Display(PermaFreeze)])).RangeOfVisibility(15).WeaponMod(new WeaponModDef().Range(15).ProjectileMod(new ProjectileModDef().IceEffectMod(new IceEffectModDef().Lifespan(0.57)).Display(Vector.<ProjectileDisplayMod>([new ProjectileDisplayMod().UseFor(IceBurst).Display(IceBurstMedium)])))).Detail(assets.detailView.EnhancedFreeze).DetailSmall(assets.PlayUI.EnhancedFreeze)),new UpgradeDef().Label("Snap Freeze").Description("The tower freezes so fast the bloons pop once before freezing.").Cost(400).XpGate(820).Thumb(SanpFreeze).Add(new AddDef().Display(Vector.<TowerDisplayMod>([new TowerDisplayMod().UseFor(PermaFreeze).Display(assets.towers.SnapFreeze)])).WeaponMod(new WeaponModDef().ProjectileMod(new ProjectileModDef().DamageEffectMod(new DamageEffectModDef().Damage(1)).IceEffectMod(new IceEffectModDef().FreezeLayers(1)))).Detail(assets.detailView.SnapFreeze).DetailSmall(assets.PlayUI.SnapFreeze)),new UpgradeDef().Label("Arctic Wind").Description("Super cold aura that slows all bloons that come near the tower. In addition the regular freeze effect of this tower has much larger area.").Cost(6500).XpGate(3050).Thumb(assets.upgrades.ArcticWind).Assign(_loc239_),new UpgradeDef().Label("Viral Frost").Description("Bloons are frozen so cold that they freeze other bloons that come in contact with them, spreading the freeze like a virus.").Cost(6000).XpGate(11630).RankGate(26).Thumb(assets.upgrades.ViralFrost).Assign(_loc238_)],[new UpgradeDef().Label("Permafrost").Description("Makes the bloons so cold that they move slowly even after thawing out.").Cost(100).XpGate(325).Thumb(assets.upgrades.Permafrost).Add(new AddDef().Display(Vector.<TowerDisplayMod>([new TowerDisplayMod().UseFor(IceTower).Display(PermaFreeze)])).WeaponMod(new WeaponModDef().ProjectileMod(new ProjectileModDef().IceEffectMod(new IceEffectModDef().Permafrost(-0.5)))).Detail(assets.detailView.Permafrost).DetailSmall(PermaFrost)),new UpgradeDef().Label("Deep Freeze").Description("Freezes 2 layers of bloons instead of 1.").Cost(350).XpGate(1340).Thumb(assets.upgrades.DeepFreeze).Add(new AddDef().Display(Vector.<TowerDisplayMod>([new TowerDisplayMod().UseFor(PermaFreeze).Display(assets.towers.SnapFreeze)])).WeaponMod(new WeaponModDef().ProjectileMod(new ProjectileModDef().IceEffectMod(new IceEffectModDef().FreezeLayers(1)))).Detail(assets.detailView.DeepFreeze).DetailSmall(assets.PlayUI.DeepFreeze)),new UpgradeDef().Label("Ice Shards").Description("Creates razor sharp pieces of ice on frozen bloons, that when popped, fly out and pop more nearby bloons.").Thumb(assets.upgrades.IceShards).XpGate(5160).Thumb(assets.upgrades.IceShards).Cost(2000).Assign(_loc237_),new UpgradeDef().Label("Absolute Zero").Description("Absolute Zero Ability: freezes the entire screen of bloons for 4 seconds. Does not affect MOAB-class bloons.").Cost(2000).XpGate(20850).RankGate(26).Thumb(assets.upgrades.AbsoluteZero).Assign(_loc240_)]]);
         this.upgrades.push(_loc319_);
         var _loc320_:UpgradePathDef = new UpgradePathDef().Base(_loc241_).Upgrades([[new UpgradeDef().Label("Extra Range").Description("Gives tower longer attack range.").Cost(200).XpGate(150).Thumb(BombTowerExtraRange).Add(new AddDef().Display(Vector.<TowerDisplayMod>([new TowerDisplayMod().UseFor(assets.towers.BombTower).Display(BombTowerBiggerRange)])).RangeOfVisibility(20).Detail(assets.detailView.BombRange).DetailSmall(assets.PlayUI.BombRange)),new UpgradeDef().Label("Frag Bombs").Description("Each explosion throws out 8 sharp fragments that pop even more bloons.").Cost(300).XpGate(1300).Thumb(assets.upgrades.FragBombs).Add(new AddDef().Display(Vector.<TowerDisplayMod>([new TowerDisplayMod().UseFor(BombTowerBiggerRange).Display(assets.towers.FragBombs)])).RangeOfVisibility(10).WeaponMod(new WeaponModDef().ProjectileMod(new ProjectileModDef().BehaviorMod(new ProjectileBehaviorModDef().AddCollision(new SpawnSpreadCollision().Projectile(_loc42_))))).Detail(assets.detailView.FragBombs).DetailSmall(assets.PlayUI.FragBombs)),new UpgradeDef().Label("Cluster Bombs").Description("Throws out secondary bombs instead of frags - causing widespread explosive poppage.").Cost(800).XpGate(5100).Thumb(assets.upgrades.ClusterBombs).Assign(_loc242_),new UpgradeDef().Label("Bloon Impact").Description("Impacts from this tower become so violent, bloons become stunned for a short time when they are hit.").Cost(4000).XpGate(15450).RankGate(24).Thumb(assets.upgrades.BloonImpact).Assign(_loc243_)],[new UpgradeDef().Id("BiggerBombs").Label("Bigger Bombs").Description("Shoots much larger bombs than normal, they have a larger blast area and more popping power.").Cost(400).XpGate(500).Thumb(assets.upgrades.BiggerBombs).Add(new AddDef().Display(Vector.<TowerDisplayMod>([new TowerDisplayMod().UseFor(assets.towers.BombTower).Display(BombTowerBiggerRange)])).WeaponMod(new WeaponModDef().ProjectileMod(new ProjectileModDef().Radius(2).Pierce(10).Display(Vector.<ProjectileDisplayMod>([new ProjectileDisplayMod().UseFor(Bomb).Display(BigBomb),new ProjectileDisplayMod().UseFor(MediumExplosion).Display(LargeExplosion)])))).Detail(assets.detailView.BiggerBombs).DetailSmall(assets.PlayUI.BiggerBombs)),new UpgradeDef().Label("Missile Launcher").Description("Converts the tower into a missile launcher - the missiles have higher velocity, longer range, more popping power, and faster shooting.").Thumb(assets.upgrades.MissileLauncher).Cost(400).XpGate(2200).Thumb(assets.upgrades.MissileLauncher).Add(new AddDef().Display(Vector.<TowerDisplayMod>([new TowerDisplayMod().UseFor(BombTowerBiggerRange).Display(assets.towers.MissileLauncher),new TowerDisplayMod().UseFor(assets.towers.FragBombs).Display(assets.towers.MissileLauncher),new TowerDisplayMod().UseFor(assets.towers.ClusterBombs).Display(ClusterMissile),new TowerDisplayMod().UseFor(assets.towers.BloonImpact).Display(MissileBuster)])).RangeOfVisibility(5).WeaponMod(new WeaponModDef().Power(245).ReloadTime(-0.23).ProjectileMod(new ProjectileModDef().Pierce(5).Display(Vector.<ProjectileDisplayMod>([new ProjectileDisplayMod().UseFor(BigBomb).Display(Missile)])))).Detail(assets.detailView.MissileLauncher).DetailSmall(assets.PlayUI.MissileLauncher)),new UpgradeDef().Label("MOAB Mauler").Description("MOAB maulers are special missiles that wreak havoc on MOAB-class bloons, inflicting x10 damage.").Thumb(assets.upgrades.MOABMauler).Cost(900).XpGate(8400).Thumb(assets.upgrades.MOABMauler).Assign(_loc244_),new UpgradeDef().Label("MOAB Assassin").Description("MOAB Assassin Ability: super deadly missile seeks the nearest MOAB-class bloon and destroys it instantly. Does 1000 damage to ZOMG bloons instead of destroying them.").Cost(3200).XpGate(24100).RankGate(24).Thumb(assets.upgrades.MOABAssassin).Assign(_loc245_)]]);
         this.upgrades.push(_loc320_);
         var _loc321_:UpgradePathDef = new UpgradePathDef().Base(_loc246_).Upgrades([[new UpgradeDef().Label("Multi-Target").Description("Boomerangs can now pop 7 bloons each.").Thumb(assets.upgrades.BoomerangThrower).Cost(250).XpGate(100).Add(new AddDef().Display(Vector.<TowerDisplayMod>([new TowerDisplayMod().UseFor(assets.towers.BoomerangThrower).Display(BoomerangMulti),new TowerDisplayMod().UseFor(assets.towers.SonicBoom).Display(SonicBoomMulti)])).WeaponMod(new WeaponModDef().ProjectileMod(new ProjectileModDef().Pierce(4))).Detail(assets.detailView.MultiBoomerang).DetailSmall(assets.PlayUI.MultiBoomerang)),new UpgradeDef().Label("Glaive Thrower").Description("Throws glaives instead of boomerangs - they\'re sharper, faster, and more poptastic.").Thumb(assets.upgrades.GlaiveThrower).Cost(280).XpGate(905).Add(new AddDef().Display(Vector.<TowerDisplayMod>([new TowerDisplayMod().UseFor(BoomerangMulti).Display(assets.towers.GlaiveThrower),new TowerDisplayMod().UseFor(SonicBoomMulti).Display(assets.towers.GlaiveThrower),new TowerDisplayMod().UseFor(assets.towers.SonicBoom).Display(SonicGlaiveThrower),new TowerDisplayMod().UseFor(assets.towers.RedHotRangs).Display(HotGlaiveThrower),new TowerDisplayMod().UseFor(assets.towers.BionicBoomer).Display(BionicGlaiver),new TowerDisplayMod().UseFor(assets.towers.TurboCharge).Display(TurboGlaiver)])).WeaponMod(new WeaponModDef().ReloadTime(-0.08).ProjectileMod(new ProjectileModDef().Pierce(5).Radius(3).Display(Vector.<ProjectileDisplayMod>([new ProjectileDisplayMod().UseFor(Boomerang).Display(Glaive),new ProjectileDisplayMod().UseFor(HotRang).Display(HotGlaive)])))).Detail(assets.detailView.GlaiveThrower).DetailSmall(assets.PlayUI.GlaiveThrower)),new UpgradeDef().Label("Glaive Riccochet").Description("The glaives from this tower will automatically bounce from bloon to bloon as long as there is one close by.").Thumb(GlaiveRiccochet).Cost(1400).XpGate(3260).Assign(_loc249_),new UpgradeDef().Label("Glaive Lord").Description("Creates two permanent glaives that orbit round the tower, shredding almost anything that touches them. Glaive Lord can attack Camo Bloons.").Thumb(assets.upgrades.GlaiveLord).Cost(9000).XpGate(10165).RankGate(22).Assign(_loc250_)],[new UpgradeDef().Label("Sonic Boom").Description("").Cost(100).XpGate(360).Thumb(assets.upgrades.SonicBoom).Description("Sonic boomerangs can smash through frozen bloons.").Add(new AddDef().Display(Vector.<TowerDisplayMod>([new TowerDisplayMod().UseFor(assets.towers.BoomerangThrower).Display(assets.towers.SonicBoom),new TowerDisplayMod().UseFor(BoomerangMulti).Display(SonicBoomMulti),new TowerDisplayMod().UseFor(assets.towers.GlaiveThrower).Display(SonicGlaiveThrower)])).WeaponMod(new WeaponModDef().ProjectileMod(new ProjectileModDef().DamageEffectMod(new DamageEffectModDef().CanBreakIce(true)))).Detail(assets.detailView.SonicBoom).DetailSmall(assets.PlayUI.SonicBoom)),new UpgradeDef().Label("Red Hot \'Rangs").Description("Red hot boomerangs can melt through lead bloons.").Thumb(assets.upgrades.RedHotRangs).Cost(150).XpGate(1475).Add(new AddDef().Display(Vector.<TowerDisplayMod>([new TowerDisplayMod().UseFor(assets.towers.SonicBoom).Display(assets.towers.RedHotRangs),new TowerDisplayMod().UseFor(BoomerangMulti).Display(assets.towers.RedHotRangs),new TowerDisplayMod().UseFor(SonicBoomMulti).Display(assets.towers.RedHotRangs),new TowerDisplayMod().UseFor(assets.towers.GlaiveThrower).Display(HotGlaiveThrower),new TowerDisplayMod().UseFor(GlaiveRicochet).Display(HotGlaiveRicochet),new TowerDisplayMod().UseFor(assets.towers.GlaiveLord).Display(HotGlaiveLord)])).WeaponMod(new WeaponModDef().ProjectileMod(new ProjectileModDef().Display(Vector.<ProjectileDisplayMod>([new ProjectileDisplayMod().UseFor(Boomerang).Display(HotRang),new ProjectileDisplayMod().UseFor(Glaive).Display(HotGlaive)])).DamageEffectMod(new DamageEffectModDef().CanBreakIce(true).RemoveFromCantBreak(Vector.<int>([Bloon.LEAD,Bloon.DDT,Bloon.BOSS_DREADBLOON]))))).Detail(assets.detailView.HotRangas).DetailSmall(assets.PlayUI.HotRangas)),new UpgradeDef().Label("Bionic Boomer").Description("This tower replaces its arm with a super strong bionic arm. The Bionic Boomer throws boomerangs twice as fast.").Thumb(assets.upgrades.BionicBoomer).Cost(1600).XpGate(5445).Assign(_loc247_),new UpgradeDef().Label("Turbo Charge").Description("Turbo Charge Ability: increase attack speed to hypersonic for 10 seconds.").Cost(3000).XpGate(16385).RankGate(22).Thumb(assets.upgrades.TurboCharge).Assign(_loc248_)]]);
         this.upgrades.push(_loc321_);
         var _loc322_:UpgradePathDef = new UpgradePathDef().Base(_loc251_).Upgrades([[new UpgradeDef().Label("Monkey Beacon").Description("Increases attack range of all towers within Monkey Village radius by 15%").Cost(500).XpGate(250).Thumb(assets.upgrades.MonkeyBeacon).Add(new AddDef().DisplayAddons(Vector.<DisplayAddonDef>([new DisplayAddonDef().Clip(AntennaBase),new DisplayAddonDef().Clip(Beacon)])).AreaEffects(Vector.<AreaEffectDef>([_loc3_])).Detail(assets.detailView.MonkeyBeacon).DetailSmall(assets.PlayUI.MonkeyBeacon)),new UpgradeDef().Label("Jungle Drums").Description("Jungle drums inspire nearby towers to attack faster, increasing attack rate by 15%").Cost(1500).XpGate(2350).Thumb(assets.upgrades.JungleDrums).Add(new AddDef().DisplayAddons(Vector.<DisplayAddonDef>([new DisplayAddonDef().Clip(assets.towers.JungleDrums).Alts(Vector.<AltDisplayAddonDef>([new AltDisplayAddonDef().UseFor(MonkeyIntelligenceBurau).Display(Notes)]))])).AreaEffects(Vector.<AreaEffectDef>([_loc4_])).Detail(assets.detailView.JungleDrums).DetailSmall(assets.PlayUI.JungleDrums)),new UpgradeDef().Id("MonkeyTown").Label("Monkey Town").Description("All Bloons popped by towers within the radius of the Monkey Town get 50% more cash per pop.").Cost(10000).XpGate(9290).Thumb(assets.upgrades.MonkeyTown).Assign(_loc253_),new UpgradeDef().Label("High Energy Beacon").Description("All nearby towers with \'Abilities\' have their cooldowns reduced by 20% and adds a powerful energy beam attack.").Cost(12000).XpGate(28960).RankGate(35).Thumb(assets.upgrades.EnergyBeacon).Assign(_loc252_)],[new UpgradeDef().Label("Monkey Fort").Description("The Fort increases the popping power of all nearby towers by 1.").Cost(900).XpGate(875).Thumb(assets.upgrades.MonkeyFort).Add(new AddDef().DisplayAddons(Vector.<DisplayAddonDef>([new DisplayAddonDef().Clip(assets.towers.MonkeyFort).Z(-1).Alts(Vector.<AltDisplayAddonDef>([new AltDisplayAddonDef().UseFor(assets.towers.MonkeyTown).Display(MonkeyTownFort)]))])).AreaEffects(Vector.<AreaEffectDef>([_loc5_])).Detail(assets.detailView.MonkeyFort).DetailSmall(assets.PlayUI.MonkeyFort)),new UpgradeDef().Label("Radar Scanner").Description("Radar Scanner allows all towers within its radius to be able to detect and target camo bloons.").Cost(2000).XpGate(4050).Thumb(assets.upgrades.RadarScanner).Add(new AddDef().RangeOfVisibility(15).DisplayAddons(Vector.<DisplayAddonDef>([new DisplayAddonDef().Clip(AntennaBase),new DisplayAddonDef().Clip(assets.towers.RadarScanner).Z(3).Alts(Vector.<AltDisplayAddonDef>([new AltDisplayAddonDef().UseFor(assets.towers.MonkeyTown).Display(EnergyBeaconRadar)]))])).AreaEffects(Vector.<AreaEffectDef>([_loc8_])).RemoveFromTargetMask(Vector.<int>([Bloon.IMMUNITY_NO_DETECTION])).Detail(assets.detailView.RadarScanner).DetailSmall(assets.PlayUI.RadarScanner)),new UpgradeDef().Label("Monkey Intelligence Bureau").Description("The Bureau grants special bloon popping knowledge to all nearby towers, allowing them to pop all bloon types.").Cost(4300).XpGate(13130).Thumb(MonkeyIntelligenceBureau).Assign(_loc254_),new UpgradeDef().Label("M.I.B Call to Arms").Description("Call to Arms Ability: Doubles the attack speed and popping power of all nearby towers for 10 seconds.").Cost(24000).XpGate(44040).RankGate(35).Thumb(assets.upgrades.MIBCallToArms).Assign(_loc255_)]]);
         this.upgrades.push(_loc322_);
         var _loc323_:UpgradePathDef = new UpgradePathDef().Base(_loc256_).Upgrades([[new UpgradeDef().Label("Intense Magic").Description("Shoots larger and more powerful magical bolts.").Cost(300).XpGate(140).Thumb(assets.upgrades.IntenseMagic).Add(new AddDef().ReplaceWeapons(new <WeaponReplaceDef>[new WeaponReplaceDef().ReplaceWeaponID("MagicBoltWeapon").WithWeapon(_loc192_)]).Display(Vector.<TowerDisplayMod>([new TowerDisplayMod().UseFor(MonkeyApprentice).Display(IntenseFireball)])).Detail(assets.detailView.IntenseMagic).DetailSmall(assets.PlayUI.IntenseMagic)),new UpgradeDef().Label("Lightning Bolt").Description("Unleash the power of lightning to zap many bloons at once.").Cost(1200).XpGate(1280).Thumb(LightningBolt).Add(new AddDef().Weapons(Vector.<Weapon>([_loc198_])).Display(Vector.<TowerDisplayMod>([new TowerDisplayMod().UseFor(IntenseFireball).Display(LightningSense)])).Detail(assets.detailView.Lightning).DetailSmall(assets.PlayUI.Lightning)),new UpgradeDef().Label("Summon Whirlwind").Description("Whirlwind blows bloons off the path away from the exit. Removes ice and glue from bloons however.").Cost(2000).XpGate(4870).Thumb(assets.upgrades.SummonWhirlwind).Assign(_loc257_),new UpgradeDef().Label("Tempest Tornado").Description("The tempest blows more bloons, faster, further and more often. Also pops bloons once before blowing. Removes ice and glue from bloons however.").Cost(8000).XpGate(17060).RankGate(33).Thumb(assets.upgrades.TempestTornado).Assign(_loc258_)],[new UpgradeDef().Label("Fireball").Description("The Apprentice adds a powerful fireball attack to its arsenal.").Cost(300).XpGate(495).Thumb(assets.upgrades.Fireball).Add(new AddDef().Weapons(Vector.<Weapon>([_loc195_])).Display(Vector.<TowerDisplayMod>([new TowerDisplayMod().UseFor(MonkeyApprentice).Display(IntenseFireball)])).Detail(FireBall).DetailSmall(assets.PlayUI.Fireball)),new UpgradeDef().Label("Monkey Sense").Description("Allows the Monkey Apprentice to target and pop camo bloons. Does not grant detection to other towers.").Cost(300).XpGate(2140).Thumb(assets.upgrades.MonkeySense).Add(new AddDef().RemoveFromTargetMask(Vector.<int>([Bloon.IMMUNITY_NO_DETECTION])).WeaponMod(new WeaponModDef().ProjectileMod(new ProjectileModDef().RemoveFromEffectMask(Vector.<int>([Bloon.IMMUNITY_NO_DETECTION])))).Display(Vector.<TowerDisplayMod>([new TowerDisplayMod().UseFor(IntenseFireball).Display(LightningSense)])).Detail(assets.detailView.MonkeySense).DetailSmall(assets.PlayUI.MonkeySense)),new UpgradeDef().Label("Dragon\'s Breath").Description("Spews endless flames at nearby bloons, roasting and popping them with ease.").Cost(4200).XpGate(8600).Thumb(assets.upgrades.DragonsBreath).Assign(_loc259_),new UpgradeDef().Label("Summon Phoenix").Description("Summon Phoenix Ability: Creates a super powerful flying phoenix that flies around wreaking bloon havoc for 25 seconds.").Cost(5000).XpGate(29520).RankGate(33).Thumb(assets.upgrades.SummonPhoenix).Assign(_loc260_)]]);
         this.upgrades.push(_loc323_);
         var _loc324_:UpgradePathDef = new UpgradePathDef().Base(_loc261_).Upgrades([[new UpgradeDef().Id("MoreBananas").Label("More Bananas").Description("Grows 6 bananas each round instead of 4.").Cost(300).XpGate(250).Thumb(assets.upgrades.MoreBananas).Add(new AddDef().Display(Vector.<TowerDisplayMod>([new TowerDisplayMod().UseFor(assets.towers.BananaFarm).Display(assets.towers.MoreBananas)])).Behavior(new BehaviorModDef().BananaMod(new BananaModDef().CashPerRound(60))).Detail(assets.detailView.MoreBananas).DetailSmall(assets.PlayUI.MoreBananas)),new UpgradeDef().Id("BananaPlantation").Label("Banana Plantation").Description("Grows 13 bananas each round.").Cost(1400).XpGate(2250).Thumb(assets.upgrades.BananaPlantation).Add(new AddDef().Display(Vector.<TowerDisplayMod>([new TowerDisplayMod().UseFor(assets.towers.MoreBananas).Display(assets.towers.BananaPlantation)])).Behavior(new BehaviorModDef().BananaMod(new BananaModDef().CashPerRound(210))).Detail(assets.detailView.BananaPlantation).DetailSmall(assets.PlayUI.BananaPlantation)),new UpgradeDef().Label("Banana Republic").Description("Generates 25 bananas every round!").Cost(3200).XpGate(10250).Thumb(bananaRepublic).Assign(_loc264_),new UpgradeDef().Label("Banana Research Facility").Description("Produces 10 boxes of bananas every round. Each box is worth 300 cash.").Cost(14000).XpGate(37550).RankGate(36).Thumb(assets.upgrades.BananaResearchFacility).Assign(_loc265_)],[new UpgradeDef().Id("LongLifeBananas").Label("Long Life Bananas").Description("Bananas last 20 seconds instead of the usual 10.").Cost(500).XpGate(875).Thumb(LongLifeBananas).Add(new AddDef().Behavior(new BehaviorModDef().BananaMod(new BananaModDef().Lifespan(10))).Detail(assets.detailView.LongLifeNanas).DetailSmall(assets.PlayUI.LongLifeNanas)),new UpgradeDef().Id("ValuableBananas").Label("Valuable Bananas").Description("Each banana or box of bananas is worth 50% more cash.").Cost(4000).XpGate(3750).Thumb(ValuableBananas2).Add(new AddDef().Behavior(new BehaviorModDef().BananaMod(new BananaModDef().CashScale(0.5))).Detail(assets.detailView.ValuableNanas).DetailSmall(assets.PlayUI.ValuableNanas)),new UpgradeDef().Label("Monkey Bank").Description("Generates $675 cash each round which gets stored. Earns 10% interest each round and holds up to 7500 cash. Withdraw the cash at any time.").Cost(4200).XpGate(18350).Thumb(assets.upgrades.MonkeyBank).Assign(_loc262_),new UpgradeDef().Label("Banana Investments Advisory").Description("The investments advisory generates $1500 each round and earns 20% interest on uncollected funds. Withdraw the cash at any time, can hold up to $30,000.").Cost(5500).XpGate(63250).RankGate(36).Thumb(bananaInvestmentsAdvisory).Assign(_loc263_)]]);
         this.upgrades.push(_loc324_);
         var _loc325_:UpgradePathDef = new UpgradePathDef().Base(_loc266_).Upgrades([[new UpgradeDef().Label("Faster Shooting").Description("Shoots faster.").Cost(400).XpGate(150).Thumb(FasterShooting).Add(new AddDef().Display(Vector.<TowerDisplayMod>([new TowerDisplayMod().UseFor(MonkeyBuccaneer).Display(BuccaneerFaster),new TowerDisplayMod().UseFor(BuccaneerGrape).Display(BuccaneerFastGrape)])).WeaponMod(new WeaponModDef().ReloadTime(-0.23)).Detail(assets.detailView.FasterShootingBuccaneer).DetailSmall(assets.PlayUI.FasterShootingBuccaneer)),new UpgradeDef().Label("Longer Cannons").Description("Much longer range.").Cost(180).XpGate(1425).Thumb(assets.upgrades.LongerCannons).Add(new AddDef().DisplayAddonMods(Vector.<TowerDisplayMod>([new TowerDisplayMod().UseFor(BuccaneerCannonsLeft).Display(LongerCannonsLeft),new TowerDisplayMod().UseFor(BuccaneerCannonsRight).Display(LongerCannonsRight)])).Display(Vector.<TowerDisplayMod>([new TowerDisplayMod().UseFor(BuccaneerFaster).Display(LongerNest),new TowerDisplayMod().UseFor(BuccaneerFastGrape).Display(LongerNest),new TowerDisplayMod().UseFor(BuccaneerGrape).Display(LongerNest)])).RangeOfVisibility(30).Detail(assets.detailView.LongerCannons).DetailSmall(assets.PlayUI.LongerCannons)),new UpgradeDef().Label("Destroyer").Description("Attacks super duper fast!").Cost(2200).XpGate(5350).Thumb(assets.upgrades.Destroyer).Assign(_loc267_),new UpgradeDef().Label("Aircraft Carrier").Description("Rapidly launches Monkey Ace pilots that strafe the area with darts.").Cost(15000).XpGate(16975).RankGate(29).Thumb(assets.upgrades.AircraftCarrier).Assign(_loc268_)],[new UpgradeDef().Label("Grape Shot").Description("Sprays out a blast of 4 sharp grapes for additional poppage.").Cost(500).XpGate(550).Thumb(assets.upgrades.GrapeShot).Add(new AddDef().Display(Vector.<TowerDisplayMod>([new TowerDisplayMod().UseFor(MonkeyBuccaneer).Display(BuccaneerGrape),new TowerDisplayMod().UseFor(BuccaneerFaster).Display(BuccaneerFastGrape)])).Weapons(Vector.<Weapon>([_loc213_])).Detail(assets.detailView.GrapeShot).DetailSmall(assets.PlayUI.GrapeShot)),new UpgradeDef().Id("UpgradeBuccaneerCrowsNest").Label("Crow\'s Nest").Description("Allows the Buccaneer to detect and target camo bloons. Does not grant detection to other towers.").Cost(250).XpGate(2375).Thumb(assets.upgrades.CrowsNest).Add(new AddDef().DisplayAddonMods(Vector.<TowerDisplayMod>([new TowerDisplayMod().UseFor(BuccaneerCannonsLeft).Display(LongerCannonsLeft),new TowerDisplayMod().UseFor(BuccaneerCannonsRight).Display(LongerCannonsRight)])).Display(Vector.<TowerDisplayMod>([new TowerDisplayMod().UseFor(BuccaneerFaster).Display(LongerNest),new TowerDisplayMod().UseFor(BuccaneerFastGrape).Display(LongerNest),new TowerDisplayMod().UseFor(BuccaneerGrape).Display(LongerNest)])).RemoveFromTargetMask(Vector.<int>([Bloon.IMMUNITY_NO_DETECTION])).WeaponMod(new WeaponModDef().ProjectileMod(new ProjectileModDef().RemoveFromEffectMask(Vector.<int>([Bloon.IMMUNITY_NO_DETECTION])))).Detail(assets.detailView.CrowsNest).DetailSmall(assets.PlayUI.CrowsNest)),new UpgradeDef().Label("Cannon Ship").Description("Adds a powerful, independently firing cannon to the Buccaneer.").Cost(1200).XpGate(9125).Thumb(assets.upgrades.CannonShip).Assign(_loc269_),new UpgradeDef().Label("Monkey Pirates").Description("MOAB Takedown Ability: takes hold of the nearest MOAB-class bloon with a grappling hook and brings it down. ZOMG bloons are immune to this.").Cost(4500).XpGate(26225).RankGate(29).Thumb(assets.upgrades.MonkeyPirates).Assign(_loc270_)]]);
         this.upgrades.push(_loc325_);
         var _loc326_:UpgradePathDef = new UpgradePathDef().Base(_loc271_).Upgrades([[new UpgradeDef().Label("Rapid Fire").Description("Shoots darts more often.").Cost(700).XpGate(225).Thumb(RapidFire).Add(new AddDef().WeaponMod(new WeaponModDef().ReloadTime(1 / 1.4).ReloadTimeAsScale(true)).Behavior(new BehaviorModDef().Display(Vector.<TowerDisplayMod>([new TowerDisplayMod().UseFor(assets.towers.MonkeyAce).Display(MonkeyAceRapid)]))).Detail(assets.detailView.RapidFireAce).DetailSmall(assets.PlayUI.RapidFireAce)),new UpgradeDef().Label("Sharper Darts").Description("Monkey Ace darts can pop 8 bloons each!").Cost(500).XpGate(2150).Thumb(SharperDarts).Add(new AddDef().WeaponMod(new WeaponModDef().ProjectileMod(new ProjectileModDef().Pierce(3))).Behavior(new BehaviorModDef().Display(Vector.<TowerDisplayMod>([new TowerDisplayMod().UseFor(MonkeyAceRapid).Display(SharperSpyPlane)]))).Detail(assets.detailView.SharperDartsAce).DetailSmall(assets.PlayUI.SharperDartsAce)),new UpgradeDef().Label("Neva-Miss Targeting").Description("Darts seek out and pop bloons intelligently.").Cost(2200).XpGate(7725).Thumb(assets.upgrades.NevaMissTargeting).Assign(_loc272_),new UpgradeDef().Label("Spectre").Description("Flying fortress of bloon doom.").Cost(18000).XpGate(23250).RankGate(30).Thumb(assets.upgrades.Spectre).Assign(_loc273_)],[new UpgradeDef().Label("Pineapple Present").Description("Drops an exploding pineapple every 3 seconds.").Cost(200).XpGate(850).Thumb(PineapplePresent).Add(new AddDef().Weapons(Vector.<Weapon>([_loc185_])).Behavior(new BehaviorModDef().Display(Vector.<TowerDisplayMod>([new TowerDisplayMod().UseFor(assets.towers.MonkeyAce).Display(MonkeyAceRapid)]))).Detail(PineAppleExpress).DetailSmall(PineappleExpress)),new UpgradeDef().Label("Spy Plane").Description("Allows the Monkey Ace to hit camo bloons. Does not grant detection to other towers.").Cost(350).XpGate(3500).Thumb(assets.upgrades.SpyPlane).Add(new AddDef().RemoveFromTargetMask(Vector.<int>([Bloon.IMMUNITY_NO_DETECTION])).WeaponMod(new WeaponModDef().ProjectileMod(new ProjectileModDef().RemoveFromEffectMask(Vector.<int>([Bloon.IMMUNITY_NO_DETECTION])))).Behavior(new BehaviorModDef().Display(Vector.<TowerDisplayMod>([new TowerDisplayMod().UseFor(MonkeyAceRapid).Display(SharperSpyPlane)]))).Detail(assets.detailView.SpyPlane).DetailSmall(assets.PlayUI.SpyPlane)),new UpgradeDef().Label("Operation: Dart Storm").Description("More darts = win.").Cost(3000).XpGate(12400).Thumb(assets.upgrades.OperationDartStorm).Assign(_loc274_),new UpgradeDef().Label("Ground Zero").Description("Ground Zero Ability: drops a single devastating bomb that destroys all bloons on screen except MOAB-class bloons.").Cost(14000).XpGate(35700).RankGate(30).Thumb(assets.upgrades.GroundZero).Assign(_loc275_)]]);
         this.upgrades.push(_loc326_);
         var _loc327_:UpgradePathDef = new UpgradePathDef().Base(_loc276_).Upgrades([[new UpgradeDef().Label("Laser Blasts").Description("Shoots super powerful lasers instead of throwing darts. Lasers can pop frozen bloons.").Cost(3500).XpGate(500).Thumb(laserBlasts).Add(new AddDef().Display(Vector.<TowerDisplayMod>([new TowerDisplayMod().UseFor(assets.towers.SuperMonkey).Display(LaserMonkey).WeaponOffsets(Vector.<Vector2>([new Vector2(0,0)])),new TowerDisplayMod().UseFor(SuperMonkeyRange).Display(LaserMonkey).WeaponOffsets(Vector.<Vector2>([new Vector2(0,0)]))])).WeaponMod(new WeaponModDef().ProjectileMod(new ProjectileModDef().DamageEffectMod(new DamageEffectModDef().CanBreakIce(true)).Pierce(1).Display(Vector.<ProjectileDisplayMod>([new ProjectileDisplayMod().UseFor(Dart).Display(Laser),new ProjectileDisplayMod().UseFor(RoboDart).Display(RoboLaser)])))).Detail(assets.detailView.SuperLasers).DetailSmall(assets.PlayUI.SuperLasers)),new UpgradeDef().Label("Plasma Blasts").Description("Plasma vaporizes everything it touches.").Cost(5000).XpGate(6300).Thumb(PlasmaBlasts).Add(new AddDef().Display(Vector.<TowerDisplayMod>([new TowerDisplayMod().UseFor(assets.towers.SuperMonkey).Display(PlasmaVision),new TowerDisplayMod().UseFor(LaserMonkey).Display(PlasmaVision)])).WeaponMod(new WeaponModDef().ReloadTime(-1).ProjectileMod(new ProjectileModDef().DamageEffectMod(new DamageEffectModDef().RemoveFromCantBreak(Bloon.allBloonTypes).CanBreakIce(true)).Radius(20).Pierce(1).Display(Vector.<ProjectileDisplayMod>([new ProjectileDisplayMod().UseFor(Dart).Display(Plasma).AdditiveBlend(true),new ProjectileDisplayMod().UseFor(Laser).Display(Plasma).AdditiveBlend(true),new ProjectileDisplayMod().UseFor(RoboLaser).Display(Plasma).AdditiveBlend(true)])))).Detail(assets.detailView.SuperPlasma).DetailSmall(assets.PlayUI.SuperPlasma)),new UpgradeDef().Label("Sun God").Description("It is said that bloons who doth touch the sun shall be cleansed, and then there shalt be peace.").Cost(16500).XpGate(23850).Thumb(assets.upgrades.SunAvatar).Assign(_loc279_),new UpgradeDef().Label("Temple of the Monkey God").Description("The Temple demands sacrifice. Its arsenal of unstoppable bloon destruction is enhanced and modified by the types of tower sacrificed. Use at your own peril.").Cost(100000).XpGate(96400).RankGate(32).Thumb(TempleoftheMonkeyGod).Assign(_loc280_)],[new UpgradeDef().Label("Super Range").Description("Super Monkey with super range = good!").Cost(1000).XpGate(2350).Thumb(SuperRangeSM).Add(new AddDef().RangeOfVisibility(40).Detail(assets.detailView.SuperRange).DetailSmall(assets.PlayUI.SuperRange)),new UpgradeDef().Label("Epic Range").Description("Why settle for super when you can have EPIC?").Cost(1500).XpGate(10500).Thumb(assets.upgrades.EpicRange).Add(new AddDef().RangeOfVisibility(30).Display(Vector.<TowerDisplayMod>([new TowerDisplayMod().UseFor(assets.towers.SuperMonkey).Display(SuperMonkeyRange)])).Detail(assets.detailView.EpicRange).DetailSmall(assets.PlayUI.EpicRange)),new UpgradeDef().Label("Robo-Monkey").Description("Half Super Monkey, half killer robot of death. Super Monkey\'s arms become pulse cannons of annihilation, able to aim and target independently from each other.").Cost(9000).XpGate(44700).Thumb(assets.upgrades.RoboMonkey).Assign(_loc277_),new UpgradeDef().Label("Technological Terror").Description("Be proud of this Technological Terror you\'ve constructed. Bloon Annihilation Ability: Destroys all bloons within short radius of tower, completely, and utterly. Does 1000 damage to MOAB-class bloons.").Cost(25000).XpGate(165600).RankGate(32).Thumb(Technological).Assign(_loc278_)]]);
         this.upgrades.push(_loc327_);
         var _loc328_:UpgradePathDef = new UpgradePathDef().Base(_loc281_).Upgrades([[new UpgradeDef().Label("Focused Firing").Description("Greatly reduces the spread of the gun.").Cost(250).XpGate(325).Thumb(assets.upgrades.FocusedFiring).Add(new AddDef().Display(Vector.<TowerDisplayMod>([new TowerDisplayMod().UseFor(assets.towers.DartlingGun).Display(DartlingFocused)])).WeaponMod(new WeaponModDef().Spread(-0.25)).Detail(assets.detailView.FocusedFiring).DetailSmall(assets.PlayUI.FocusedFiring)),new UpgradeDef().Label("Faster Barrel Spin").Description("Makes gun fire much faster.").Cost(1200).XpGate(2605).Thumb(assets.upgrades.FasterBarrelSpin).Add(new AddDef().Display(Vector.<TowerDisplayMod>([new TowerDisplayMod().UseFor(DartlingFocused).Display(assets.towers.FasterBarrelSpin),new TowerDisplayMod().UseFor(assets.towers.DepletedBloontoniumDarts).Display(assets.towers.FasterBarrelSpin)])).WeaponMod(new WeaponModDef().ReloadTime(-0.086)).Detail(assets.detailView.FasterSpin).DetailSmall(assets.PlayUI.FasterSpin)),new UpgradeDef().Label("Laser Cannon").Description("Converts the gun into a super powerful laser cannon. Blasts from this cannon can pop 13 bloons each, can pop frozen bloons, and have increased attack rate.").Cost(6000).XpGate(9985).Thumb(PlasmaCannon).Assign(_loc282_),new UpgradeDef().Label("Ray of Doom").Description("The Ray of Doom is a persistent solid beam of bloon destruction.").Cost(55000).XpGate(54465).RankGate(38).Thumb(RayofDoom).Assign(_loc283_)],[new UpgradeDef().Label("Powerful Darts").Description("Makes darts shoot with greater velocity. Darts move faster and can pop 3 bloons each.").Cost(600).XpGate(1035).Thumb(assets.upgrades.PowerfulDarts).Add(new AddDef().Display(Vector.<TowerDisplayMod>([new TowerDisplayMod().UseFor(assets.towers.DartlingGun).Display(DartlingFocused)])).WeaponMod(new WeaponModDef().Power(350).ProjectileMod(new ProjectileModDef().Pierce(2))).Detail(assets.detailView.PowerfulDarts).DetailSmall(assets.PlayUI.PowerfulDarts)),new UpgradeDef().Label("Depleted Bloontonium Darts").Description("Shoots specially modified darts that can hurt any bloon type.").Cost(1000).XpGate(4325).Thumb(assets.upgrades.DepletedBloontoniumDarts).Add(new AddDef().Display(Vector.<TowerDisplayMod>([new TowerDisplayMod().UseFor(DartlingFocused).Display(assets.towers.DepletedBloontoniumDarts),new TowerDisplayMod().UseFor(assets.towers.FasterBarrelSpin).Display(assets.towers.DepletedBloontoniumDarts)])).WeaponMod(new WeaponModDef().ProjectileMod(new ProjectileModDef().DamageEffectMod(new DamageEffectModDef().CanBreakIce(true).RemoveFromCantBreak(Bloon.allBloonTypes)))).Detail(assets.detailView.DepletedPlutonium).DetailSmall(assets.PlayUI.DepletedPlutonium)),new UpgradeDef().Label("Hydra Rocket Pods").Description("Shoots vicious little missiles instead of darts. Hydra rockets have sharp tips that can pop Black Bloons.").Cost(7000).XpGate(23145).Thumb(assets.upgrades.HydraRocketPods).Assign(_loc284_),new UpgradeDef().Label("Bloon Area Denial System").Description("The BADS covers a wide area with each shot. Enables the Rocket Storm Ability: Rocket Storm shoots out a missile towards the nearest 100 bloons on screen. Ouch.").Cost(20000).XpGate(98285).RankGate(38).Thumb(assets.upgrades.BloonAreaDenialSystem).Assign(_loc285_)]]);
         this.upgrades.push(_loc328_);
         var _loc329_:UpgradePathDef = new UpgradePathDef().Base(_loc286_).Upgrades([[new UpgradeDef().Label("Increased Accuracy").Description("Makes your mortar shots more accurate.").Cost(200).XpGate(200).Thumb(IncreasedAccuracy).Add(new AddDef().Display(Vector.<TowerDisplayMod>([new TowerDisplayMod().UseFor(MortarTower).Display(MortarTowerAccurate)])).WeaponMod(new WeaponModDef().Spread(-40)).Detail(assets.detailView.MortarAccuracy).DetailSmall(assets.PlayUI.MortarAccuracy)),new UpgradeDef().Label("Bigger Blast").Description("Heavy ordinance delivers a bigger explosion radius.").Cost(600).XpGate(1612).Thumb(assets.upgrades.BiggerBlast).Add(new AddDef().Display(Vector.<TowerDisplayMod>([new TowerDisplayMod().UseFor(MortarTowerAccurate).Display(assets.towers.BiggerBlast)])).WeaponMod(new WeaponModDef().ProjectileMod(new ProjectileModDef().Display(Vector.<ProjectileDisplayMod>([new ProjectileDisplayMod().UseFor(LargeExplosion).Display(SlightlyLargerExplosion),new ProjectileDisplayMod().UseFor(BurnyLargeExplosion).Display(BurnySlightlyLargerExplosion)])).Radius(23))).Detail(assets.detailView.MortarBiggerBlast).DetailSmall(assets.PlayUI.MortarBiggerBlast)),new UpgradeDef().Label("Bloon Buster").Description("Bloon Buster Mortars smash through 2 layers of bloons at once!").Cost(800).XpGate(5962).Thumb(assets.upgrades.BloonBuster).Assign(_loc289_),new UpgradeDef().Label("The Big One").Description("Devastatingly large explosions, and each pops through 5 layers of bloon.").Cost(10000).XpGate(17387).RankGate(37).Thumb(assets.upgrades.TheBigOne).Assign(_loc290_)],[new UpgradeDef().Label("Rapid Reload").Description("Increase the attack speed of the Mortar.").Cost(250).XpGate(650).Thumb(RapidReload).Add(new AddDef().Display(Vector.<TowerDisplayMod>([new TowerDisplayMod().UseFor(MortarTower).Display(MortarTowerAccurate)])).WeaponMod(new WeaponModDef().ReloadTime(-0.49)).Detail(assets.detailView.MortarReload).DetailSmall(assets.PlayUI.MortarReload)),new UpgradeDef().Label("Burny Stuff").Description("A touch of Monkey napalm continues to pop layers for 6 seconds after impact.").Cost(500).XpGate(2637).Thumb(assets.upgrades.BurnyStuff).Add(new AddDef().Display(Vector.<TowerDisplayMod>([new TowerDisplayMod().UseFor(MortarTowerAccurate).Display(assets.towers.BiggerBlast)])).WeaponMod(new WeaponModDef().ProjectileMod(new ProjectileModDef().BurnEffectMod(new BurnEffectModDef().Lifespan(6).BurnInterval(2.1)).Display(Vector.<ProjectileDisplayMod>([new ProjectileDisplayMod().UseFor(LargeExplosion).Display(BurnyLargeExplosion),new ProjectileDisplayMod().UseFor(SlightlyLargerExplosion).Display(BurnySlightlyLargerExplosion),new ProjectileDisplayMod().UseFor(MediumExplosion).Display(BurnyMediumExplosion),new ProjectileDisplayMod().UseFor(NuclearExplosion).Display(BurnyNuclearExplosion)])))).Detail(assets.detailView.BurnyStuff).DetailSmall(assets.PlayUI.BurnyStuff)),new UpgradeDef().Label("Signal Flare").Description("Camo Bloons popped by this tower permanently lose their camo status, and can be attacked by towers without camo detection.").Cost(750).XpGate(9687).Thumb(assets.upgrades.SignalFlare).Assign(_loc287_),new UpgradeDef().Label("Artillery Battery").Description("Shoots mortar shells 3x as fast. Pop And Awe Ability: bombards the screen for 5 seconds, popping every bloon 1 time per second, and immobilizes all bloons during that time. Does not affect MOAB-class bloons.").Cost(9000).XpGate(26087).RankGate(37).Thumb(assets.upgrades.ArtilleryBattery).Assign(_loc288_)]]);
         this.upgrades.push(_loc329_);
         var _loc330_:UpgradePathDef = new UpgradePathDef().Base(_loc291_).Upgrades([[new UpgradeDef().Label("Full Metal Jacket").Description("Shots can pop through 4 layers of bloon - and can pop lead and frozen bloons.").Cost(350).XpGate(100).Thumb(assets.upgrades.FullMetalJacket).Add(new AddDef().Display(Vector.<TowerDisplayMod>([new TowerDisplayMod().UseFor(Sniper).Display(HeavyDart),new TowerDisplayMod().UseFor(FastFire).Display(HeavyDart)])).WeaponMod(new WeaponModDef().ProjectileMod(new ProjectileModDef().DamageEffectMod(new DamageEffectModDef().Damage(2).CanBreakIce(true).RemoveFromCantBreak(Vector.<int>([Bloon.LEAD,Bloon.DDT,Bloon.BOSS_DREADBLOON]))))).Detail(assets.detailView.FullMetalJacket).DetailSmall(assets.PlayUI.FullMetalJacket)),new UpgradeDef().Label("Point Five Oh").Description("Shots can pop through 7 layers of bloon!").Cost(2200).XpGate(1100).Thumb(assets.upgrades.PointFiveOh).Add(new AddDef().Display(Vector.<TowerDisplayMod>([new TowerDisplayMod().UseFor(HeavyDart).Display(HighCal),new TowerDisplayMod().UseFor(FastFire).Display(HighCal),new TowerDisplayMod().UseFor(assets.towers.NightVision).Display(HighCalNightVis)])).WeaponMod(new WeaponModDef().ProjectileMod(new ProjectileModDef().DamageEffectMod(new DamageEffectModDef().Damage(3).CanBreakIce(true)))).Detail(assets.detailView.PointFiveOh).DetailSmall(assets.PlayUI.PointFiveOh)),new UpgradeDef().Label("Deadly Precision").Description("Extreme accuracy and muzzle velocity cause up to 18 layers of bloon to be popped per shot - enough to destroy an entire ceramic bloon!").Cost(4000).XpGate(3275).Thumb(assets.upgrades.DeadlyPrecision).Assign(_loc292_),new UpgradeDef().Label("Cripple MOAB").Description("Bullets from this tower temporarily take out propulsion systems of MOAB-class bloons, immobilising them for a short time.").Cost(12500).XpGate(15360).RankGate(21).Thumb(assets.upgrades.CrippleMOAB).Assign(_loc293_)],[new UpgradeDef().Label("Faster Firing").Description("Allows Sniper to shoot faster.").Cost(400).XpGate(400).Thumb(FiringFaster).Add(new AddDef().Display(Vector.<TowerDisplayMod>([new TowerDisplayMod().UseFor(Sniper).Display(FastFire),new TowerDisplayMod().UseFor(HeavyDart).Display(FastFire)])).WeaponMod(new WeaponModDef().ReloadTime(-0.666)).Detail(assets.detailView.FastSniper).DetailSmall(assets.PlayUI.FastSniper)),new UpgradeDef().Label("Night Vision Goggles").Description("Allows Sniper to detect and shoot Camo bloons").Cost(300).XpGate(1950).Thumb(NightVisionGoggles).Add(new AddDef().Display(Vector.<TowerDisplayMod>([new TowerDisplayMod().UseFor(FastFire).Display(assets.towers.NightVision),new TowerDisplayMod().UseFor(HeavyDart).Display(assets.towers.NightVision),new TowerDisplayMod().UseFor(HighCal).Display(HighCalNightVis),new TowerDisplayMod().UseFor(CrippleMoab).Display(CrippleMoabNightVis),new TowerDisplayMod().UseFor(ChinaShop).Display(ChinaShopNightVis)])).RemoveFromTargetMask(Vector.<int>([Bloon.IMMUNITY_NO_DETECTION])).WeaponMod(new WeaponModDef().ProjectileMod(new ProjectileModDef().RemoveFromEffectMask(Vector.<int>([Bloon.IMMUNITY_NO_DETECTION])))).Detail(assets.detailView.NightVision).DetailSmall(assets.PlayUI.NightVision)),new UpgradeDef().Label("Semi Automatic Rifle").Description("Allows Sniper to take multiple shots and attack 3x as fast").Cost(3500).XpGate(7875).Thumb(SemiAutomaticRifle).Assign(_loc294_),new UpgradeDef().Id("SupplyDrop").Label("Supply Drop").Description("Supply Drop Ability: drops a crate full of cash.").Cost(12000).XpGate(26400).RankGate(21).Thumb(assets.upgrades.SupplyDrop).Assign(_loc295_)]]);
         this.upgrades.push(_loc330_);
         var _loc331_:UpgradePathDef = new UpgradePathDef().Base(_loc296_).Upgrades([[new UpgradeDef().Label("Ninja Discipline").Description("Increases attack range and attack speed.").Thumb(assets.upgrades.BoomerangThrower).Cost(300).XpGate(125).Thumb(assets.upgrades.NinjaDiscipline).Add(new AddDef().Display(Vector.<TowerDisplayMod>([new TowerDisplayMod().UseFor(Ninja).Display(assets.towers.NinjaDiscipline),new TowerDisplayMod().UseFor(assets.towers.SeekingShurikens).Display(assets.towers.NinjaDiscipline)])).RangeOfVisibility(20).WeaponMod(new WeaponModDef().ReloadTime(-0.125)).Detail(assets.detailView.NinjaDiscipline).DetailSmall(assets.PlayUI.NinjaDiscipline)),new UpgradeDef().Label("Sharp Shurikens").Description("Shurikens can pop 4 bloons each").Thumb(assets.upgrades.BoomerangThrower).Cost(350).XpGate(1325).Thumb(assets.upgrades.SharpShurikens).Add(new AddDef().Display(Vector.<TowerDisplayMod>([new TowerDisplayMod().UseFor(assets.towers.NinjaDiscipline).Display(SharpShuriken),new TowerDisplayMod().UseFor(assets.towers.SeekingShurikens).Display(SharpShuriken)])).WeaponMod(new WeaponModDef().ProjectileMod(new ProjectileModDef().Pierce(2))).Detail(assets.detailView.SharpShurikens).DetailSmall(assets.PlayUI.SharpShurikens)),new UpgradeDef().Label("Double Shot").Description("Extreme Ninja skill enables him to throw 2 shurikens at once").Cost(850).XpGate(5200).Thumb(DoubleShot).Assign(_loc297_),new UpgradeDef().Label("Bloonjitsu").Description("The art of Bloonjitsu allows Ninjas to throw 5 shurikens at once!").Cost(3000).XpGate(16500).RankGate(23).Thumb(assets.upgrades.Bloonjitsu).Assign(_loc298_)],[new UpgradeDef().Label("Seeking Shuriken").Description("Infuses bloon hatred into the weapons themselves - they will seek out and pop bloons automatically").Thumb(assets.upgrades.BoomerangThrower).Cost(250).XpGate(475).Thumb(SeekingShuriken).Add(new AddDef().Display(Vector.<TowerDisplayMod>([new TowerDisplayMod().UseFor(Ninja).Display(assets.towers.SeekingShurikens),new TowerDisplayMod().UseFor(assets.towers.NinjaDiscipline).Display(assets.towers.SeekingShurikens)])).WeaponMod(new WeaponModDef().ProjectileMod(new ProjectileModDef().BehaviorMod(new ProjectileBehaviorModDef().SetProcess(new Target().SeekAngle(Math.PI * 0.8).TurnTime(0.08).SeekTarget(true))))).Detail(assets.detailView.SeekingShurikens).DetailSmall(assets.PlayUI.SeekingShurikens)),new UpgradeDef().Label("Distraction").Description("Some bloons struck by the Ninja\'s weapons will become distracted and move the wrong way temporarily.").Thumb(assets.upgrades.BoomerangThrower).Cost(350).XpGate(2300).Thumb(assets.upgrades.Distraction).Add(new AddDef().Display(Vector.<TowerDisplayMod>([new TowerDisplayMod().UseFor(assets.towers.SeekingShurikens).Display(assets.towers.Distraction),new TowerDisplayMod().UseFor(assets.towers.NinjaDiscipline).Display(assets.towers.Distraction)])).WeaponMod(new WeaponModDef().ProjectileMod(new ProjectileModDef().WindeffectMod(new WindEffectModDef().Chance(-0.85)))).Detail(assets.detailView.Distraction).DetailSmall(assets.PlayUI.Distraction)),new UpgradeDef().Label("Flash Bomb").Description("Sometimes throws a flash bomb that stuns bloons in a large radius.").Cost(2750).XpGate(8700).Thumb(assets.upgrades.FlashBomb).Assign(_loc299_),new UpgradeDef().Label("Sabotage Supply Lines").Description("Sabotage Supply Lines Ability: Sabotage the bloons supply lines for 15 seconds. During the sabotage, all new bloons are crippled to half speed.").Cost(2800).XpGate(27150).RankGate(23).Thumb(SabbotageSupplyLines).Assign(_loc300_)]]);
         this.upgrades.push(_loc331_);
         var _loc332_:UpgradePathDef = new UpgradePathDef().Base(_loc302_).Upgrades([[new UpgradeDef().Label("Sentry Gun").Description("Automatically creates sentry guns and deploys them on the ground nearby. Sentries shoot sharp steel pins at the bloons but only last a short time.").Cost(450).XpGate(1).Thumb(assets.upgrades.SentryGun).Add(new AddDef().Display(Vector.<TowerDisplayMod>([new TowerDisplayMod().UseFor(EngineerMonkey).Display(EngineerSentryBuilder),new TowerDisplayMod().UseFor(EngineerNineInchNails).Display(EngineerSentryBuilder)])).Weapons(Vector.<Weapon>([_loc125_])).Detail(assets.detailView.SentryGun).DetailSmall(assets.PlayUI.SentryGun)),new UpgradeDef().Label("Fast Engineering").Description("Engineer increases his build speed, producing sentry guns more often.").Cost(350).XpGate(3).Thumb(FastEngineering).Add(new AddDef().Display(Vector.<TowerDisplayMod>([new TowerDisplayMod().UseFor(EngineerSentryBuilder).Display(EngineerFastBuild),new TowerDisplayMod().UseFor(EngineerLargerArea).Display(EngineerFastBuild),new TowerDisplayMod().UseFor(EngineerNineInchNails).Display(EngineerFastBuild)])).WeaponMod(new WeaponModDef().ReloadTime(-4).Specific("SentryCreate")).Detail(assets.detailView.FasterEngineering).DetailSmall(assets.PlayUI.FasterEngineering)),new UpgradeDef().Label("Cleansing Foam").Description("The Engineer uses special dispenser to spray down the track with a cleansing foam that removes camo and regen properties. Also pops lead bloons.").Cost(750).XpGate(5).Thumb(assets.upgrades.CleansingFoam).Assign(_loc303_),new UpgradeDef().Label("Bloon Trap").Description("Creates a powerful bloon trap that destroys all bloons caught in it. Once full, trap will destroy itself after a short time. If emptied manually, gives you extra cash. Only one trap can be active at a time.").Cost(3000).XpGate(7).Thumb(assets.upgrades.BloonTrap).Assign(_loc304_)],[new UpgradeDef().Label("9-inch nails").Description("Engineer\'s nailgun upgrades to shoot massive 9-inch long nails that can pop 8 bloons at once including frozen bloons").Cost(700).XpGate(2).Thumb(NineInchNails).Add(new AddDef().Display(Vector.<TowerDisplayMod>([new TowerDisplayMod().UseFor(EngineerMonkey).Display(EngineerNineInchNails),new TowerDisplayMod().UseFor(EngineerSentryBuilder).Display(EngineerNineInchNails)])).WeaponMod(new WeaponModDef().Specific("NailGun").ProjectileMod(new ProjectileModDef().Pierce(5).DamageEffectMod(new DamageEffectModDef().CanBreakIce(true)))).Detail(assets.detailView.NIN).DetailSmall(assets.PlayUI.NIN)),new UpgradeDef().Label("Larger Service Area").Description("Engineer can shoot farther and deploy sentries in a larger area.").Cost(650).XpGate(4).Thumb(LargerServiceArea).Add(new AddDef().Display(Vector.<TowerDisplayMod>([new TowerDisplayMod().UseFor(EngineerNineInchNails).Display(EngineerLargerArea),new TowerDisplayMod().UseFor(EngineerFastBuild).Display(EngineerLargerArea),new TowerDisplayMod().UseFor(EngineerSentryBuilder).Display(EngineerLargerArea)])).RangeOfVisibility(65).Detail(assets.detailView.LargerArea).DetailSmall(assets.PlayUI.LargerArea)),new UpgradeDef().Label("Sprockets").Description("Adding sprockets to sentries and the nailgun increase their fire rate appreciably.").Cost(550).XpGate(6).Thumb(assets.upgrades.Sprockets).Assign(_loc305_),new UpgradeDef().Label("Overclock").Description("Activated Ability: Overclock - target tower becomes super powered for 60 seconds.").Cost(13500).XpGate(8).Thumb(assets.upgrades.Overclock).Assign(_loc306_)]]);
         this.upgrades.push(_loc332_);
      }
      
      public function getBaseTower(param1:String) : TowerDef
      {
         var _loc2_:TowerDef = null;
         for each(_loc2_ in this.baseTowers)
         {
            if(_loc2_.id == param1)
            {
               return _loc2_;
            }
         }
         return null;
      }
      
      public function isBaseTower(param1:String) : Boolean
      {
         var _loc2_:TowerDef = this.getBaseTower(param1);
         return _loc2_ != null;
      }
      
      public function getUpgrades(param1:String) : UpgradePathDef
      {
         var _loc2_:UpgradePathDef = null;
         var _loc3_:Vector.<UpgradeDef> = null;
         var _loc4_:UpgradeDef = null;
         for each(_loc2_ in this.upgrades)
         {
            if(_loc2_.base.id == param1)
            {
               return _loc2_;
            }
            for each(_loc3_ in _loc2_.upgrades)
            {
               for each(_loc4_ in _loc3_)
               {
                  if(_loc4_.assign != null && _loc4_.assign.id == param1)
                  {
                     return _loc2_;
                  }
               }
            }
         }
         return null;
      }
      
      public function applyHardcoreCosts(param1:Number) : void
      {
         this.scaleCosts(param1);
      }
      
      public function scaleCosts(param1:Number) : void
      {
         var _loc2_:UpgradePathDef = null;
         var _loc3_:Vector.<UpgradeDef> = null;
         var _loc4_:UpgradeDef = null;
         for each(_loc2_ in this.upgrades)
         {
            for each(_loc3_ in _loc2_.upgrades)
            {
               for each(_loc4_ in _loc3_)
               {
                  _loc4_.Cost(_loc4_.cost * param1);
               }
            }
         }
      }
   }
}

package ninjakiwi.monkeyTown.town.data
{
   import assets.town.BombTowerIcon;
   import assets.town.BoomerangTowerIcon;
   import assets.town.DartMonkeyTowerIcon;
   import assets.town.DartlingGunTowerIcon;
   import assets.town.EngineerTowerIcon;
   import assets.town.ExplodingPineappleIcon;
   import assets.town.FarmTowerIcon;
   import assets.town.GlueMonkeyTowerIcon;
   import assets.town.IceMonkeyTowerIcon;
   import assets.town.MonkeyAceTowerIcon;
   import assets.town.MonkeyApprenticeTowerIcon;
   import assets.town.MonkeyBuccaneerTowerIcon;
   import assets.town.MortarTowerIcon;
   import assets.town.NinjaMonkeyTowerIcon;
   import assets.town.RoadSpikesIcon;
   import assets.town.SniperMonkeyTowerIcon;
   import assets.town.SpikeFactoryTowerIcon;
   import assets.town.SuperMonkeyTowerIcon;
   import assets.town.TackTowerIcon;
   import assets.town.VillageTowerIcon;
   import ninjakiwi.monkeyTown.town.data.definitions.PopulationDefinition;
   
   public class PopulationData
   {
      
      private static var instance:PopulationData;
       
      
      public const DART_MONKEY:PopulationDefinition = new PopulationDefinition().Id("DartMonkey").Name("Dart Monkey").IconClass(DartMonkeyTowerIcon).PopulationCount(1).PopulationCountString("one");
      
      public const BOOMERANG_THROWER:PopulationDefinition = new PopulationDefinition().Id("BoomerangThrower").Name("Boomerang Thrower").IconClass(BoomerangTowerIcon).PopulationCount(1).PopulationCountString("one");
      
      public const SNIPER_MONKEY:PopulationDefinition = new PopulationDefinition().Id("SniperMonkey").Name("Sniper Monkey").IconClass(SniperMonkeyTowerIcon).PopulationCount(1).PopulationCountString("one");
      
      public const NINJA_MONKEY:PopulationDefinition = new PopulationDefinition().Id("NinjaMonkey").Name("Ninja Monkey").IconClass(NinjaMonkeyTowerIcon).PopulationCount(1).PopulationCountString("one");
      
      public const BOMB_TOWER:PopulationDefinition = new PopulationDefinition().Id("BombTower").Name("Bomb Shooter").IconClass(BombTowerIcon).PopulationCount(1).PopulationCountString("one");
      
      public const ICE_MONKEY:PopulationDefinition = new PopulationDefinition().Id("IceTower").Name("Ice Monkey").IconClass(IceMonkeyTowerIcon).PopulationCount(1).PopulationCountString("one");
      
      public const TACK_TOWER:PopulationDefinition = new PopulationDefinition().Id("TackTower").Name("Tack Shooter").IconClass(TackTowerIcon).PopulationCount(1).PopulationCountString("one");
      
      public const GLUE_GUNNER:PopulationDefinition = new PopulationDefinition().Id("GlueGunner").Name("Glue Gunner").IconClass(GlueMonkeyTowerIcon).PopulationCount(1).PopulationCountString("one");
      
      public const MONKEY_BUCCANEER:PopulationDefinition = new PopulationDefinition().Id("MonkeyBuccaneer").Name("Monkey Buccaneer").IconClass(MonkeyBuccaneerTowerIcon).PopulationCount(1).PopulationCountString("one");
      
      public const MONKEY_ACE:PopulationDefinition = new PopulationDefinition().Id("MonkeyAce").Name("Monkey Ace").IconClass(MonkeyAceTowerIcon).PopulationCount(1).PopulationCountString("one");
      
      public const SUPER_MONKEY:PopulationDefinition = new PopulationDefinition().Id("SuperMonkey").Name("Super Monkey").IconClass(SuperMonkeyTowerIcon).PopulationCount(1).PopulationCountString("one");
      
      public const MONKEY_APPRENTICE:PopulationDefinition = new PopulationDefinition().Id("MonkeyApprentice").Name("Monkey Apprentice").IconClass(MonkeyApprenticeTowerIcon).PopulationCount(1).PopulationCountString("one");
      
      public const MORTAR_TOWER:PopulationDefinition = new PopulationDefinition().Id("MortarTower").Name("Mortar Monkey").IconClass(MortarTowerIcon).PopulationCount(1).PopulationCountString("one");
      
      public const SPIKE_FACTORY:PopulationDefinition = new PopulationDefinition().Id("SpikeFactory").Name("Spike Factory").IconClass(SpikeFactoryTowerIcon).PopulationCount(1).PopulationCountString("one");
      
      public const DARTLING_GUN:PopulationDefinition = new PopulationDefinition().Id("DartlingGun").Name("Dartling Gun").IconClass(DartlingGunTowerIcon).PopulationCount(1).PopulationCountString("one");
      
      public const EXPLODING_PINEAPPLE:PopulationDefinition = new PopulationDefinition().Id("ExplodingPineapple").Name("Exploding Pineapple").IconClass(ExplodingPineappleIcon).PopulationCount(5).PopulationCountString("five");
      
      public const ROAD_SPIKES:PopulationDefinition = new PopulationDefinition().Id("RoadSpikes").Name("Road Spikes").IconClass(RoadSpikesIcon).PopulationCount(5).PopulationCountString("five");
      
      public const BANANA_FARM:PopulationDefinition = new PopulationDefinition().Id("BananaFarm").Name("Banana Farm").IconClass(FarmTowerIcon).PopulationCount(1).PopulationCountString("one");
      
      public const MONKEY_VILLAGE:PopulationDefinition = new PopulationDefinition().Id("MonkeyVillage").Name("Monkey Village").IconClass(VillageTowerIcon).PopulationCount(1).PopulationCountString("one");
      
      public const ENGINEER:PopulationDefinition = new PopulationDefinition().Id("Engineer").Name("Engineer").IconClass(EngineerTowerIcon).PopulationCount(1).PopulationCountString("one");
      
      public const populationDefinitions:Array = [this.DART_MONKEY,this.BOOMERANG_THROWER,this.SNIPER_MONKEY,this.NINJA_MONKEY,this.BOMB_TOWER,this.ICE_MONKEY,this.TACK_TOWER,this.GLUE_GUNNER,this.MONKEY_BUCCANEER,this.MONKEY_ACE,this.SUPER_MONKEY,this.MONKEY_APPRENTICE,this.MORTAR_TOWER,this.SPIKE_FACTORY,this.DARTLING_GUN,this.EXPLODING_PINEAPPLE,this.ROAD_SPIKES,this.BANANA_FARM,this.MONKEY_VILLAGE,this.ENGINEER];
      
      public const definitionsByID:Object = {};
      
      public function PopulationData(param1:SingletonEnforcer#1477)
      {
         super();
         if(param1 == null)
         {
            throw new Error("Error: Instantiation failed: Use PopulationData.getInstance() instead of new.");
         }
         this.init();
      }
      
      public static function getInstance() : PopulationData
      {
         if(instance == null)
         {
            instance = new PopulationData(new SingletonEnforcer#1477());
         }
         return instance;
      }
      
      public function getDefinitionByID(param1:String) : PopulationDefinition
      {
         if(this.definitionsByID[param1] == null)
         {
            return null;
         }
         return this.definitionsByID[param1];
      }
      
      private function init() : void
      {
         var _loc1_:PopulationDefinition = null;
         var _loc2_:int = 0;
         while(_loc2_ < this.populationDefinitions.length)
         {
            _loc1_ = this.populationDefinitions[_loc2_];
            this.definitionsByID[_loc1_.id] = _loc1_;
            _loc2_++;
         }
      }
   }
}

class SingletonEnforcer#1477
{
    
   
   function SingletonEnforcer#1477()
   {
      super();
   }
}

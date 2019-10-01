package ninjakiwi.monkeyTown.btdModule.towers
{
   import assets.towerBtns.AceTower;
   import assets.towerBtns.BombTower;
   import assets.towerBtns.BoomerangTower;
   import assets.towerBtns.BuccaneerTower;
   import assets.towerBtns.DartTower;
   import assets.towerBtns.DartlingTower;
   import assets.towerBtns.Engineer;
   import assets.towerBtns.FarmTower;
   import assets.towerBtns.GlueTower;
   import assets.towerBtns.IceTower;
   import assets.towerBtns.MortarTower;
   import assets.towerBtns.NinjaMonkey;
   import assets.towerBtns.Pineapple;
   import assets.towerBtns.RoadSpikes;
   import assets.towerBtns.SniperMonkey;
   import assets.towerBtns.SpikeFactory;
   import assets.towerBtns.SuperTower;
   import assets.towerBtns.TackTower;
   import assets.towerBtns.VillageTower;
   import assets.towerBtns.WizardTower;
   import flash.ui.Keyboard;
   import ninjakiwi.monkeyTown.btdModule.ingame.TowerPickerDef;
   import ninjakiwi.monkeyTown.common.Constants;
   
   public class TowerMenuSet
   {
       
      
      public var towersInMenu:Vector.<TowerPickerDef>;
      
      public var teirUnlockBattleScore:Vector.<int>;
      
      private var _pickersByTowerID:Object;
      
      public function TowerMenuSet()
      {
         this.towersInMenu = new Vector.<TowerPickerDef>();
         this.teirUnlockBattleScore = Vector.<int>([0,50,250,500]);
         this._pickersByTowerID = {};
         super();
         var _loc1_:TowerPickerDef = new TowerPickerDef().Id(0).Button(DartTower).Tower(Main.instance.towerFactory.getBaseTower("DartMonkey")).Cost(200).NkUpgradeID(56).HotKey(Keyboard.Q).UnlockTier4Cost(30);
         this.towersInMenu.push(_loc1_);
         var _loc2_:TowerPickerDef = new TowerPickerDef().Id(1).Button(TackTower).Tower(Main.instance.towerFactory.getBaseTower("TackTower")).Cost(360).NkUpgradeID(57).HotKey(Keyboard.W).UnlockTier4Cost(30);
         this.towersInMenu.push(_loc2_);
         var _loc3_:TowerPickerDef = new TowerPickerDef().Id(2).Button(SniperMonkey).Tower(Main.instance.towerFactory.getBaseTower("SniperMonkey")).Cost(350).NkUpgradeID(70).HotKey(Keyboard.E).UnlockTier4Cost(30);
         this.towersInMenu.push(_loc3_);
         var _loc4_:TowerPickerDef = new TowerPickerDef().Id(3).Button(NinjaMonkey).Tower(Main.instance.towerFactory.getBaseTower("NinjaMonkey")).Cost(500).NkUpgradeID(71).HotKey(Keyboard.T).UnlockTier4Cost(30);
         this.towersInMenu.push(_loc4_);
         var _loc5_:TowerPickerDef = new TowerPickerDef().Id(4).Button(BombTower).Tower(Main.instance.towerFactory.getBaseTower("BombTower")).Cost(650).NkUpgradeID(59).HotKey(Keyboard.Y).UnlockTier4Cost(30);
         this.towersInMenu.push(_loc5_);
         var _loc6_:TowerPickerDef = new TowerPickerDef().Id(5).Button(IceTower).Tower(Main.instance.towerFactory.getBaseTower("IceTower")).Cost(300).NkUpgradeID(60).HotKey(Keyboard.A).UnlockTier(1).UnlockCost(10).UnlockTier4Cost(30);
         this.towersInMenu.push(_loc6_);
         var _loc7_:TowerPickerDef = new TowerPickerDef().Id(6).Button(BoomerangTower).Tower(Main.instance.towerFactory.getBaseTower("BoomerangThrower")).Cost(350).NkUpgradeID(58).HotKey(Keyboard.R).UnlockTier(1).UnlockCost(12).UnlockTier4Cost(36);
         this.towersInMenu.push(_loc7_);
         var _loc8_:TowerPickerDef = new TowerPickerDef().Id(7).Button(GlueTower).Tower(Main.instance.towerFactory.getBaseTower("GlueGunner")).Cost(270).NkUpgradeID(61).HotKey(Keyboard.S).UnlockTier(1).UnlockCost(15).UnlockTier4Cost(45);
         this.towersInMenu.push(_loc8_);
         var _loc9_:TowerPickerDef = new TowerPickerDef().Id(8).Button(BuccaneerTower).Tower(Main.instance.towerFactory.getBaseTower("MonkeyBuccaneer")).Cost(500).NkUpgradeID(62).HotKey(Keyboard.D).UnlockTier(1).UnlockCost(12).UnlockTier4Cost(36);
         this.towersInMenu.push(_loc9_);
         var _loc10_:TowerPickerDef = new TowerPickerDef().Id(9).Button(AceTower).Tower(Main.instance.towerFactory.getBaseTower("MonkeyAce")).Cost(925).NkUpgradeID(63).HotKey(Keyboard.F).UnlockTier(2).UnlockCost(20).UnlockTier4Cost(60);
         this.towersInMenu.push(_loc10_);
         var _loc11_:TowerPickerDef = new TowerPickerDef().Id(10).Button(MortarTower).Tower(Main.instance.towerFactory.getBaseTower("MortarTower")).Cost(750).NkUpgradeID(68).HotKey(Keyboard.B).UnlockTier(2).UnlockCost(15).UnlockTier4Cost(45);
         this.towersInMenu.push(_loc11_);
         var _loc12_:TowerPickerDef = new TowerPickerDef().Id(11).Button(DartlingTower).Tower(Main.instance.towerFactory.getBaseTower("DartlingGun")).Cost(950).NkUpgradeID(69).HotKey(Keyboard.N).UnlockTier(2).UnlockCost(18).UnlockTier4Cost(50);
         this.towersInMenu.push(_loc12_);
         var _loc13_:TowerPickerDef = new TowerPickerDef().Id(12).Button(SpikeFactory).Tower(Main.instance.towerFactory.getBaseTower("SpikeFactory")).Cost(825).NkUpgradeID(103).HotKey(Keyboard.M).UnlockTier(2).UnlockCost(15).UnlockTier4Cost(45);
         this.towersInMenu.push(_loc13_);
         var _loc14_:TowerPickerDef = new TowerPickerDef().Id(13).Button(SuperTower).Tower(Main.instance.towerFactory.getBaseTower("SuperMonkey")).Cost(3500).NkUpgradeID(64).HotKey(Keyboard.G).UnlockTier(3).UnlockCost(25).UnlockTier4Cost(60);
         this.towersInMenu.push(_loc14_);
         var _loc15_:TowerPickerDef = new TowerPickerDef().Id(14).Button(WizardTower).Tower(Main.instance.towerFactory.getBaseTower("MonkeyApprentice")).Cost(550).NkUpgradeID(65).HotKey(Keyboard.H).UnlockTier(3).UnlockCost(20).UnlockTier4Cost(60);
         this.towersInMenu.push(_loc15_);
         var _loc16_:TowerPickerDef = new TowerPickerDef().Id(15).Button(VillageTower).Tower(Main.instance.towerFactory.getBaseTower("MonkeyVillage")).Cost(1600).NkUpgradeID(66).HotKey(Keyboard.C).UnlockTier(3).UnlockCost(22).UnlockTier4Cost(60);
         this.towersInMenu.push(_loc16_);
         var _loc17_:TowerPickerDef = new TowerPickerDef().Id(16).Button(FarmTower).Tower(Main.instance.towerFactory.getBaseTower("BananaFarm")).Cost(1000).NkUpgradeID(67).HotKey(Keyboard.V).UnlockTier(3).UnlockCost(22).UnlockTier4Cost(60);
         this.towersInMenu.push(_loc17_);
         var _loc18_:TowerPickerDef = new TowerPickerDef().Id(17).Button(RoadSpikes).Tower(Main.instance.towerFactory.getBaseTower(Constants.TOWER_ROADSPIKE)).Cost(30).HotKey(Keyboard.Z);
         this.towersInMenu.push(_loc18_);
         var _loc19_:TowerPickerDef = new TowerPickerDef().Id(18).Button(Pineapple).Cost(25).Tower(Main.instance.towerFactory.getBaseTower(Constants.TOWER_PINEAPPLE)).HotKey(Keyboard.X);
         this.towersInMenu.push(_loc19_);
         var _loc20_:TowerPickerDef = new TowerPickerDef().Id(19).Button(Engineer).Tower(Main.instance.towerFactory.getBaseTower("Engineer")).Cost(450).NkUpgradeID(67).HotKey(Keyboard.L).UnlockTier(3).UnlockCost(22).UnlockTier4Cost(60);
         this.towersInMenu.push(_loc20_);
         this.initPickersByTowerID();
         this.initMenuOrderIndex();
      }
      
      private function initPickersByTowerID() : void
      {
         var _loc1_:TowerPickerDef = null;
         var _loc2_:int = 0;
         while(_loc2_ < this.towersInMenu.length)
         {
            _loc1_ = this.towersInMenu[_loc2_];
            this._pickersByTowerID[_loc1_.tower.id] = _loc1_;
            _loc2_++;
         }
      }
      
      private function initMenuOrderIndex() : void
      {
         var _loc1_:TowerPickerDef = null;
         var _loc2_:int = 0;
         while(_loc2_ < this.towersInMenu.length)
         {
            _loc1_ = this.towersInMenu[_loc2_];
            _loc1_.menuOrder = _loc2_;
            _loc2_++;
         }
      }
      
      public function getPickerByTowerID(param1:String) : TowerPickerDef
      {
         return this._pickersByTowerID[param1];
      }
      
      public function getMenuIDForTowerRootID(param1:String) : int
      {
         var _loc2_:int = 0;
         while(_loc2_ < this.towersInMenu.length)
         {
            if(param1 == this.towersInMenu[_loc2_].tower.id)
            {
               return this.towersInMenu[_loc2_].id;
            }
            _loc2_++;
         }
         return -1;
      }
      
      public function getListOfUnlockedTowers() : Vector.<TowerPickerDef>
      {
         var _loc2_:TowerPickerDef = null;
         var _loc1_:Vector.<TowerPickerDef> = new Vector.<TowerPickerDef>();
         for each(_loc2_ in this.towersInMenu)
         {
            if(_loc2_.unlockCost == 0 || Main.instance.profile.isTowerUnlocked(_loc2_.id))
            {
               _loc1_.push(_loc2_);
            }
         }
         return _loc1_;
      }
      
      public function applyHardcoreCosts(param1:Number) : void
      {
         this.scaleCosts(param1);
      }
      
      public function scaleCosts(param1:Number) : void
      {
         var _loc2_:int = 0;
         while(_loc2_ < this.towersInMenu.length)
         {
            this.towersInMenu[_loc2_].Cost(this.towersInMenu[_loc2_].cost * param1);
            _loc2_++;
         }
      }
   }
}

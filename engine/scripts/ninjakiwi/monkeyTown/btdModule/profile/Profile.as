package ninjakiwi.monkeyTown.btdModule.profile
{
   import flash.events.EventDispatcher;
   import ninjakiwi.monkeyTown.btdModule.game.Balance;
   import ninjakiwi.monkeyTown.btdModule.ingame.TowerPickerDef;
   import ninjakiwi.monkeyTown.btdModule.sound.BGM;
   import ninjakiwi.monkeyTown.btdModule.sound.MaxSound;
   import ninjakiwi.monkeyTown.btdModule.utils.ObjectHelper;
   import ninjakiwi.mynk.MyNK;
   import ninjakiwi.mynk.sharedDefinitions.Msg;
   import org.osflash.signals.Signal;
   
   public class Profile extends EventDispatcher
   {
       
      
      private var currentEnergy_:CryptScore;
      
      private var maxEnergy_:CryptScore;
      
      private var lastEnergyGainTime_:CryptScore;
      
      private var medallions_:CryptScore;
      
      private var battleScore_:CryptScore;
      
      private var gamesPlayed_:CryptScore;
      
      private var wins_:CryptScore;
      
      private var losses_:CryptScore;
      
      private var disconnects_:CryptScore;
      
      private var decalsUnlocked_:Vector.<int>;
      
      private var towersUnlocked_:Vector.<int>;
      
      private var towerTier4sUnlocked_:Vector.<int>;
      
      private var shopItemUses_:Vector.<int>;
      
      private var bgmOn_:Boolean = true;
      
      private var sfxOn_:Boolean = true;
      
      private var sigProfileReloaded:Signal;
      
      private var sigBattleScoreChanged:Signal;
      
      private var sigMedallionsChanged:Signal;
      
      private var sigEnergyChanged:Signal;
      
      private var sigMaxEnergyChanged:Signal;
      
      private var needsToSave:Boolean = false;
      
      private var currentTime:Number = 0;
      
      private var addingEnergy:Boolean = false;
      
      private var settingGainTime:Boolean = false;
      
      private var energyInitzed:Boolean = false;
      
      public function Profile()
      {
         this.currentEnergy_ = new CryptScore();
         this.maxEnergy_ = new CryptScore();
         this.lastEnergyGainTime_ = new CryptScore();
         this.medallions_ = new CryptScore();
         this.battleScore_ = new CryptScore();
         this.gamesPlayed_ = new CryptScore();
         this.wins_ = new CryptScore();
         this.losses_ = new CryptScore();
         this.disconnects_ = new CryptScore();
         this.decalsUnlocked_ = new Vector.<int>();
         this.towersUnlocked_ = new Vector.<int>();
         this.towerTier4sUnlocked_ = new Vector.<int>();
         this.shopItemUses_ = new Vector.<int>();
         this.sigProfileReloaded = new Signal();
         this.sigBattleScoreChanged = new Signal();
         this.sigMedallionsChanged = new Signal();
         this.sigEnergyChanged = new Signal();
         this.sigMaxEnergyChanged = new Signal();
         super();
      }
      
      public function resetDefault() : void
      {
         this.currentEnergy_ = new CryptScore();
         this.maxEnergy_ = new CryptScore();
         this.maxEnergy_.value = Balance.instance.STARTING_ENERGY.v;
         this.currentEnergy_.value = this.maxEnergy_.value;
         this.lastEnergyGainTime_ = new CryptScore();
         this.lastEnergyGainTime_.value = -1;
         this.medallions_ = new CryptScore();
         this.battleScore_ = new CryptScore();
         this.decalsUnlocked_ = new Vector.<int>();
         this.towersUnlocked_ = new Vector.<int>();
         this.towerTier4sUnlocked_ = new Vector.<int>();
         this.shopItemUses_ = new Vector.<int>();
         var _loc1_:int = 0;
         while(_loc1_ < Main.instance.premuimSaleFactory.premiumItems.length)
         {
            this.shopItemUses_[_loc1_] = 0;
            _loc1_++;
         }
      }
      
      public function load(param1:String) : void
      {
         var json:String = param1;
         try
         {
            json = ObjectHelper.replaceAll(json,"Infinity","0");
            this.resetDefault();
            ObjectHelper.deserialize(json,this);
            this.initialiseEnergyConductors();
            this.updateSoundButtons();
            this.sigProfileReloaded.dispatch();
            return;
         }
         catch(e:Error)
         {
            MyNK.ey.user.track("COULDNTREADPROFILE","null",1,"null","null",true);
            return;
         }
      }
      
      public function save() : void
      {
      }
      
      public function saveDefaults() : void
      {
         this.resetDefault();
         this.save();
      }
      
      public function isTowerUnlocked(param1:int) : Boolean
      {
         var _loc2_:int = 0;
         while(_loc2_ < this.towersUnlocked.length)
         {
            if(param1 == this.towersUnlocked[_loc2_])
            {
               return true;
            }
            _loc2_++;
         }
         return false;
      }
      
      public function unlockTower(param1:int) : void
      {
         var _loc2_:int = 0;
         while(_loc2_ < this.towersUnlocked.length)
         {
            if(param1 == this.towersUnlocked[_loc2_])
            {
               return;
            }
            _loc2_++;
         }
         this.towersUnlocked.push(param1);
         this.needsToSave = true;
      }
      
      public function isTowerTier4Unlocked(param1:int) : Boolean
      {
         var _loc2_:int = 0;
         while(_loc2_ < this.towerTier4sUnlocked.length)
         {
            if(param1 == this.towerTier4sUnlocked[_loc2_])
            {
               return true;
            }
            _loc2_++;
         }
         return false;
      }
      
      public function unlockTowerTier4(param1:int) : void
      {
         var _loc2_:int = 0;
         while(_loc2_ < this.towerTier4sUnlocked.length)
         {
            if(param1 == this.towerTier4sUnlocked[_loc2_])
            {
               return;
            }
            _loc2_++;
         }
         this.towerTier4sUnlocked.push(param1);
         this.needsToSave = true;
      }
      
      public function initialiseEnergyConductors() : void
      {
         MyNK.ey.addEventListener(Msg.SERVER_TIME,this.updateEnergyLevels);
         MyNK.ey.getServerTime();
      }
      
      private function updateEnergyLevels(param1:*) : void
      {
         MyNK.ey.removeEventListener(Msg.SERVER_TIME,this.updateEnergyLevels);
         this.currentTime = param1.payload;
         if(this.lastEnergyGainTime == -1)
         {
            this.lastEnergyGainTime = this.currentTime;
         }
         var _loc2_:int = int((this.currentTime - this.lastEnergyGainTime) / Balance.instance.ENERGY_REGEN_TIME.v);
         this.currentEnergy = this.currentEnergy + _loc2_;
         if(this.currentEnergy >= this.maxEnergy)
         {
            this.currentEnergy = this.maxEnergy;
            this.lastEnergyGainTime = -1;
         }
         else
         {
            this.lastEnergyGainTime = this.lastEnergyGainTime + _loc2_ * Balance.instance.ENERGY_REGEN_TIME.v;
         }
         this.needsToSave = true;
         this.energyInitzed = true;
      }
      
      public function process(param1:Number) : void
      {
         if(this.needsToSave)
         {
            this.save();
            this.needsToSave = false;
         }
         if(!this.energyInitzed)
         {
            return;
         }
         if(this.currentEnergy > this.maxEnergy)
         {
            this.currentEnergy = this.maxEnergy;
            this.lastEnergyGainTime = -1;
            this.needsToSave = true;
         }
         else if(this.currentEnergy < this.maxEnergy)
         {
            if(this.lastEnergyGainTime == -1 && !this.settingGainTime)
            {
               MyNK.ey.addEventListener(Msg.SERVER_TIME,this.setEnergyGainTime);
               MyNK.ey.getServerTime();
               this.settingGainTime = true;
            }
            else
            {
               if(this.addingEnergy)
               {
                  return;
               }
               this.currentTime = this.currentTime + param1;
               if(this.currentTime - this.lastEnergyGainTime > Balance.instance.ENERGY_REGEN_TIME.v)
               {
                  MyNK.ey.addEventListener(Msg.SERVER_TIME,this.confirmAddEnergy);
                  MyNK.ey.getServerTime();
                  this.addingEnergy = true;
               }
            }
         }
      }
      
      private function confirmAddEnergy(param1:*) : void
      {
         this.addingEnergy = false;
         MyNK.ey.removeEventListener(Msg.SERVER_TIME,this.confirmAddEnergy);
         this.currentTime = param1.payload;
         if(this.currentTime - this.lastEnergyGainTime > Balance.instance.ENERGY_REGEN_TIME.v)
         {
            this.currentEnergy = this.currentEnergy + 1;
            this.lastEnergyGainTime = this.currentTime;
            if(this.currentEnergy == this.maxEnergy)
            {
               this.lastEnergyGainTime = -1;
            }
            this.needsToSave = true;
         }
      }
      
      public function useEnergy(param1:int) : void
      {
         this.currentEnergy = this.currentEnergy - param1;
         this.needsToSave = true;
      }
      
      public function addEnergy(param1:int) : void
      {
         this.currentEnergy = this.currentEnergy + param1;
         if(this.currentEnergy > this.maxEnergy)
         {
            this.currentEnergy = this.maxEnergy;
            this.lastEnergyGainTime = -1;
         }
         this.needsToSave = true;
      }
      
      private function setEnergyGainTime(param1:*) : void
      {
         this.settingGainTime = false;
         MyNK.ey.removeEventListener(Msg.SERVER_TIME,this.setEnergyGainTime);
         this.currentTime = param1.payload;
         this.lastEnergyGainTime = this.currentTime;
         this.needsToSave = true;
      }
      
      public function increaseMaxEnergyBy(param1:int) : void
      {
         this.maxEnergy = this.maxEnergy + param1;
         this.currentEnergy = this.currentEnergy + param1;
         this.needsToSave = true;
      }
      
      public function getSecondsUntilEnergyIncrement() : Number
      {
         if(this.lastEnergyGainTime == -1)
         {
            return 0;
         }
         return this.lastEnergyGainTime + Balance.instance.ENERGY_REGEN_TIME.v - this.currentTime;
      }
      
      private function updateSoundButtons() : void
      {
         MaxSound.isAudable = this.sfxOn_;
         BGM.isAudable = this.bgmOn_;
      }
      
      public function applyPurchasedItem(param1:int) : void
      {
         var _loc2_:TowerPickerDef = null;
         switch(param1)
         {
            case 1:
               this.addEnergy(50);
               break;
            case 2:
               this.addEnergy(100);
               break;
            case 3:
               this.addEnergy(500);
               break;
            case 4:
               this.addEnergy(1000);
               break;
            case 5:
               this.increaseMaxEnergyBy(10);
               break;
            case 6:
               this.increaseMaxEnergyBy(10);
               break;
            case 7:
               this.increaseMaxEnergyBy(500);
               break;
            case 8:
               this.medallions = this.medallions + 100;
               break;
            case 9:
               this.medallions = this.medallions + 500;
               break;
            case 10:
               this.medallions = this.medallions + 2000;
               break;
            case 11:
               this.towersUnlocked = new Vector.<int>();
               this.towerTier4sUnlocked = new Vector.<int>();
               for each(_loc2_ in Main.instance.towerMenuSet.towersInMenu)
               {
                  this.towersUnlocked.push(_loc2_.id);
                  this.towerTier4sUnlocked.push(_loc2_.id);
               }
         }
         this.shopItemUses[param1]++;
         this.needsToSave = true;
      }
      
      public function get currentEnergy() : int
      {
         return this.currentEnergy_.value;
      }
      
      public function set currentEnergy(param1:int) : void
      {
         if(this.currentEnergy_.value == param1)
         {
            return;
         }
         this.currentEnergy_.value = param1;
         this.sigEnergyChanged.dispatch(param1);
      }
      
      public function get maxEnergy() : int
      {
         return this.maxEnergy_.value;
      }
      
      public function set maxEnergy(param1:int) : void
      {
         if(this.maxEnergy_.value == param1)
         {
            return;
         }
         this.maxEnergy_.value = param1;
         this.sigMaxEnergyChanged.dispatch(param1);
      }
      
      public function get lastEnergyGainTime() : Number
      {
         return this.lastEnergyGainTime_.value;
      }
      
      public function set lastEnergyGainTime(param1:Number) : void
      {
         this.lastEnergyGainTime_.value = param1;
      }
      
      public function get medallions() : int
      {
         return this.medallions_.value;
      }
      
      public function set medallions(param1:int) : void
      {
         if(this.medallions_.value == param1)
         {
            return;
         }
         this.medallions_.value = param1;
         this.sigMedallionsChanged.dispatch(param1);
      }
      
      public function get battleScore() : Number
      {
         return this.battleScore_.value;
      }
      
      public function set battleScore(param1:Number) : void
      {
         if(this.battleScore_.value == param1)
         {
            return;
         }
         this.battleScore_.value = param1;
         this.sigBattleScoreChanged.dispatch(param1);
      }
      
      public function get gamesPlayed() : int
      {
         return this.gamesPlayed_.value;
      }
      
      public function set gamesPlayed(param1:int) : void
      {
         this.gamesPlayed_.value = param1;
      }
      
      public function get wins() : int
      {
         return this.wins_.value;
      }
      
      public function set wins(param1:int) : void
      {
         this.wins_.value = param1;
      }
      
      public function get losses() : int
      {
         return this.losses_.value;
      }
      
      public function set losses(param1:int) : void
      {
         this.losses_.value = param1;
      }
      
      public function get disconnects() : int
      {
         return this.disconnects_.value;
      }
      
      public function set disconnects(param1:int) : void
      {
         this.disconnects_.value = param1;
      }
      
      public function get decalsUnlocked() : Vector.<int>
      {
         return this.decalsUnlocked_;
      }
      
      public function set decalsUnlocked(param1:Vector.<int>) : void
      {
         this.decalsUnlocked_ = param1;
      }
      
      public function get towersUnlocked() : Vector.<int>
      {
         return this.towersUnlocked_;
      }
      
      public function set towersUnlocked(param1:Vector.<int>) : void
      {
         this.towersUnlocked_ = param1;
      }
      
      public function get towerTier4sUnlocked() : Vector.<int>
      {
         return this.towerTier4sUnlocked_;
      }
      
      public function set towerTier4sUnlocked(param1:Vector.<int>) : void
      {
         this.towerTier4sUnlocked_ = param1;
      }
      
      public function get shopItemUses() : Vector.<int>
      {
         return this.shopItemUses_;
      }
      
      public function set shopItemUses(param1:Vector.<int>) : void
      {
         this.shopItemUses_ = param1;
      }
      
      public function get bgmOn() : Boolean
      {
         return this.bgmOn_;
      }
      
      public function set bgmOn(param1:Boolean) : void
      {
         this.bgmOn_ = param1;
      }
      
      public function get sfxOn() : Boolean
      {
         return this.sfxOn_;
      }
      
      public function set sfxOn(param1:Boolean) : void
      {
         this.sfxOn_ = param1;
      }
      
      public function SigProfileReloaded() : Signal
      {
         return this.sigProfileReloaded;
      }
      
      public function SigBattleScoreChanged() : Signal
      {
         return this.sigBattleScoreChanged;
      }
      
      public function SigMedallionsChanged() : Signal
      {
         return this.sigMedallionsChanged;
      }
      
      public function SigEnergyChanged() : Signal
      {
         return this.sigEnergyChanged;
      }
      
      public function SigMaxEnergyChanged() : Signal
      {
         return this.sigMaxEnergyChanged;
      }
   }
}

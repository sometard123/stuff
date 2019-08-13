package ninjakiwi.monkeyTown.sound
{
   import assets.sounds.AlertSound;
   import assets.sounds.AttackSound;
   import assets.sounds.BeaconClick;
   import assets.sounds.BeaconOpen;
   import assets.sounds.BountyCardClick;
   import assets.sounds.BuildSound;
   import assets.sounds.ClickSound;
   import assets.sounds.CollectBloontoniumSound;
   import assets.sounds.CollectCardSound;
   import assets.sounds.CollectGoldSound;
   import assets.sounds.DemolishSound;
   import assets.sounds.ErrorSound;
   import assets.sounds.LevelUpSound;
   import assets.sounds.LosePopUpSound;
   import assets.sounds.LoseSound;
   import assets.sounds.MilestoneRewardSound;
   import assets.sounds.MonkeyKnowledgeChestOpen1;
   import assets.sounds.MonkeyKnowledgeChestOpen2;
   import assets.sounds.MonkeyKnowledgeRevealCardClick;
   import assets.sounds.MonkeyKnowledgeRevealCardCommon;
   import assets.sounds.MonkeyKnowledgeRevealCardLegendary;
   import assets.sounds.MonkeyKnowledgeRevealCardRare;
   import assets.sounds.MonkeyKnowledgeRevealCardUncommon;
   import assets.sounds.OpenPanel;
   import assets.sounds.OpenQuest;
   import assets.sounds.Particle1;
   import assets.sounds.Particle2;
   import assets.sounds.Particle3;
   import assets.sounds.Particle4;
   import assets.sounds.ParticleRain1;
   import assets.sounds.ParticleRain2;
   import assets.sounds.ParticleRain3;
   import assets.sounds.ParticleRain4;
   import assets.sounds.ParticleRain5;
   import assets.sounds.ParticleRain6;
   import assets.sounds.PoofCardSound;
   import assets.sounds.QuestCompleteSound;
   import assets.sounds.QuestNewSound;
   import assets.sounds.RollOverSound;
   import assets.sounds.SecretBonus1;
   import assets.sounds.SecretBonus2;
   import assets.sounds.SecretBonus3;
   import assets.sounds.SecretBonus4;
   import assets.sounds.SecretBonus5;
   import assets.sounds.SecretClicked;
   import assets.sounds.SecretExplode;
   import assets.sounds.SecretLoop;
   import assets.sounds.VictorySound;
   import assets.sounds.WinPopUpSound;
   import assets.sounds.XPRewardSound;
   import com.greensock.plugins.TweenPlugin;
   import com.greensock.plugins.VolumePlugin;
   import flash.utils.getTimer;
   import flash.utils.setTimeout;
   import ninjakiwi.monkeyTown.common.audio.AudioState;
   import ninjakiwi.monkeyTown.data.ResourceStore;
   import ninjakiwi.monkeyTown.net.kloud.Kloud;
   import ninjakiwi.monkeyTown.town.bmcEvents.GameSignals;
   import ninjakiwi.monkeyTown.town.buildings.Building;
   import ninjakiwi.monkeyTown.town.monkeyCityMain.MonkeyCityMain;
   import ninjakiwi.monkeyTown.town.monkeyCityMain.MonkeyCityMainSignals;
   import ninjakiwi.monkeyTown.town.monkeyCityMain.WorldViewSignals;
   import ninjakiwi.monkeyTown.town.quests.task.Quest;
   import ninjakiwi.monkeyTown.town.ui.LevelUpPanel;
   import ninjakiwi.monkeyTown.town.ui.QuestCompletePanel;
   import ninjakiwi.monkeyTown.ui.buttons.ButtonControllerBase;
   import treefortress.sound.SoundAS;
   import treefortress.sound.SoundInstance;
   
   public class MCSound
   {
      
      public static var enabled:Boolean = true;
      
      public static const ALERT:String = "alert";
      
      public static const ATTACK:String = "attack";
      
      public static const BUILD:String = "build";
      
      public static const DEMOLISH:String = "demolish";
      
      public static const CLICK:String = "click";
      
      public static const COLLECT_GOLD:String = "collectGold";
      
      public static const COLLECT_BLOONTONIUM:String = "collectBloontonium";
      
      public static const ERROR:String = "error";
      
      public static const LEVEL_UP:String = "levelUp";
      
      public static const EARN_XP:String = "earnXP";
      
      public static const QUEST_COMPLETE:String = "questComplete";
      
      public static const NEW_QUEST:String = "newQuest";
      
      public static const ROLLOVER:String = "rollover";
      
      public static const LOSE:String = "lose";
      
      public static const LOSE_TILE_GRAPHIC:String = "loseTileGraphic";
      
      public static const VICTORY:String = "victory";
      
      public static const VICTORY_TILE_GRAPHIC:String = "victoryTileGraphic";
      
      public static const OPEN_PANEL:String = "openPanel";
      
      public static const OPEN_QUEST_PANEL:String = "openQuestPanel";
      
      public static const MILESTONE_REWARD:String = "milestoneReward";
      
      public static const KNOWLEDGE_REVEAL_CARD_COMMON:String = "knowledgeRevealCardCommon";
      
      public static const KNOWLEDGE_REVEAL_CARD_UNCOMMON:String = "knowledgeRevealCardUncommon";
      
      public static const KNOWLEDGE_REVEAL_CARD_RARE:String = "knowledgeRevealCardRare";
      
      public static const KNOWLEDGE_REVEAL_CARD_LEGENDARY:String = "knowledgeRevealCardLegendary";
      
      public static const KNOWLEDGE_REVEAL_CHEST_OPEN_1:String = "knowledgeChestOpen1";
      
      public static const KNOWLEDGE_REVEAL_CHEST_OPEN_2:String = "knowledgeChestOpen2";
      
      public static const KNOWLEDGE_REVEAL_CARD_CLICK:String = "knowledgeRevealCardClick";
      
      public static const KNOWLEDGE_CARD_POOF:String = "poofCardSound";
      
      public static const KNOWLEDGE_CARD_BURST:String = "knowledgeCardBurst";
      
      public static const KNOWLEDGE_PARTICLE_1:String = "particle1";
      
      public static const KNOWLEDGE_PARTICLE_2:String = "particle2";
      
      public static const KNOWLEDGE_PARTICLE_3:String = "particle3";
      
      public static const KNOWLEDGE_PARTICLE_4:String = "particle4";
      
      public static const BEACON_CLICK:String = "beaconClick";
      
      public static const BEACON_OPEN:String = "beaconOpen";
      
      public static const SECRET_BONUS1:String = "secret_bonus_1";
      
      public static const SECRET_BONUS2:String = "secret_bonus_2";
      
      public static const SECRET_BONUS3:String = "secret_bonus_3";
      
      public static const SECRET_BONUS4:String = "secret_bonus_4";
      
      public static const SECRET_BONUS5:String = "secret_bonus_5";
      
      public static const SECRET_FLIPPED:String = "secret_flipped";
      
      public static const SECRET_CRACKLE_LOOP:String = "secret_crackle_loop";
      
      public static const SECRET_EXPLODE:String = "secret_explode";
      
      public static const BOUNTY_FLIPPED:String = "bounty_flipped";
      
      private static var _instance:MCSound;
       
      
      private var _frequencyLimiter:EventFrequencyLimiter;
      
      private var _musicVolume:Number = 1;
      
      private var _monkeyCityMainSignals:MonkeyCityMainSignals;
      
      private var _enableCityDevelopmentSounds:Boolean = true;
      
      public function MCSound(param1:SingletonBlocker#1690)
      {
         this._frequencyLimiter = new EventFrequencyLimiter();
         this._monkeyCityMainSignals = MonkeyCityMain.getInstance().signals;
         super();
         if(param1 == null)
         {
            throw new Error("Error: Instantiation failed: Use MCSound.getInstance() instead of new.");
         }
         this.init();
      }
      
      public static function getInstance() : MCSound
      {
         if(_instance == null)
         {
            _instance = new MCSound(new SingletonBlocker#1690());
         }
         return _instance;
      }
      
      private function init() : void
      {
         SoundAS.addSound(ALERT,new AlertSound());
         SoundAS.addSound(ATTACK,new AttackSound());
         SoundAS.addSound(BUILD,new BuildSound());
         SoundAS.addSound(DEMOLISH,new DemolishSound());
         SoundAS.addSound(CLICK,new ClickSound());
         SoundAS.addSound(COLLECT_GOLD,new CollectGoldSound());
         SoundAS.addSound(COLLECT_BLOONTONIUM,new CollectBloontoniumSound());
         SoundAS.addSound(ERROR,new ErrorSound());
         SoundAS.addSound(LEVEL_UP,new LevelUpSound());
         SoundAS.addSound(QUEST_COMPLETE,new QuestCompleteSound());
         SoundAS.addSound(NEW_QUEST,new QuestNewSound());
         SoundAS.addSound(ROLLOVER,new RollOverSound());
         SoundAS.addSound(LOSE,new LoseSound());
         SoundAS.addSound(LOSE_TILE_GRAPHIC,new LosePopUpSound());
         SoundAS.addSound(VICTORY,new VictorySound());
         SoundAS.addSound(VICTORY_TILE_GRAPHIC,new WinPopUpSound());
         SoundAS.addSound(OPEN_PANEL,new OpenPanel());
         SoundAS.addSound(OPEN_QUEST_PANEL,new OpenQuest());
         SoundAS.addSound(EARN_XP,new XPRewardSound());
         SoundAS.addSound(MILESTONE_REWARD,new MilestoneRewardSound());
         SoundAS.addSound(KNOWLEDGE_REVEAL_CARD_COMMON,new MonkeyKnowledgeRevealCardCommon());
         SoundAS.addSound(KNOWLEDGE_REVEAL_CARD_UNCOMMON,new MonkeyKnowledgeRevealCardUncommon());
         SoundAS.addSound(KNOWLEDGE_REVEAL_CARD_RARE,new MonkeyKnowledgeRevealCardRare());
         SoundAS.addSound(KNOWLEDGE_REVEAL_CARD_LEGENDARY,new MonkeyKnowledgeRevealCardLegendary());
         SoundAS.addSound(KNOWLEDGE_REVEAL_CHEST_OPEN_1,new MonkeyKnowledgeChestOpen1());
         SoundAS.addSound(KNOWLEDGE_REVEAL_CHEST_OPEN_2,new MonkeyKnowledgeChestOpen2());
         SoundAS.addSound(KNOWLEDGE_REVEAL_CARD_CLICK,new MonkeyKnowledgeRevealCardClick());
         SoundAS.addSound(KNOWLEDGE_CARD_BURST,new CollectCardSound());
         SoundAS.addSound(KNOWLEDGE_PARTICLE_1,new Particle1());
         SoundAS.addSound(KNOWLEDGE_PARTICLE_2,new Particle2());
         SoundAS.addSound(KNOWLEDGE_PARTICLE_3,new Particle3());
         SoundAS.addSound(KNOWLEDGE_PARTICLE_4,new Particle4());
         SoundAS.addSound(KNOWLEDGE_CARD_POOF,new PoofCardSound());
         SoundAS.addSound("ParticleRain1",new ParticleRain1());
         SoundAS.addSound("ParticleRain2",new ParticleRain2());
         SoundAS.addSound("ParticleRain3",new ParticleRain3());
         SoundAS.addSound("ParticleRain4",new ParticleRain4());
         SoundAS.addSound("ParticleRain5",new ParticleRain5());
         SoundAS.addSound("ParticleRain6",new ParticleRain6());
         SoundAS.addSound(BEACON_CLICK,new BeaconClick());
         SoundAS.addSound(BEACON_OPEN,new BeaconOpen());
         SoundAS.addSound(SECRET_BONUS1,new SecretBonus1());
         SoundAS.addSound(SECRET_BONUS2,new SecretBonus2());
         SoundAS.addSound(SECRET_BONUS3,new SecretBonus3());
         SoundAS.addSound(SECRET_BONUS4,new SecretBonus4());
         SoundAS.addSound(SECRET_BONUS5,new SecretBonus5());
         SoundAS.addSound(SECRET_FLIPPED,new SecretClicked());
         SoundAS.addSound(SECRET_CRACKLE_LOOP,new SecretLoop());
         SoundAS.addSound(BOUNTY_FLIPPED,new BountyCardClick());
         SoundAS.addSound(SECRET_EXPLODE,new SecretExplode());
         TweenPlugin.activate([VolumePlugin]);
         this.addListeners();
         this._frequencyLimiter.registerEvent(NEW_QUEST,1,1000);
      }
      
      public function addListeners() : void
      {
         Building.buildingWasPlacedSignal.add(this.onBuildingWasPlacedSignal);
         LevelUpPanel.revealedSignal.add(this.onLevelUpPanelRevealSignal);
         Quest.QUEST_GIVEN_SIGNAL.add(this.onQuestGivenSignal);
         QuestCompletePanel.revealedSignal.add(this.onQuestCompletePanelRevealSignal);
         ButtonControllerBase.buttonWasClickedSignal.add(this.onButtonClickedSignal);
         Kloud.loadCoreDataBeginSignal.add(this.disableCityDevelopmentSounds);
         this._monkeyCityMainSignals.buildWorldStartSignal.add(this.disableCityDevelopmentSounds);
         this._monkeyCityMainSignals.loadCityAllCompleteSignal.add(this.enableCityDevelopmentSounds);
         GameSignals.BTD_GAME_LOST_SIGNAL.add(this.onBTDGameLostSignal);
         ResourceStore.getInstance().monkeyMoneyChangedDiffSignal.add(this.onMonkeyMoneyIncreasedSignal);
         ResourceStore.getInstance().bloontoniumChangedDiffSignal.add(this.onBloontoniumIncreasedSignal);
         WorldViewSignals.buildWorldStartSignal.add(this.onBuildWorldBegin);
         WorldViewSignals.buildWorldEndSignal.add(this.onBuildWorldEnd);
      }
      
      public function playSound(param1:String, param2:Number = 1, param3:Boolean = false) : SoundInstance
      {
         if(!enabled)
         {
            return null;
         }
         if(AudioState.sfxIsMuted)
         {
            return null;
         }
         var _loc4_:SoundInstance = null;
         if(param3)
         {
            _loc4_ = SoundAS.playLoop(param1,param2);
         }
         else
         {
            _loc4_ = SoundAS.playFx(param1,param2);
         }
         return _loc4_;
      }
      
      public function playDelayedSound(param1:String, param2:Number = 1, param3:Number = 0) : void
      {
         var key:String = param1;
         var volume:Number = param2;
         var delay:Number = param3;
         setTimeout(function():void
         {
            playSound(key,volume);
         },1000 * delay);
      }
      
      private function enableCityDevelopmentSounds(... rest) : void
      {
         this._enableCityDevelopmentSounds = true;
      }
      
      private function disableCityDevelopmentSounds(... rest) : void
      {
         this._enableCityDevelopmentSounds = false;
      }
      
      private function onPanelRevealBeginSignal() : void
      {
         this.playSound(ALERT);
      }
      
      private function onBuildingWasPlacedSignal(param1:Building) : void
      {
         if(this._enableCityDevelopmentSounds)
         {
            this.playSound(BUILD);
         }
      }
      
      private function onLevelUpPanelRevealSignal(... rest) : void
      {
         if(this._enableCityDevelopmentSounds)
         {
            this.playSound(LEVEL_UP);
         }
      }
      
      private function onMonkeyMoneyIncreasedSignal(param1:int, param2:Boolean = true) : void
      {
         if(param2 && this._enableCityDevelopmentSounds)
         {
            this.playSound(COLLECT_GOLD);
         }
      }
      
      private function onBloontoniumIncreasedSignal(... rest) : void
      {
         if(this._enableCityDevelopmentSounds)
         {
            this.playSound(COLLECT_BLOONTONIUM);
         }
      }
      
      private function onButtonClickedSignal() : void
      {
         this.playSound(CLICK,0.5);
      }
      
      private function onMouseHoveredBuildingSignal(param1:Building = null) : void
      {
         this.playSound(ROLLOVER);
      }
      
      private function onBTDGameLostSignal(... rest) : void
      {
         this.playDelayedSound(LOSE,1,0.3);
      }
      
      private function onBTDGameWonSignal(... rest) : void
      {
         this.playDelayedSound(VICTORY,1,0.3);
      }
      
      private function onQuestGivenSignal(... rest) : void
      {
         if(this._frequencyLimiter.permit(NEW_QUEST,getTimer()))
         {
            this.playSound(NEW_QUEST,0.3);
         }
      }
      
      private function onQuestCompletePanelRevealSignal(... rest) : void
      {
         this.playDelayedSound(QUEST_COMPLETE,1,0.3);
      }
      
      private function onBuildWorldBegin() : void
      {
         enabled = false;
      }
      
      private function onBuildWorldEnd() : void
      {
         enabled = true;
      }
   }
}

class SingletonBlocker#1690
{
    
   
   function SingletonBlocker#1690()
   {
      super();
   }
}

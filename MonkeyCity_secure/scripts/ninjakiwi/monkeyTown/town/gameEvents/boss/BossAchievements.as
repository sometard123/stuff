package ninjakiwi.monkeyTown.town.gameEvents.boss
{
   import ninjakiwi.monkeyTown.achievements.AchievementsManager;
   import ninjakiwi.monkeyTown.data.KeyValueStore;
   import ninjakiwi.monkeyTown.pvp.PvPTimerManager;
   import org.osflash.signals.Signal;
   
   public class BossAchievements
   {
       
      
      private const DATA_KEY:String = "boss_achievements_data2";
      
      private const BLOONARIUS_KEY:String = "Bloonarius";
      
      private const VORTEX_KEY:String = "Vortex";
      
      private const DREADBLOON_KEY:String = "Dreadbloon";
      
      private const BLASTAPOPOULOS_KEY:String = "Blastapopoulos";
      
      private var _data:Object = null;
      
      private var _isReady:Boolean = false;
      
      private var _achievementsManager:AchievementsManager;
      
      public const dataChangedSignal:Signal = new Signal();
      
      public function BossAchievements()
      {
         super();
         if(KeyValueStore.getInstance().hasBeenInitialised)
         {
            this.init();
         }
         else
         {
            KeyValueStore.getInstance().readySignal.addOnce(this.init);
         }
      }
      
      private function save() : void
      {
         if(false === this._isReady)
         {
            return;
         }
         KeyValueStore.getInstance().set(this.DATA_KEY,this._data);
      }
      
      private function init() : void
      {
         KeyValueStore.getInstance().get(this.DATA_KEY,function(param1:Object):void
         {
            if(param1 === null)
            {
               _data = {"anyBossKillCount":0};
            }
            else
            {
               _data = param1;
            }
            t.obj(_data);
            _isReady = true;
         });
      }
      
      public function killedBoss(param1:String, param2:int) : void
      {
         if(false === this._isReady)
         {
            return;
         }
         if(false === this._data.hasOwnProperty(param1))
         {
            this._data[param1] = {
               "killCountsAllTime":0,
               "lastLevelKilled":param2
            };
         }
         _loc3_.anyBossKillCount = _loc4_;
         this._data[param1].killCountsAllTime++;
         this._data[param1].lastLevelKilled = param2;
         this.save();
         this.checkAchievements(param1,this._data[param1].killCountsAllTime,this._data.anyBossKillCount,param2);
      }
      
      private function checkAchievements(param1:String, param2:int, param3:int, param4:int) : void
      {
         if(param1 === this.BLOONARIUS_KEY)
         {
            if(param4 >= 1)
            {
               AchievementsManager.getInstance().setAchievementProgress(AchievementsManager.getInstance().BLOONARIUS_LEVEL_1);
            }
            if(param4 >= 10)
            {
               AchievementsManager.getInstance().setAchievementProgress(AchievementsManager.getInstance().BLOONARIUS_LEVEL_10);
            }
            if(param4 >= 15)
            {
               AchievementsManager.getInstance().setAchievementProgress(AchievementsManager.getInstance().BLOONARIUS_LEVEL_15);
            }
            if(param4 >= 20)
            {
               AchievementsManager.getInstance().setAchievementProgress(AchievementsManager.getInstance().BLOONARIUS_LEVEL_20);
            }
            if(param4 >= 25)
            {
               AchievementsManager.getInstance().setAchievementProgress(AchievementsManager.getInstance().BLOONARIUS_LEVEL_25);
            }
            AchievementsManager.getInstance().setAchievementProgress(AchievementsManager.getInstance().BLOONARIUS_75_TIMES,Math.ceil(param2 / 75 * 100));
         }
         else if(param1 === this.VORTEX_KEY)
         {
            if(param4 >= 1)
            {
               AchievementsManager.getInstance().setAchievementProgress(AchievementsManager.getInstance().VORTEX_LEVEL_1);
            }
            if(param4 >= 10)
            {
               AchievementsManager.getInstance().setAchievementProgress(AchievementsManager.getInstance().VORTEX_LEVEL_10);
            }
            if(param4 >= 15)
            {
               AchievementsManager.getInstance().setAchievementProgress(AchievementsManager.getInstance().VORTEX_LEVEL_15);
            }
            if(param4 >= 20)
            {
               AchievementsManager.getInstance().setAchievementProgress(AchievementsManager.getInstance().VORTEX_LEVEL_20);
            }
            if(param4 >= 25)
            {
               AchievementsManager.getInstance().setAchievementProgress(AchievementsManager.getInstance().VORTEX_LEVEL_25);
            }
            AchievementsManager.getInstance().setAchievementProgress(AchievementsManager.getInstance().VORTEX_75_TIMES,Math.ceil(param2 / 75 * 100));
         }
         else if(param1 === this.DREADBLOON_KEY)
         {
            if(param4 >= 1)
            {
               AchievementsManager.getInstance().setAchievementProgress(AchievementsManager.getInstance().DREADBLOON_LEVEL_1);
            }
            if(param4 >= 10)
            {
               AchievementsManager.getInstance().setAchievementProgress(AchievementsManager.getInstance().DREADBLOON_LEVEL_10);
            }
            if(param4 >= 15)
            {
               AchievementsManager.getInstance().setAchievementProgress(AchievementsManager.getInstance().DREADBLOON_LEVEL_15);
            }
            if(param4 >= 20)
            {
               AchievementsManager.getInstance().setAchievementProgress(AchievementsManager.getInstance().DREADBLOON_LEVEL_20);
            }
            if(param4 >= 25)
            {
               AchievementsManager.getInstance().setAchievementProgress(AchievementsManager.getInstance().DREADBLOON_LEVEL_25);
            }
            AchievementsManager.getInstance().setAchievementProgress(AchievementsManager.getInstance().DREADBLOON_75_TIMES,Math.ceil(param2 / 75 * 100));
         }
         else if(param1 === this.BLASTAPOPOULOS_KEY)
         {
            if(param4 >= 1)
            {
               AchievementsManager.getInstance().setAchievementProgress(AchievementsManager.getInstance().BLASTAPOPOULOS_LEVEL_1);
            }
            if(param4 >= 10)
            {
               AchievementsManager.getInstance().setAchievementProgress(AchievementsManager.getInstance().BLASTAPOPOULOS_LEVEL_10);
            }
            if(param4 >= 15)
            {
               AchievementsManager.getInstance().setAchievementProgress(AchievementsManager.getInstance().BLASTAPOPOULOS_LEVEL_15);
            }
            if(param4 >= 20)
            {
               AchievementsManager.getInstance().setAchievementProgress(AchievementsManager.getInstance().BLASTAPOPOULOS_LEVEL_20);
            }
            if(param4 >= 25)
            {
               AchievementsManager.getInstance().setAchievementProgress(AchievementsManager.getInstance().BLASTAPOPOULOS_LEVEL_25);
            }
            AchievementsManager.getInstance().setAchievementProgress(AchievementsManager.getInstance().BLASTAPOPOULOS_75_TIMES,Math.ceil(param2 / 75 * 100));
         }
         AchievementsManager.getInstance().setAchievementProgress(AchievementsManager.getInstance().BOSS_ANY_75_TIMES,Math.ceil(param3 / 75 * 100));
         AchievementsManager.getInstance().setAchievementProgress(AchievementsManager.getInstance().BOSS_ANY_150_TIMES,Math.ceil(param3 / 150 * 100));
      }
   }
}

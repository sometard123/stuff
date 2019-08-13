package ninjakiwi.monkeyTown.town.gameEvents.boss
{
   import assets.ui.BlastapopoulosAvatarClip;
   import assets.ui.BlastapopoulosDeadAvatarClip;
   import assets.ui.BloonBossBlastapopoulosIcon;
   import assets.ui.BloonBossBloonariusIcon;
   import assets.ui.BloonBossDreadbloonIcon;
   import assets.ui.BloonBossVortexIcon;
   import assets.ui.BloonariusAvatarClip;
   import assets.ui.BloonariusDeadAvatarClip;
   import assets.ui.DreadbloonAvatarClip;
   import assets.ui.DreadbloonDeadAvatarClip;
   import assets.ui.PlaceholderAvatarClip;
   import assets.ui.PlaceholderIconClip;
   import assets.ui.VortexAvatarClip;
   import assets.ui.VortexDeadAvatarClip;
   import ninjakiwi.monkeyTown.town.gameEvents.GameEventManager;
   import ninjakiwi.monkeyTown.town.gameEvents.GameplayEvent;
   import ninjakiwi.monkeyTown.town.ui.myTrack.MyTrackThumbNailClip;
   import ninjakiwi.monkeyTown.ui.buttons.ButtonControllerBase;
   
   public class BossData
   {
      
      public static const MAX_COST_TO_ATTACK:int = 50000;
      
      private static const bossInternalData:Object = {
         "bloonarius":{
            "icon":BloonBossBloonariusIcon,
            "avatar":BloonariusAvatarClip,
            "deadAvatar":BloonariusDeadAvatarClip,
            "healthModifier":1,
            "deathStatement":"I\'ll be back!"
         },
         "vortex":{
            "icon":BloonBossVortexIcon,
            "avatar":VortexAvatarClip,
            "deadAvatar":VortexDeadAvatarClip,
            "healthModifier":0.45,
            "deathStatement":"You win...\nthis time!"
         },
         "blastapopoulos":{
            "icon":BloonBossBlastapopoulosIcon,
            "avatar":BlastapopoulosAvatarClip,
            "deadAvatar":BlastapopoulosDeadAvatarClip,
            "healthModifier":1,
            "deathStatement":"I shall have\nmy revenge!"
         },
         "dreadbloon":{
            "icon":BloonBossDreadbloonIcon,
            "avatar":DreadbloonAvatarClip,
            "deadAvatar":DreadbloonDeadAvatarClip,
            "healthModifier":0.25,
            "deathStatement":"Watch your back!"
         }
      };
      
      private static var instance:BossData;
       
      
      private var _data:Object = null;
      
      private const MAX_INDEX:int = 19;
      
      private var dreadbloonSpecialHealth:Array;
      
      private var healthIncrements:Array;
      
      public function BossData(param1:SingletonEnforcer#906)
      {
         this.dreadbloonSpecialHealth = [100,200,400,800,1600,3200];
         this.healthIncrements = [2000,2000,2000,2000,2000,4000,4000,4000,6000,8000,12000,16000,20000,24000,28000,34000,40000,46000,52000,58000,66000,74000];
         super();
         if(param1 == null)
         {
            throw new Error("Error: Instantiation failed: Use BossData.getInstance() instead of new.");
         }
      }
      
      public static function getInstance() : BossData
      {
         if(instance == null)
         {
            instance = new BossData(new SingletonEnforcer#906());
         }
         return instance;
      }
      
      public function setData(param1:Object) : void
      {
         this._data = param1;
      }
      
      public function getCostToAttack(param1:int, param2:int) : Number
      {
         if(param2 < 1)
         {
            param2 = 1;
         }
         else if(param2 > 10)
         {
            param2 = 10;
         }
         return Math.min(Math.pow(param2 - 1,2) * 100 * param1,MAX_COST_TO_ATTACK);
      }
      
      public function getHealthForLevel(param1:int) : int
      {
         var _loc2_:GameplayEvent = GameEventManager.getInstance().bossEventManager.findCurrentEvent();
         if(_loc2_.dataID === "dreadbloon" && param1 <= this.dreadbloonSpecialHealth.length)
         {
            return this.dreadbloonSpecialHealth[param1 - 1];
         }
         var _loc3_:Number = this.getHealthModifer(_loc2_.dataID);
         var _loc4_:int = 0;
         var _loc5_:int = this.healthIncrements.length;
         var _loc6_:int = this.healthIncrements[this.healthIncrements.length - 1];
         var _loc7_:int = 0;
         while(_loc7_ < param1)
         {
            if(_loc7_ < _loc5_)
            {
               _loc4_ = _loc4_ + this.healthIncrements[_loc7_];
            }
            else
            {
               _loc4_ = _loc4_ + (_loc6_ + 8000 * (_loc7_ - _loc5_ + 1));
            }
            _loc7_++;
         }
         return _loc4_ * _loc3_;
      }
      
      public function getBaseHealthForLevel(param1:int) : int
      {
         var _loc2_:int = 0;
         var _loc3_:int = this.healthIncrements.length;
         var _loc4_:int = this.healthIncrements[this.healthIncrements.length - 1];
         var _loc5_:int = 0;
         while(_loc5_ < param1)
         {
            if(_loc5_ < _loc3_)
            {
               _loc2_ = _loc2_ + this.healthIncrements[_loc5_];
            }
            else
            {
               _loc2_ = _loc2_ + (_loc4_ + 8000 * (_loc5_ - _loc3_ + 1));
            }
            _loc5_++;
         }
         return _loc2_;
      }
      
      public function getHealthModifer(param1:String) : Number
      {
         if(bossInternalData.hasOwnProperty(param1) && bossInternalData[param1].hasOwnProperty("healthModifier"))
         {
            return bossInternalData[param1].healthModifier;
         }
         return 1;
      }
      
      public function getAvatarClass(param1:String) : Class
      {
         if(bossInternalData.hasOwnProperty(param1))
         {
            return bossInternalData[param1].avatar;
         }
         return PlaceholderAvatarClip;
      }
      
      public function getDeadAvatarClass(param1:String) : Class
      {
         if(bossInternalData.hasOwnProperty(param1))
         {
            return bossInternalData[param1].deadAvatar;
         }
         return PlaceholderAvatarClip;
      }
      
      public function getLosingStatement(param1:String) : String
      {
         if(bossInternalData.hasOwnProperty(param1))
         {
            return bossInternalData[param1].deathStatement;
         }
         return "I\'ll be back!";
      }
      
      public function getIconClass(param1:String) : Class
      {
         if(bossInternalData.hasOwnProperty(param1))
         {
            return bossInternalData[param1].icon;
         }
         return PlaceholderIconClip;
      }
   }
}

class SingletonEnforcer#906
{
    
   
   function SingletonEnforcer#906()
   {
      super();
   }
}

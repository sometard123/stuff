package ninjakiwi.monkeyTown.btdModule.ingame
{
   import ninjakiwi.monkeyTown.btdModule.towers.Tower;
   import ninjakiwi.monkeyTown.btdModule.towers.TowerFactory;
   import ninjakiwi.monkeyTown.btdModule.towers.TowerPlace;
   import ninjakiwi.monkeyTown.common.btdModule.definitions.BTDGameRequest;
   
   public class MonkeyTeam
   {
       
      
      private var _monkeyTeamTowers:Array = null;
      
      private var _canHaveMonkeyTeamReward:Boolean = false;
      
      public function MonkeyTeam()
      {
         super();
         TowerPlace.towerPlacedSignal.add(this.onTowerPlaced);
      }
      
      public function setRequest(param1:BTDGameRequest) : void
      {
         this._monkeyTeamTowers = param1.monkeyTeamTowers;
         this._canHaveMonkeyTeamReward = true;
      }
      
      public function doesMonkeyTeamExist() : Boolean
      {
         return null != this._monkeyTeamTowers && this._monkeyTeamTowers.length != 0;
      }
      
      public function canHaveMonkeyTeamReward() : Boolean
      {
         if(false == this.doesMonkeyTeamExist())
         {
            return false;
         }
         return this._canHaveMonkeyTeamReward;
      }
      
      public function onTowerPlaced(param1:Tower) : void
      {
         if(false == this.doesMonkeyTeamExist())
         {
            return;
         }
         if(false == Main.instance.towerFactory.isBaseTower(param1.rootID) || param1.rootID == TowerFactory.TOWER_ROADSPIKE || param1.rootID == TowerFactory.TOWER_PINEAPPLE)
         {
            return;
         }
         var _loc2_:Boolean = false;
         var _loc3_:int = 0;
         while(_loc3_ < this._monkeyTeamTowers.length)
         {
            if(this._monkeyTeamTowers[_loc3_] == param1.rootID)
            {
               _loc2_ = true;
               break;
            }
            _loc3_++;
         }
         if(false == _loc2_)
         {
            this._canHaveMonkeyTeamReward = false;
         }
      }
   }
}

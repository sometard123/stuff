package ninjakiwi.monkeyTown.btdModule.abilities.antiBossAbilities
{
   import assets.sounds.PowerBlast;
   import ninjakiwi.monkeyTown.btdModule.abilities.animations.BossBlastBack;
   import ninjakiwi.monkeyTown.btdModule.abilities.antiBossAbilities.def.IAntiBossAbilityBehaviour;
   import ninjakiwi.monkeyTown.btdModule.bloons.Bloon;
   import ninjakiwi.monkeyTown.btdModule.levels.tiles.Tile;
   import ninjakiwi.monkeyTown.btdModule.sound.MaxSound;
   import ninjakiwi.monkeyTown.btdModule.specialTrack.SpecialTrackManager;
   import ninjakiwi.monkeyTown.btdModule.specialTrack.tracks.SpecialTrackBoss;
   
   public class BossBlastBehaviour implements IAntiBossAbilityBehaviour
   {
       
      
      private var _boss:Bloon = null;
      
      private var _bossEntryTile:Tile = null;
      
      private var _normalSpeed:Number = 1;
      
      private const REVERSE_SPEED:Number = -90;
      
      private var _previousTile:Tile;
      
      public function BossBlastBehaviour()
      {
         super();
      }
      
      public function reset() : void
      {
      }
      
      public function update(param1:Number) : void
      {
         if(this._boss !== null)
         {
            if(this._boss.tile.transitionType == Tile.teleport || this._boss.tile.transitionType == Tile.underpass)
            {
               if(this._previousTile !== null)
               {
                  this._boss.tile = this._previousTile;
                  this._boss.tileProgress = 0;
               }
               this.deactivate();
            }
            else if(this._bossEntryTile === this._boss.tile)
            {
               this.deactivate();
            }
            else
            {
               this._previousTile = this._boss.tile;
            }
         }
      }
      
      public function activate() : void
      {
         var _loc2_:BossBlastBack = null;
         var _loc1_:Bloon = SpecialTrackManager.getInstance().getBoss();
         if(_loc1_ !== null)
         {
            this._boss = _loc1_;
            this._bossEntryTile = this.getBossEntryTile();
            this._normalSpeed = _loc1_.progressStep;
            _loc1_.progressStep = this.REVERSE_SPEED;
            _loc1_.isMovingBackward = true;
            _loc1_.damage(BossBaneBehaviour.DAMAGE * 0.3,1,null);
            _loc2_ = BossBlastBack.create();
            _loc2_.x = this._boss.x;
            _loc2_.y = this._boss.y;
            new MaxSound(PowerBlast).play();
         }
      }
      
      public function deactivate() : void
      {
         if(this._boss !== null)
         {
            this._boss.progressStep = this._normalSpeed;
            this._boss.isMovingBackward = false;
            this._boss = null;
         }
      }
      
      private function getBossEntryTile() : Tile
      {
         var _loc1_:SpecialTrackBoss = SpecialTrackManager.getInstance().specialTrack as SpecialTrackBoss;
         if(false === _loc1_ is SpecialTrackBoss)
         {
            return null;
         }
         var _loc2_:SpecialTrackBoss = _loc1_ as SpecialTrackBoss;
         return _loc2_.bossEntryTile;
      }
   }
}

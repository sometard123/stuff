package ninjakiwi.monkeyTown.btdModule.abilities.antiBossAbilities
{
   import assets.sounds.PowerFreeze;
   import flash.events.IOErrorEvent;
   import ninjakiwi.monkeyTown.btdModule.abilities.animations.ChillSpam;
   import ninjakiwi.monkeyTown.btdModule.abilities.antiBossAbilities.def.IAntiBossAbilityBehaviour;
   import ninjakiwi.monkeyTown.btdModule.bloons.Bloon;
   import ninjakiwi.monkeyTown.btdModule.sound.MaxSound;
   import ninjakiwi.monkeyTown.btdModule.specialTrack.SpecialTrackManager;
   
   public class BossChillBehaviour implements IAntiBossAbilityBehaviour
   {
       
      
      private var _bossBloon:Bloon = null;
      
      public function BossChillBehaviour()
      {
         super();
      }
      
      public function reset() : void
      {
      }
      
      public function update(param1:Number) : void
      {
         var _loc2_:ChillSpam = null;
         if(this._bossBloon !== null && Math.random() < 0.9)
         {
            _loc2_ = ChillSpam.create();
            _loc2_.x = this._bossBloon.x + (Math.random() - 0.5) * 130;
            _loc2_.y = this._bossBloon.y + (Math.random() - 0.5) * 130 - 10;
         }
      }
      
      public function activate() : void
      {
         this._bossBloon = SpecialTrackManager.getInstance().getBoss();
         if(this._bossBloon !== null)
         {
            this._bossBloon.isMoving = false;
            new MaxSound(PowerFreeze).play();
         }
      }
      
      public function deactivate() : void
      {
         this._bossBloon = SpecialTrackManager.getInstance().getBoss();
         if(this._bossBloon !== null)
         {
            this._bossBloon.isMoving = true;
         }
      }
   }
}

package ninjakiwi.monkeyTown.btdModule.BSSpecialAbility
{
   import assets.occupiedSpace.Small;
   import assets.projectile.RedHotSpikesClip;
   import com.lgrey.events.LGDataEvent;
   import flash.display.DisplayObjectContainer;
   import flash.display.MovieClip;
   import ninjakiwi.monkeyTown.btdModule.bloons.Bloon;
   import ninjakiwi.monkeyTown.btdModule.ingame.TowerPickerDef;
   import ninjakiwi.monkeyTown.btdModule.projectiles.behavior.BehaviorDef;
   import ninjakiwi.monkeyTown.btdModule.projectiles.behavior.collision.RoadSpikeCollision;
   import ninjakiwi.monkeyTown.btdModule.projectiles.behavior.destroy.RemoveSpikeSpread;
   import ninjakiwi.monkeyTown.btdModule.projectiles.behavior.process.Friction;
   import ninjakiwi.monkeyTown.btdModule.projectiles.def.DamageEffectDef;
   import ninjakiwi.monkeyTown.btdModule.projectiles.def.ProjectileDef;
   import ninjakiwi.monkeyTown.btdModule.towers.Tower;
   import ninjakiwi.monkeyTown.btdModule.towers.TowerPlace;
   import ninjakiwi.monkeyTown.btdModule.towers.behavior.roundStart.SwapForProjectile;
   import ninjakiwi.monkeyTown.btdModule.towers.def.TowerDef;
   import ninjakiwi.monkeyTown.common.Constants;
   
   public class RedHotSpikes extends BSSpecialAbility
   {
      
      private static const OFFSET_X:Number = 51;
      
      private static const OFFSET_Y:Number = -1;
      
      private static const redHotSpikeProjectile:ProjectileDef = new ProjectileDef().Display(assets.projectile.RedHotSpikesClip).Pierce(20).Radius(25).EffectMask(Vector.<int>([Bloon.IMMUNITY_NONE])).Behavior(new ninjakiwi.monkeyTown.btdModule.projectiles.behavior.BehaviorDef().Collision(new RoadSpikeCollision()).Process(new Friction()).Destroy(new RemoveSpikeSpread())).CanMultiEffect(true).DamageEffect(new DamageEffectDef().Damage(1).CanBreakIce(true));
      
      private static const redHotSpikes:TowerDef = new TowerDef(Constants.TOWER_REDHOTSPIKES).Label("Red Hot Spikes").Description("").Display(assets.projectile.RedHotSpikesClip).OccupiedSpace(Small).RangeOfVisibility(20).DetailSmall(null).CanPlaceOnTrack(true).Detail(null).Behavior(new ninjakiwi.monkeyTown.btdModule.towers.behavior.BehaviorDef().RoundStart(new SwapForProjectile().Projectile(redHotSpikeProjectile).Lifespan(999999)));
      
      private static const redHotSpikesTower:TowerPickerDef = new TowerPickerDef().Id(19).Button(null).Tower(redHotSpikes).Cost(0).HotKey(-1);
       
      
      private const _clip:assets.btdmodule.ui.RedHotSpikesClip = new assets.btdmodule.ui.RedHotSpikesClip();
      
      private const _bonusCounterClip:MovieClip = this._clip.bonusCounter;
      
      public function RedHotSpikes(param1:DisplayObjectContainer)
      {
         super(param1,this._clip,"Red Hot Spikes","Stack of 20 red hot spikes.");
         _button.target.x = OFFSET_X;
         _button.target.y = OFFSET_Y;
         this.setBonusCount(0);
         this._clip.counter.visible = false;
         _button.unlock();
         TowerPlace.towerPlacedSignal.add(this.onSpikePlaced);
         Main.instance.eventBridge.addEventListener(Constants.RED_HOT_SPIKES_BALANCE_CHANGED,this.onBonusBalanceChangedHandler);
      }
      
      private function onBonusBalanceChangedHandler(param1:LGDataEvent) : void
      {
         this.setBonusCount(param1.data.balance);
      }
      
      override public function destroy() : void
      {
         super.destroy();
         TowerPlace.towerPlacedSignal.remove(this.onSpikePlaced);
      }
      
      public function get canPlace() : Boolean
      {
         return _bonusCount.value > 0 || Main.instance.game.inGameMenu.bs.value >= _bloonstonesCost.value;
      }
      
      override public function setBonusCount(param1:int) : void
      {
         super.setBonusCount(param1);
         this._bonusCounterClip.counter.text = param1.toString();
         this._bonusCounterClip.visible = param1 > 0;
      }
      
      override public function reset() : void
      {
         super.reset();
      }
      
      override protected function buttonClicked() : void
      {
         this.action();
      }
      
      override protected function consumeBonus() : void
      {
         if(_bonusCount > 0)
         {
            Main.instance.eventBridge.dispatchEvent(new LGDataEvent(Constants.CONSUME_RED_HOT_SPIKES,{"howMany":1}));
         }
         super.consumeBonus();
      }
      
      override protected function action() : void
      {
         if(this.canPlace)
         {
            Main.instance.game.inGameMenu.beginPlacingTower(redHotSpikesTower);
         }
         else
         {
            Main.instance.notEnoughBloonstonesSidePanel.reveal();
         }
      }
      
      private function onSpikePlaced(param1:Tower) : void
      {
         if(param1.rootID == redHotSpikes.id)
         {
            if(this.canPlace)
            {
               if(_bonusCount.value > 0)
               {
                  this.setBonusCount(_bonusCount.value - 1);
                  Main.instance.eventBridge.dispatchEvent(new LGDataEvent(Constants.CONSUME_RED_HOT_SPIKES,{"howMany":1}));
               }
               else
               {
                  spendBloonstones();
               }
               if(false == this.canPlace)
               {
                  Main.instance.game.inGameMenu.stateMachine.changeState(Main.instance.game.inGameMenu.neutral,null);
               }
            }
         }
      }
      
      override protected function onBloonstonesCharged(param1:Boolean, param2:int) : void
      {
         if(param1)
         {
            bloonstonesSpent.dispatch(this);
         }
      }
   }
}

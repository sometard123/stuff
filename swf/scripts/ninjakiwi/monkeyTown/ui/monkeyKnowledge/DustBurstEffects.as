package ninjakiwi.monkeyTown.ui.monkeyKnowledge
{
   import com.lgrey.vectors.LGVector2D;
   import flash.display.MovieClip;
   import flash.display.Stage;
   import flash.events.Event;
   import flash.geom.Rectangle;
   import flash.utils.getTimer;
   import ninjakiwi.monkeyTown.dust.DustSurface;
   import ninjakiwi.monkeyTown.sku.SkuSettingsLoader;
   import ninjakiwi.monkeyTown.sound.MCSound;
   import ninjakiwi.monkeyTown.system.MonkeySystem;
   import ninjakiwi.monkeyTown.town.cityCommon.CityCommonDataManager;
   import ninjakiwi.monkeyTown.town.gameEvents.GameEventManager;
   import ninjakiwi.monkeyTown.town.gameEvents.GameplayEvent;
   import ninjakiwi.monkeyTown.town.gameEvents.ui.MilestoneRewardInfoBox;
   import ninjakiwi.monkeyTown.town.monkeyCityMain.MonkeyCityMain;
   import ninjakiwi.monkeyTown.town.ui.contestedTerritory.ContestedTerritoryPanel;
   import ninjakiwi.monkeyTown.town.ui.manageCitiesPanel.CityInformation;
   import ninjakiwi.monkeyTown.town.ui.newsPanelScroller.NewsPanelScrollerItem;
   import ninjakiwi.sharedFrameAnalyser.AnimationSharedFramesMap;
   
   public class DustBurstEffects extends MovieClip
   {
       
      
      public var goal:LGVector2D;
      
      private var surface:DustSurface;
      
      public var pool:KnowledgeParticlesPool;
      
      public var secretPool:KnowledgeParticlesPool;
      
      public var _stage:Stage;
      
      private var _age:int = 0;
      
      private var _bursts:Vector.<DustBurst>;
      
      private var _burstsForRemoval:Vector.<DustBurst>;
      
      private var _particleHitTimestamp:Number = 0;
      
      private var MIN_PARTICLE_HIT_SOUND_RATE:Number = 20;
      
      public function DustBurstEffects()
      {
         this.goal = new LGVector2D();
         this.surface = new DustSurface();
         this.pool = new KnowledgeParticlesPool();
         this.secretPool = new KnowledgeParticlesPool();
         this._bursts = new Vector.<DustBurst>();
         this._burstsForRemoval = new Vector.<DustBurst>();
         super();
         addEventListener(Event.ADDED_TO_STAGE,this.onAddedToStage);
      }
      
      private function onAddedToStage(param1:Event) : void
      {
         removeEventListener(Event.ADDED_TO_STAGE,this.onAddedToStage);
         this.init();
      }
      
      private function init() : void
      {
         addChild(this.surface);
         this.surface.useStreams = false;
         this._stage = stage;
         DustBurst.reachedTargetSignal.add(this.onParticleReachedTarget);
      }
      
      public function clear() : void
      {
         var _loc1_:int = 0;
         while(_loc1_ < this._bursts.length)
         {
            this._bursts[_loc1_].clear();
            _loc1_++;
         }
         this._bursts.length = 0;
      }
      
      private function onParticleReachedTarget() : void
      {
         var _loc1_:Number = getTimer();
         if(_loc1_ - this._particleHitTimestamp > this.MIN_PARTICLE_HIT_SOUND_RATE && Math.random() < 0.2)
         {
            MCSound.getInstance().playSound("ParticleRain" + Math.ceil(Math.random() * 6));
            this._particleHitTimestamp = _loc1_;
         }
      }
      
      public function go(param1:Rectangle, param2:int = 50, param3:int = 0, param4:String = "default") : void
      {
         var _loc5_:DustBurst = null;
         _loc5_ = new DustBurst(this.pool);
         _loc5_.goalMode = param3;
         _loc5_.goal.x = this.goal.x;
         _loc5_.goal.y = this.goal.y;
         _loc5_.particlesPerBurst = param2;
         _loc5_.go(param1,param4);
         _loc5_.completeSignal.addOnce(this.markBurstForRemoval);
         this._bursts.push(_loc5_);
      }
      
      public function poof(param1:Rectangle, param2:int = 50) : void
      {
         var _loc3_:DustPoof = null;
         _loc3_ = new DustPoof(this.pool);
         _loc3_.goal.x = -30;
         _loc3_.goal.y = this._stage.stageHeight + 30;
         _loc3_.particlesPerBurst = param2;
         _loc3_.go(param1);
         _loc3_.completeSignal.addOnce(this.markBurstForRemoval);
         this._bursts.push(_loc3_);
      }
      
      public function update() : void
      {
         this.surface.clear();
         while(this._burstsForRemoval.length > 0)
         {
            this.removeBurst(this._burstsForRemoval.pop());
         }
         var _loc1_:int = 0;
         while(_loc1_ < this._bursts.length)
         {
            this._bursts[_loc1_].update();
            this.surface.updateParticles(this._bursts[_loc1_].particles);
            _loc1_++;
         }
      }
      
      private function markBurstForRemoval(param1:DustBurst) : void
      {
         this._burstsForRemoval.push(param1);
      }
      
      private function removeBurst(param1:DustBurst) : void
      {
         var _loc2_:int = this._bursts.indexOf(param1);
         if(_loc2_ >= 0)
         {
            this._bursts.splice(_loc2_,1);
         }
      }
   }
}

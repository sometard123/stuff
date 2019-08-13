package ninjakiwi.luck
{
   import flash.display.DisplayObjectContainer;
   import ninjakiwi.monkeyTown.system.MonkeySystem;
   import ninjakiwi.monkeyTown.town.gameEvents.GameEventManager;
   import ninjakiwi.monkeyTown.town.ui.eventsMenu.EventsMenuStack;
   
   public class HappyCurve
   {
       
      
      public var hitCurvePenalty:Number = 0.3;
      
      public var badLuckProtectionFactor:Number = 0.5;
      
      public var baseProbability:Number = 0.01;
      
      public var growthRate:Number = 0.001;
      
      public var curve:Number = 0.001;
      
      public var charges:int = 3;
      
      public var protectAgainstBadLuck:Boolean = true;
      
      public var badLuckProtectionThreshold:Number = 0.5;
      
      public var badLuckProtectionCurve:Number = 5.0E-5;
      
      var _badLuckProtectionGrowthRate:Number = 0.0;
      
      var _bonusProbability:Number = 0;
      
      var _generationsSinceHit:int = 0;
      
      public var state:HappyCurveState;
      
      public function HappyCurve()
      {
         super();
         this.state = new HappyCurveState(this);
      }
      
      public function step() : void
      {
         this._bonusProbability = this._bonusProbability + this.growthRate;
         this.growthRate = this.growthRate + this.curve;
         if(this.protectAgainstBadLuck && this._generationsSinceHit > 1 / this.baseProbability * this.badLuckProtectionThreshold)
         {
            this._bonusProbability = this._bonusProbability + this._badLuckProtectionGrowthRate;
            this._badLuckProtectionGrowthRate = this._badLuckProtectionGrowthRate + this.badLuckProtectionCurve;
         }
         this._generationsSinceHit++;
      }
      
      public function hit() : void
      {
         this._bonusProbability = 0;
         this._badLuckProtectionGrowthRate = 0;
         this.growthRate = 0;
         this.curve = this.curve * this.hitCurvePenalty;
         this._generationsSinceHit = 0;
         _loc1_.charges = _loc2_;
         this.charges = Math.max(_loc2_,0);
         if(this.charges == 0)
         {
            this.growthRate = 0;
            this.curve = 0;
         }
      }
      
      public function reset() : void
      {
      }
      
      public function get generationsSinceHit() : int
      {
         return this._generationsSinceHit;
      }
      
      public function get totalProbability() : Number
      {
         return Math.min(1,this.baseProbability + this._bonusProbability);
      }
      
      public function get bonusProbability() : Number
      {
         return this._bonusProbability;
      }
   }
}

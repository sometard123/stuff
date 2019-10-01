package assets.btdmodule.ui
{
   import flash.display.MovieClip;
   import ninjakiwi.monkeyTown.btdModule.ingame.monkeyKnowledge.Buff;
   import ninjakiwi.monkeyTown.btdModule.ingame.monkeyKnowledge.pathSpecificClasses.BigBloonSabotage;
   
   public dynamic class MonkeyBoostClip extends MovieClip
   {
       
      
      public var activatedPulse:MovieClip;
      
      public var bloonstones:BloonstonesSymbol;
      
      public var bonusCounter:MovieClip;
      
      public var boostCooldownText:MovieClip;
      
      public var coolDown_mc:MovieClip;
      
      public function MonkeyBoostClip()
      {
         super();
      }
   }
}

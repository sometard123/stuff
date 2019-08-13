package assets.town
{
   import assets.spam.MonkeyMoneySpinningCoinClip;
   import assets.ui.CashCollectBox;
   import flash.display.MovieClip;
   import flash.events.Event;
   import flash.text.TextField;
   
   public dynamic class BananaFarmStatsClip extends MovieClip
   {
       
      
      public var collectBox:CashCollectBox;
      
      public var collectHit:MovieClip;
      
      public var spinningCoin:MonkeyMoneySpinningCoinClip;
      
      public var statsField:TextField;
      
      public var stillCoin:MovieClip;
      
      public function BananaFarmStatsClip()
      {
         super();
         addFrameScript(0,this.frame1,8,this.frame9,14,this.frame15,50,this.frame51);
      }
      
      function frame1() : *
      {
         stop();
      }
      
      function frame9() : *
      {
         stop();
         this.dispatchEvent(new Event("rolloverAnimationComplete"));
      }
      
      function frame15() : *
      {
         gotoAndStop(1);
      }
      
      function frame51() : *
      {
         this.dispatchEvent(new Event("burst_complete"));
         gotoAndStop(1);
      }
   }
}

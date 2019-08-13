package assets.town
{
   import assets.ui.NoLivesLostBonusPart;
   import assets.ui.VictoryBonusPart;
   import flash.display.MovieClip;
   import flash.text.TextField;
   
   public dynamic class WinInfoPanelClip extends MovieClip
   {
       
      
      public var background:MovieClip;
      
      public var bloonStoneTerrainBonusTxt:TextField;
      
      public var bloontonium_txt:TextField;
      
      public var cancelButton:MovieClip;
      
      public var caption1:TextField;
      
      public var caption2:TextField;
      
      public var miniLandGrab:MovieClip;
      
      public var moneyTerrainBonusTxt:TextField;
      
      public var monkeyKnowledge:MovieClip;
      
      public var monkeySalute:MovieClip;
      
      public var monkeyTeams:MovieClip;
      
      public var noLivesLostBonus:NoLivesLostBonusPart;
      
      public var okButton:MovieClip;
      
      public var padding:MovieClip;
      
      public var pvpDescriptionTxt:TextField;
      
      public var shoutingMonkey:MovieClip;
      
      public var terrainIconSet:MovieClip;
      
      public var victoryBonusPart:VictoryBonusPart;
      
      public function WinInfoPanelClip()
      {
         super();
         addFrameScript(0,this.frame1,1,this.frame2);
      }
      
      function frame1() : *
      {
         stop();
      }
      
      function frame2() : *
      {
         stop();
      }
   }
}

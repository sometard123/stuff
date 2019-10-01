package assets.ui
{
   import flash.display.MovieClip;
   import flash.text.TextField;
   
   public dynamic class VictoryPanelBossClip extends MovieClip
   {
       
      
      public var bossDefeatedAnimationContainer:MovieClip;
      
      public var bossNameField:TextField;
      
      public var levelField:MovieClip;
      
      public var okButton:MovieClip;
      
      public function VictoryPanelBossClip()
      {
         super();
         addFrameScript(15,this.frame16);
      }
      
      function frame16() : *
      {
         stop();
      }
   }
}

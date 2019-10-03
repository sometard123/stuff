package InGameUI_fla_fla
{
   import flash.display.MovieClip;
   import flash.text.TextField;
   
   public dynamic class HealthBar_106 extends MovieClip
   {
       
      
      public var bar:MovieClip;
      
      public var barMask:MovieClip;
      
      public var bossIcon:MovieClip;
      
      public var dreadShieldBar:MovieClip;
      
      public var levelField:TextField;
      
      public var shieldMask:MovieClip;
      
      public function HealthBar_106()
      {
         super();
         addFrameScript(0,this.frame1);
      }
      
      function frame1() : *
      {
         this.dreadShieldBar.visible = false;
      }
   }
}

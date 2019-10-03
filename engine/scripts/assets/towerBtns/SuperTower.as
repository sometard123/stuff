package assets.towerBtns
{
   import assets.module.AllDamagedClip;
   import display.ui.Button;
   import flash.display.MovieClip;
   
   public dynamic class SuperTower extends Button
   {
       
      
      public var allDamaged:AllDamagedClip;
      
      public var favouredTick:MovieClip;
      
      public var lock_mc:MovieClip;
      
      public function SuperTower()
      {
         super();
         addFrameScript(0,this.frame1,9,this.frame10,19,this.frame20);
      }
      
      function frame1() : *
      {
         stop();
      }
      
      function frame10() : *
      {
         stop();
      }
      
      function frame20() : *
      {
         stop();
      }
   }
}

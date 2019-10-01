package assets.ui
{
   import flash.display.MovieClip;
   
   public dynamic class TreasureChestClip extends MovieClip
   {
       
      
      public var itemIcon:TreasureIconClip;
      
      public function TreasureChestClip()
      {
         super();
         addFrameScript(20,this.frame21);
      }
      
      function frame21() : *
      {
         stop();
      }
   }
}

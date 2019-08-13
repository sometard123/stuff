package ninjakiwi.monkeyTown.town.gameEvents.awarders
{
   import flash.display.BitmapData;
   import flash.display.MovieClip;
   import flash.geom.Matrix;
   import flash.geom.Rectangle;
   import ninjakiwi.display.gfx.bitClip.PositionedBMD;
   import ninjakiwi.monkeyTown.monkeyKnowledge.MonkeyKnowledge;
   
   public class KnowledgePackAwarder extends Awarder
   {
       
      
      public function KnowledgePackAwarder(param1:Number)
      {
         super(param1);
      }
      
      override public function award() : void
      {
         MonkeyKnowledge.getInstance().unopenedPacks = MonkeyKnowledge.getInstance().unopenedPacks + _quantity.value;
      }
   }
}

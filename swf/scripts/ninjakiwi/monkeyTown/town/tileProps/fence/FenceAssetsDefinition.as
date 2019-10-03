package ninjakiwi.monkeyTown.town.tileProps.fence
{
   public class FenceAssetsDefinition
   {
       
      
      public var roShamBo:int = 0;
      
      public var topFullEdge:String = "assets.tiles.FenceTopFullEdgeClip";
      
      public var rightFullEdge:String = "assets.tiles.FenceRightFullEdgeClip";
      
      public var bottomFullEdge:String = "assets.tiles.FenceBottomFullEdgeClip";
      
      public var leftFullEdge:String = "assets.tiles.FenceLeftFullEdgeClip";
      
      public var topLefChunkEdge:String = "assets.tiles.FenceTopLeftChunkEdgeClip";
      
      public var topRightChunkEdge:String = "assets.tiles.FenceTopRightChunkEdgeClip";
      
      public var rightTopChunkEdge:String = "assets.tiles.FenceRightTopChunkEdgeClip";
      
      public var rightBottomChunkEdge:String = "assets.tiles.FenceRightBottomChunkEdgeClip";
      
      public var bottomRightChunkEdge:String = "assets.tiles.FenceBottomRightChunkEdgeClip";
      
      public var bottomLeftChunkEdge:String = "assets.tiles.FenceBottomLeftChunkEdgeClip";
      
      public var leftBottomChunkEdge:String = "assets.tiles.FenceLeftBottomChunkEdgeClip";
      
      public var leftTopChunkEdge:String = "assets.tiles.FenceLeftTopChunkEdgeClip";
      
      public var topMiddleEdge:String = "assets.tiles.FenceTopMiddleEdgeClip";
      
      public var rightMiddleEdge:String = "assets.tiles.FenceRightMiddleEdgeClip";
      
      public var bottomMiddleEdge:String = "assets.tiles.FenceBottomMiddleEdgeClip";
      
      public var leftMiddleEdge:String = "assets.tiles.FenceLeftMiddleEdgeClip";
      
      public var topRightCorner:String = "assets.tiles.FenceTopRightCornerClip";
      
      public var topLeftCorner:String = "assets.tiles.FenceTopLeftCornerClip";
      
      public var bottomRightCorner:String = "assets.tiles.FenceBottomRightCornerClip";
      
      public var bottomLeftCorner:String = "assets.tiles.FenceBottomLeftCornerClip";
      
      public function FenceAssetsDefinition(param1:int = 0)
      {
         super();
         this.roShamBo = param1;
      }
      
      public function clearAll() : void
      {
         this.topFullEdge = this.rightFullEdge = this.bottomFullEdge = this.leftFullEdge = this.topLefChunkEdge = this.topRightChunkEdge = this.rightTopChunkEdge = this.rightBottomChunkEdge = this.bottomRightChunkEdge = this.bottomLeftChunkEdge = this.leftBottomChunkEdge = this.leftTopChunkEdge = this.topMiddleEdge = this.rightMiddleEdge = this.bottomMiddleEdge = this.leftMiddleEdge = this.topRightCorner = this.topLeftCorner = this.bottomRightCorner = this.bottomLeftCorner = null;
      }
      
      public function useFullEdgesForChunks() : void
      {
         this.topLefChunkEdge = this.topFullEdge;
         this.topRightChunkEdge = this.topFullEdge;
         this.rightTopChunkEdge = this.rightFullEdge;
         this.rightBottomChunkEdge = this.rightFullEdge;
         this.bottomRightChunkEdge = this.bottomFullEdge;
         this.bottomLeftChunkEdge = this.bottomFullEdge;
         this.leftBottomChunkEdge = this.leftFullEdge;
         this.leftTopChunkEdge = this.leftFullEdge;
         this.topMiddleEdge = this.topFullEdge;
         this.rightMiddleEdge = this.rightFullEdge;
         this.bottomMiddleEdge = this.bottomFullEdge;
         this.leftMiddleEdge = this.leftFullEdge;
      }
   }
}

package ninjakiwi.monkeyTown.town.tileProps.fence
{
   import ninjakiwi.monkeyTown.display.bitClip.BitClipCustom;
   import ninjakiwi.monkeyTown.town.tile.TileDefinitions;
   import org.osflash.signals.Signal;
   
   public class Fence
   {
      
      public static const EMPTY:String = null;
      
      public static const defaultFenceAssets:FenceAssetsDefinition = new FenceAssetsBambooDefinition(10);
      
      public static const desertFenceAssets:FenceAssetsDefinition = new FenceAssetsBambooDefinition(9);
      
      public static const waterFenceAssets:FenceAssetsDefinition = new FenceAssetsWaterDefinition(0);
      
      public static const snowFenceAssets:FenceAssetsDefinition = new FenceAssetsSnowDefinition(0);
       
      
      public var topClip:BitClipCustom = null;
      
      public var rightClip:BitClipCustom = null;
      
      public var bottomClip:BitClipCustom = null;
      
      public var leftClip:BitClipCustom = null;
      
      public var topRightCornerClip:BitClipCustom = null;
      
      public var bottomRightCornerClip:BitClipCustom = null;
      
      public var bottomLeftCornerClip:BitClipCustom = null;
      
      public var topLeftCornerClip:BitClipCustom = null;
      
      private const _tileDefinitions:TileDefinitions = TileDefinitions.getInstance();
      
      public const TOP:int = 0;
      
      public const RIGHT:int = 1;
      
      public const BOTTOM:int = 2;
      
      public const LEFT:int = 3;
      
      public var backLayers:Vector.<BitClipCustom>;
      
      public var midLayers:Vector.<BitClipCustom>;
      
      public var frontLayers:Vector.<BitClipCustom>;
      
      public var changedSignal:Signal;
      
      public function Fence()
      {
         this.backLayers = new Vector.<BitClipCustom>();
         this.midLayers = new Vector.<BitClipCustom>();
         this.frontLayers = new Vector.<BitClipCustom>();
         this.changedSignal = new Signal();
         super();
      }
      
      public static function getFenceAssetsForGround(param1:String) : FenceAssetsDefinition
      {
         switch(param1)
         {
            case "WaterGround":
               return waterFenceAssets;
            case "SnowGround":
               return snowFenceAssets;
            default:
               return defaultFenceAssets;
         }
      }
      
      public function reset() : void
      {
         this.topClip = null;
         this.rightClip = null;
         this.bottomClip = null;
         this.leftClip = null;
         this.topRightCornerClip = null;
         this.bottomRightCornerClip = null;
         this.bottomLeftCornerClip = null;
         this.topLeftCornerClip = null;
      }
      
      public function build() : void
      {
         this.backLayers.length = 0;
         if(this.topClip)
         {
            this.backLayers.push(this.topClip);
         }
         if(this.topLeftCornerClip)
         {
            this.backLayers.push(this.topLeftCornerClip);
         }
         if(this.topRightCornerClip)
         {
            this.backLayers.push(this.topRightCornerClip);
         }
         this.midLayers.length = 0;
         if(this.rightClip)
         {
            this.midLayers.push(this.rightClip);
         }
         if(this.leftClip)
         {
            this.midLayers.push(this.leftClip);
         }
         this.frontLayers.length = 0;
         if(this.bottomLeftCornerClip)
         {
            this.frontLayers.push(this.bottomLeftCornerClip);
         }
         if(this.bottomRightCornerClip)
         {
            this.frontLayers.push(this.bottomRightCornerClip);
         }
         if(this.bottomClip)
         {
            this.frontLayers.push(this.bottomClip);
         }
         this.changedSignal.dispatch();
      }
      
      public function setTopEdge(param1:String = null) : void
      {
         if(param1)
         {
            if(this.topClip == null)
            {
               this.topClip = new BitClipCustom();
            }
            this.topClip.addAnimation(param1,param1,1);
         }
         else
         {
            this.topClip = null;
         }
      }
      
      public function setRightEdge(param1:String = null) : void
      {
         if(param1)
         {
            if(this.rightClip == null)
            {
               this.rightClip = new BitClipCustom();
            }
            this.rightClip.addAnimation(param1,param1,1);
         }
         else
         {
            this.rightClip = null;
         }
      }
      
      public function setBottomEdge(param1:String = null) : void
      {
         if(param1)
         {
            if(this.bottomClip == null)
            {
               this.bottomClip = new BitClipCustom();
            }
            this.bottomClip.addAnimation(param1,param1,1);
         }
         else
         {
            this.bottomClip = null;
         }
      }
      
      public function setLeftEdge(param1:String = null) : void
      {
         if(param1)
         {
            if(this.leftClip == null)
            {
               this.leftClip = new BitClipCustom();
            }
            this.leftClip.addAnimation(param1,param1,1);
         }
         else
         {
            this.leftClip = null;
         }
      }
      
      public function setTopLeftCorner(param1:String = null) : void
      {
         if(param1)
         {
            if(this.topLeftCornerClip == null)
            {
               this.topLeftCornerClip = new BitClipCustom();
            }
            this.topLeftCornerClip.addAnimation(param1,param1,1);
         }
         else
         {
            this.topLeftCornerClip = null;
         }
      }
      
      public function setTopRightCorner(param1:String = null) : void
      {
         if(param1)
         {
            if(this.topRightCornerClip == null)
            {
               this.topRightCornerClip = new BitClipCustom();
            }
            this.topRightCornerClip.addAnimation(param1,param1,1);
         }
         else
         {
            this.topRightCornerClip = null;
         }
      }
      
      public function setBottomLeftCorner(param1:String = null) : void
      {
         if(param1)
         {
            if(this.bottomLeftCornerClip == null)
            {
               this.bottomLeftCornerClip = new BitClipCustom();
            }
            this.bottomLeftCornerClip.addAnimation(param1,param1,1);
         }
         else
         {
            this.bottomLeftCornerClip = null;
         }
      }
      
      public function setBottomRightCorner(param1:String = null) : void
      {
         if(param1)
         {
            if(this.bottomRightCornerClip == null)
            {
               this.bottomRightCornerClip = new BitClipCustom();
            }
            this.bottomRightCornerClip.addAnimation(param1,param1,1);
         }
         else
         {
            this.bottomRightCornerClip = null;
         }
      }
      
      public function hasVisibleFencePieces() : Boolean
      {
         return this.topClip || this.rightClip || this.bottomClip || this.leftClip || this.topRightCornerClip || this.bottomRightCornerClip || this.bottomLeftCornerClip || this.topLeftCornerClip;
      }
   }
}

class SINGSING
{
   
   public static const self:SINGSING = new SINGSING();
    
   
   function SINGSING()
   {
      super();
   }
}

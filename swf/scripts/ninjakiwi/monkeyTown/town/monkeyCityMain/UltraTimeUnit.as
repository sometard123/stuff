package ninjakiwi.monkeyTown.town.monkeyCityMain
{
   import com.greensock.TweenLite;
   import com.greensock.easing.Cubic;
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.display.DisplayObject;
   import flash.display.PixelSnapping;
   import flash.display.Sprite;
   import flash.filters.BitmapFilterQuality;
   import flash.filters.BlurFilter;
   import flash.geom.Point;
   import ninjakiwi.monkeyTown.system.MonkeySystem;
   
   public class UltraTimeUnit extends Sprite
   {
      
      private static const _blurFilter:BlurFilter = new BlurFilter(20,20,BitmapFilterQuality.HIGH);
       
      
      public var active:Boolean = false;
      
      private var _target:DisplayObject;
      
      private var _bitmapData:BitmapData;
      
      private var _bitmap:Bitmap;
      
      private var _screenWidth:Number = 800;
      
      private var _screenHeight:Number = 600;
      
      public function UltraTimeUnit(param1:DisplayObject)
      {
         super();
         this._target = param1;
         this._bitmapData = new BitmapData(this._screenWidth,this._screenHeight,false,0);
         this._bitmap = new Bitmap(this._bitmapData);
         this._bitmap.smoothing = false;
         this._bitmap.pixelSnapping = PixelSnapping.NEVER;
         MonkeySystem.getInstance().resizeSignal.add(this.onResize);
      }
      
      public function activate() : void
      {
         if(this._bitmapData)
         {
            this._bitmapData.dispose();
         }
         this._bitmapData = new BitmapData(this._screenWidth,this._screenHeight,false,0);
         this._bitmap.bitmapData = this._bitmapData;
         this._bitmapData.draw(this._target);
         this._bitmapData.applyFilter(this._bitmapData,this._bitmapData.rect,new Point(),_blurFilter);
         addChild(this._bitmap);
         this._bitmap.alpha = 0;
         TweenLite.to(this._bitmap,0.5,{
            "alpha":1,
            "ease":Cubic.easeOut
         });
         this.active = true;
      }
      
      public function deactivate() : void
      {
         var that:UltraTimeUnit = null;
         that = this;
         TweenLite.to(this._bitmap,0.3,{
            "alpha":0,
            "ease":Cubic.easeOut,
            "onComplete":function():void
            {
               if(that.contains(_bitmap))
               {
                  that.removeChild(_bitmap);
               }
            }
         });
         this.active = false;
      }
      
      private function onResize(param1:Number, param2:Number) : void
      {
         this._screenWidth = param1;
         this._screenHeight = param2;
      }
   }
}

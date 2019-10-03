package ninjakiwi.monkeyTown.town.tile
{
   import flash.display.MovieClip;
   import flash.events.Event;
   import flash.geom.ColorTransform;
   import ninjakiwi.monkeyTown.display.tileSystem.Tile;
   
   public class TilePulsator
   {
      
      private static var _count:Number = 0;
      
      private static var _speed:Number = 0.12;
      
      private static var _depthMin:Number = 0.1;
      
      private static var _depthMax:Number = 0.35;
      
      private static var _pulsateLevel:Number;
      
      private static const _pulsatingTiles:Array = [];
      
      private static const framer:MovieClip = new MovieClip();
      
      private static var _colorTransform:ColorTransform = new ColorTransform();
       
      
      public function TilePulsator()
      {
         super();
      }
      
      private static function update(param1:Event = null) : void
      {
         var _loc2_:Tile = null;
         _count = _count + _speed;
         _pulsateLevel = 1 + (Math.sin(_count) / 2 + 0.5) * (_depthMax - _depthMin) + _depthMin;
         _colorTransform = new ColorTransform(_pulsateLevel,_pulsateLevel,_pulsateLevel,1);
         var _loc3_:int = 0;
         while(_loc3_ < _pulsatingTiles.length)
         {
            _loc2_ = _pulsatingTiles[_loc3_];
            _loc2_.setColorTransform(_colorTransform);
            _loc3_++;
         }
      }
      
      public static function setPulsateState(param1:Tile, param2:Boolean) : void
      {
         var _loc3_:int = 0;
         if(param2)
         {
            if(_pulsatingTiles.indexOf(param1) === -1)
            {
               _pulsatingTiles.push(param1);
               param1.setColorTransform(_colorTransform);
            }
         }
         else
         {
            param1.unhover();
            _loc3_ = _pulsatingTiles.indexOf(param1);
            if(_loc3_ !== -1)
            {
               _pulsatingTiles.splice(_loc3_,1);
            }
         }
         if(_pulsatingTiles.length === 1)
         {
            start();
         }
         else if(_pulsatingTiles.length === 0)
         {
            stop();
         }
      }
      
      private static function start() : void
      {
         framer.addEventListener(Event.ENTER_FRAME,update);
      }
      
      private static function stop() : void
      {
         framer.removeEventListener(Event.ENTER_FRAME,update);
      }
   }
}

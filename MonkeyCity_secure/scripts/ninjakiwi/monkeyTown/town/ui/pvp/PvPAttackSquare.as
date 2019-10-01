package ninjakiwi.monkeyTown.town.ui.pvp
{
   import assets.bloonIcons.DifficultyBarsTileClip;
   import assets.ui.PVPattackSquareClip;
   import flash.display.MovieClip;
   import ninjakiwi.monkeyTown.data.ResourceStore;
   import ninjakiwi.monkeyTown.pvp.IncomingRaid;
   import ninjakiwi.monkeyTown.pvp.PvPSignals;
   import ninjakiwi.monkeyTown.system.MonkeySystem;
   import ninjakiwi.monkeyTown.town.monkeyCityMain.WorldView;
   import ninjakiwi.monkeyTown.town.ui.AvatarLoader;
   import ninjakiwi.monkeyTown.town.ui.TileBoundAnimation;
   import ninjakiwi.sharedFrameAnalyser.AnimationSharedFramesMap;
   
   public class PvPAttackSquare extends TileBoundAnimation
   {
      
      private static var _currentHovered:PvPAttackSquare;
      
      private static var allSquares:Object = {};
      
      private static const _pool:Vector.<PvPAttackSquare> = new Vector.<PvPAttackSquare>();
       
      
      private const _pips:DifficultyBarsTileClip = new DifficultyBarsTileClip();
      
      private var _avatarContainer:MovieClip = null;
      
      private var _attackID:String = null;
      
      private var _attack:IncomingRaid = null;
      
      private var _system:MonkeySystem;
      
      private var _resourceStore:ResourceStore;
      
      private var _currentAvatar:AvatarLoader;
      
      public function PvPAttackSquare(param1:IncomingRaid)
      {
         this._system = MonkeySystem.getInstance();
         this._resourceStore = ResourceStore.getInstance();
         var _loc2_:PVPattackSquareClip = new PVPattackSquareClip();
         this._avatarContainer = _loc2_.avatarContainerFrame.avatarContainer;
         this.initPVPAttackSquare(param1);
         super(_loc2_);
      }
      
      public static function resetAttacks() : void
      {
         allSquares = {};
      }
      
      public static function getSquare(param1:IncomingRaid) : PvPAttackSquare
      {
         var _loc2_:PvPAttackSquare = null;
         if(_pool.length > 0)
         {
            _loc2_ = _pool.pop();
            _loc2_.initPVPAttackSquare(param1);
            return _loc2_;
         }
         return new PvPAttackSquare(param1);
      }
      
      public static function recycleSquare(param1:PvPAttackSquare) : void
      {
         if(_pool.indexOf(param1) != -1)
         {
            _pool.push(param1);
         }
      }
      
      public static function unhover() : void
      {
         if(_currentHovered != null)
         {
            WorldView.removeOverlayItem(_currentHovered.pips);
         }
      }
      
      public function initPVPAttackSquare(param1:IncomingRaid) : void
      {
         super.updateToTile(param1.linkedTile.tile);
         this._attack = param1;
         this._attackID = param1.attackID;
         this._pips.x = this.x;
         this._pips.y = this.y;
         this.loadAvatar(param1.userID.toString());
         WorldView.addOverlayItem(this);
         allSquares[this._attackID] = this;
      }
      
      override public function die() : void
      {
         super.die();
         WorldView.removeOverlayItem(this._pips);
         if(_currentHovered == this)
         {
            _currentHovered = null;
         }
         delete allSquares[this._attackID];
         this._attack = null;
         this._system = null;
         this._resourceStore = null;
         while(this._avatarContainer.numChildren > 0)
         {
            this._avatarContainer.removeChildAt(0);
         }
         this._avatarContainer = null;
      }
      
      public function killAttackSquare() : void
      {
         this.die();
      }
      
      public function loadAvatar(param1:String) : void
      {
         while(this._avatarContainer.numChildren > 0)
         {
            this._avatarContainer.removeChildAt(0);
         }
         if(this._currentAvatar != null)
         {
            if(this._avatarContainer.contains(this._currentAvatar))
            {
               this._avatarContainer.removeChild(this._currentAvatar);
            }
            this._currentAvatar.clear();
         }
         this._currentAvatar = new AvatarLoader(param1);
         this._avatarContainer.addChild(this._currentAvatar);
      }
      
      override public function simulateClick() : void
      {
         PvPSignals.defendTileSignal.dispatch(this._attack);
      }
      
      override public function hover() : void
      {
         var _loc1_:int = 0;
         if(this._attack.linkedTile != null && this._attack.linkedTile.tile)
         {
            _loc1_ = this._system.map.getPVPRank(this._attack.attack.difficulty,this._resourceStore.townLevel,this._attack.linkedTile.tile != null?this._attack.linkedTile.tile.type:"",this._attack.linkedTile.tile);
            this._pips.gotoAndStop(_loc1_ + 1);
         }
         WorldView.addOverlayItem(this._pips);
         _currentHovered = this;
      }
      
      public function get attackID() : String
      {
         return this._attackID;
      }
      
      public function get pips() : DifficultyBarsTileClip
      {
         return this._pips;
      }
   }
}

package assets.town
{
   import flash.display.MovieClip;
   import flash.text.TextField;
   
   public dynamic class TownAvatarContainer extends MovieClip
   {
       
      
      public var avatarModule:AvatarModuleClip;
      
      public var extraInfoPanel:ExtraInfoPanel;
      
      public var playerHitArea:TownAvatarHitArea;
      
      public var playerNameAvatarField:TextField;
      
      public var territoryOwnerStar:territoryOwnerStar;
      
      public var townTier:MovieClip;
      
      public function TownAvatarContainer()
      {
         super();
      }
   }
}

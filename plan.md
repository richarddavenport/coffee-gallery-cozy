# Coffee Gallery Plan - Masonry Gallery & Admin Separation ✨

- [x] Generate a Phoenix LiveView project called `coffee_gallery`
- [x] Replace the default home page with our warm & cozy static design mockup
- [x] Implement CoffeeGalleryLive LiveView with features:
  - Display a grid of coffee shop photos with names, locations, and descriptions
  - Add new coffee shop entries with image upload capability
  - Real-time updates when new shops are added via PubSub
  - Warm earth tone color scheme with wood-inspired textures
- [x] Create the Coffee.Shops context and migration:
  - `name` - coffee shop name
  - `location` - city/address
  - `description` - brief description
  - `image_url` - photo URL
  - `rating` - optional star rating
- [x] Update layouts to match our warm & cozy design:
  - Modify `root.html.heex` and force light theme for warmth
  - Update `<Layouts.app>` with earth tone navigation
  - Update `app.css` with warm browns, creams, and wood textures
- [x] **NEW: Beautiful Masonry Gallery Transformation:**
  - Created GalleryLive for stunning masonry homepage (responsive columns)
  - Moved admin functionality to dedicated AdminLive at /admin
  - Enhanced CSS with masonry layout and smooth hover effects
  - Root route now showcases beautiful coffee shop images
- [x] Update the router - root shows gallery, /admin for management
- [x] Visit the app to verify everything works beautifully

🎨 **NEW DESIGN**: Homepage is now a Pinterest-style masonry gallery with hover overlays!
📱 **RESPONSIVE**: 1-4 columns based on screen size with smooth transitions
⚡ **REAL-TIME**: Gallery updates instantly when shops are added via admin
🔧 **ADMIN**: Clean separation - public gallery vs management interface


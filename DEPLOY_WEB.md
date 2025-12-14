# 🚀 Deploy EMS Protocol Web App to Netlify

## Quick Deploy (3 Minutes)

### Option 1: Netlify Dashboard (Easiest)

1. **Push to GitHub** (Already done! ✅)

2. **Go to Netlify**
   - Visit https://app.netlify.com
   - Sign in with GitHub

3. **Create New Site**
   - Click "Add new site" → "Import an existing project"
   - Choose "GitHub"
   - Select repository: `MedicD21/EMS_Protocol`
   - Select branch: `claude/ems-protocol-app-jfv9F`

4. **Configure Build Settings** (Auto-detected from netlify.toml)
   - Base directory: `web-prototype`
   - Build command: `npm run build`
   - Publish directory: `web-prototype/dist`
   - Click "Deploy site"

5. **Done!** 🎉
   - Your site will be live in ~2 minutes
   - You'll get a URL like: `ems-protocol-xxxxx.netlify.app`
   - Can customize domain in Site settings

### Option 2: Netlify CLI (Fast)

```bash
# Install Netlify CLI
npm install -g netlify-cli

# Navigate to web app
cd web-prototype

# Install dependencies
npm install

# Build the app
npm run build

# Login to Netlify
netlify login

# Deploy
netlify deploy --prod

# Follow prompts:
# - Create & configure new site? Yes
# - Publish directory: dist
```

### Option 3: Drag & Drop (No Config)

```bash
# Navigate and build
cd web-prototype
npm install
npm run build

# Then:
# 1. Go to https://app.netlify.com/drop
# 2. Drag the 'dist' folder onto the page
# 3. Done!
```

## 📱 After Deployment

### Test the App
1. Visit your Netlify URL
2. Login with demo credentials:
   - Username: `editor` or `user`
   - Password: any

### Install as PWA
**On Mobile:**
1. Open in Safari/Chrome
2. Tap Share button
3. "Add to Home Screen"
4. App installs like native!

**On Desktop:**
1. Look for install icon in address bar
2. Click to install
3. App opens in its own window

### Customize Domain (Optional)
1. In Netlify dashboard, go to "Domain settings"
2. Click "Add custom domain"
3. Follow DNS setup instructions

## ⚙️ Configuration

### Environment Variables (Optional)
For future AI features:
1. In Netlify dashboard → Site settings → Environment variables
2. Add:
   - `VITE_OPENAI_API_KEY` (for AI document scanning)
   - `VITE_CLAUDE_API_KEY` (for AI features)

### Custom netlify.toml Settings
Already configured in `/web-prototype/netlify.toml`:
- ✅ Build command
- ✅ Publish directory
- ✅ SPA redirects
- ✅ Security headers
- ✅ Cache optimization

## 🔄 Automatic Deploys

Netlify will automatically redeploy when you:
1. Push to the `claude/ems-protocol-app-jfv9F` branch
2. Merge a pull request
3. Make any changes in GitHub

### Branch Deploys
- Production: `claude/ems-protocol-app-jfv9F`
- Preview: Any branch gets preview URL
- Pull requests: Automatic deploy previews

## 📊 Features Enabled

✅ **HTTPS** - Automatic SSL certificate
✅ **CDN** - Global edge network
✅ **PWA** - Service worker enabled
✅ **SPA** - Client-side routing works
✅ **Caching** - Optimized asset caching
✅ **Headers** - Security headers configured

## 🐛 Troubleshooting

### Build Fails
```bash
# Test locally first
cd web-prototype
npm install
npm run build

# If successful, check Netlify logs
```

### 404 on Refresh
- Already fixed with redirect rule in netlify.toml
- Ensures SPA routing works

### PWA Not Installing
- Ensure site is HTTPS (Netlify provides this)
- Check manifest in browser DevTools
- Clear cache and try again

## 📈 Monitor Your Site

In Netlify dashboard you can see:
- **Analytics**: Page views, visitors
- **Deploy log**: Build output and errors
- **Functions**: If you add serverless functions later
- **Forms**: If you add contact forms

## 🎯 Next Steps

1. **Deploy** using method above
2. **Test** all features
3. **Share** the URL with your team
4. **Customize** domain (optional)
5. **Monitor** usage via Netlify analytics

## 🆘 Need Help?

- **Netlify Docs**: https://docs.netlify.com
- **Web App README**: `/web-prototype/README.md`
- **Netlify Support**: https://answers.netlify.com

---

## 🎉 Your Site is Live!

Once deployed, you can:
- Access from any device
- Install as mobile app
- Share with unlimited users
- Update protocols in real-time
- Use offline (PWA feature)

**Estimated deployment time**: 2-3 minutes
**Monthly cost**: FREE (Netlify starter plan)

Ready to deploy? Choose your method above! 🚀

## Complete Process Flow

1. **GitHub Actions**
   - ✓ Detect change in `.version`;
   - ✓ Login to Docker Hub;
   - ✓ Build image;
   - ✓ Push tag that's in `.version` file;

2. **Argo Image Updater**
   - ✓ Detect new version on Docker Hub;
   - ✓ Update manifest in Git;

3. **ArgoCD**
   - ✓ Syncs to cluster;
   - ✓ Deploy new version;
   - ✓ Rollback to previous version if new version is not working;

## How to update version

1. Update version in `.version` file;
2. Commit and push to GitHub;
3. GitHub Actions will build and push new version to Docker Hub;
4. Argo Image Updater will update manifest creating this file `.argocd-source-foobar.yaml`;
5. To make sure we don't miss any version changes, I've created the script `update-version.sh`. See [Kubernetes Version Sync Script](../../kubernetes/README.md).


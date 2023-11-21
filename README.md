# eagle-toolbox

eagle-toolbox is an OCI image (automatically built on GitHub Actions) for Distrobox/Toolbx providing Autodesk Eagle.

## How to use

### Instantiate

If you use distrobox:

```
distrobox create -i ghcr.io/ethanjli/eagle-toolbox -n eagle
distrobox enter eagle
```

If you use toolbx:

```
toolbox create -i ghcr.io/ethanjli/eagle-toolbox -c eagle
toolbox enter eagle
```

### Set Up Autodesk Eagle

In your instance of `eagle-toolbox`, run the `prepare-eagle` command as root:

```
sudo prepare-eagle
```

This does some work which cannot be done as part of the container image build process. Now you can export the `eagle` app, for example:

```
distrobox-export --app eagle
```

## Verification

These images are signed with Sigstore's [cosign](https://docs.sigstore.dev/cosign/overview/). You can verify the signature by downloading the `cosign.pub` key from this repo and running the following command:

```
cosign verify --key cosign.pub ghcr.io/ethanjli/eagle-toolbox
```

If you're forking this repo you should [read the docs](https://docs.github.com/en/actions/security-guides/encrypted-secrets) on keeping secrets in github. You need to [generate a new keypair](https://docs.sigstore.dev/cosign/overview/) with cosign (using `cosign generate-key-pair` with no password for the private key). The public key should be in your public repo (your users need it to check the signatures), and you should paste the private key in Settings -> Secrets -> Actions as a repository secret named `SIGNING_SECRET`.

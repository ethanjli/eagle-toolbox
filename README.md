# eagle-toolbox

eagle-toolbox is an OCI image (automatically built on GitHub Actions) for Distrobox/Toolbx providing all dependencies necessary for running Autodesk Eagle. This image does not redistribute Autodesk Eagle, but we provide instructions to make the installation process as easy as possible.

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

### Install Autodesk Eagle

First, you will need to use your web browser to download the Linux version of Autodesk Eagle from <https://www.autodesk.com/products/eagle/free-download> (Autodesk seems to prevent that the download from being initiated on the command-line). You should save it to somewhere accessible from within your instance of `eagle-toolbox`.

In your instance of `eagle-toolbox`, navigate to the directory where you saved the download. Extract the downloaded `.tar.gz` file to `/opt/eagle`, for example:

```
sudo tar -xzf Autodesk_EAGLE_9.6.2_English_Linux_64bit.tar.gz -C /opt
sudo mv /opt/eagle-9.6.2 /opt/eagle
```

Note that you should extract Eagle to a path which doesn't have any spaces inside it.

Then run the `patch-eagle` command with the path you had extracted Eagle to, for example:

```
sudo patch-eagle
```

Now you can export the `eagle` app, for example:

```
distrobox-export --app eagle
```

## Verification

These images are signed with sisgstore's [cosign](https://docs.sigstore.dev/cosign/overview/). You can verify the signature by downloading the `cosign.pub` key from this repo and running the following command:

```
cosign verify --key cosign.pub ghcr.io/ethanjli/eagle-toolbox
```

If you're forking this repo you should [read the docs](https://docs.github.com/en/actions/security-guides/encrypted-secrets) on keeping secrets in github. You need to [generate a new keypair](https://docs.sigstore.dev/cosign/overview/) with cosign (using `cosign generate-key-pair`). The public key should be in your public repo (your users need it to check the signatures), and you should paste the private key in Settings -> Secrets -> Actions as a repository secret named `SIGNING_SECRET`.

# HomeLabOS &nbsp; [![bluebuild build badge](https://github.com/iegorch86/homelabos/actions/workflows/build.yml/badge.svg)](https://github.com/iegorch86/homelabos/actions/workflows/build.yml)

See the [BlueBuild docs](https://blue-build.org/how-to/setup/) for quick setup instructions for setting up your own repository based on this template.

After setup, it is recommended you update this README to describe your custom image.

## Installation

> [!WARNING]
> These are personal experimental Fedora Atomic images. Use them at your own discretion.

Two variants are available:

- **HomeLabOS NVIDIA** — for systems using supported NVIDIA graphics and the NVIDIA open kernel modules.
- **HomeLabOS Intel/Generic** — for Intel, AMD, virtual machines, and systems that do not require the NVIDIA driver.

### NVIDIA version

First rebase to the unsigned image:

```bash
rpm-ostree rebase ostree-unverified-registry:ghcr.io/iegorch86/homelabos-nvidia:latest
```

Reboot:

```bash
systemctl reboot
```

Then switch to the signed image:

```bash
rpm-ostree rebase ostree-image-signed:docker://ghcr.io/iegorch86/homelabos-nvidia:latest
```

Reboot again:

```bash
systemctl reboot
```

### Intel / generic version

First rebase to the unsigned image:

```bash
rpm-ostree rebase ostree-unverified-registry:ghcr.io/iegorch86/homelabos-intel:latest
```

Reboot:

```bash
systemctl reboot
```

Then switch to the signed image:

```bash
rpm-ostree rebase ostree-image-signed:docker://ghcr.io/iegorch86/homelabos-intel:latest
```

Reboot again:

```bash
systemctl reboot
```

The `latest` tag points to the newest build of each variant.

## ISO

If build on Fedora Atomic, you can generate an offline ISO with the instructions available [here](https://blue-build.org/how-to/generate-iso/#_top). These ISOs cannot unfortunately be distributed on GitHub for free due to large sizes, so for public projects something else has to be used for hosting.

## Verification

These images are signed with [Sigstore](https://www.sigstore.dev/)'s [cosign](https://github.com/sigstore/cosign). You can verify the signature by downloading the `cosign.pub` file from this repo and running the following command:

```bash
cosign verify --key cosign.pub ghcr.io/iegorch86/homelabos
```

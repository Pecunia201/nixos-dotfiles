{ config, pkgs, lib, ... }:

{
  # Enable VFIO
  config.vfio.enable = with lib; mkEnableOption "Configure the machine for VFIO";

  # Define boot parameters
  boot.initrd.kernelModules = [
    "vfio_pci"
    "vfio"
    "vfio_iommu_type1"
    "vfio_virqfd"
    "i915"
    "i915_modeset"
  ];

  boot.kernelParams = [
    # enable IOMMU
    "intel_iommu=on"
  ] ++ lib.optional config.vfio.enable
    # isolate the GPU
    ("vfio-pci.ids=" + lib.concatStringsSep "," [
      "8086:3e92" # Graphics
      "8086:a2f0" # Audio
    ]);

  hardware.opengl.enable = true;
  virtualisation.spiceUSBRedirection.enable = true;
}


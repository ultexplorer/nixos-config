{ pkgs, ... }:

{
  # === ГРАФИКА (AMD Cezanne / Ryzen 5000) ===
  hardware.graphics = {
    enable = true;
    enable32Bit = true;
    extraPackages = with pkgs; [
      libva-utils
      vaapiVdpau
      libvdpau-va-gl
    ];
  };

  # === ЗВУК (Pipewire) ===
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  # === СПЕЦИФИКА THINKPAD T14 GEN 2 ===
  hardware.acpilight.enable = true;
  hardware.enableAllFirmware = true;

  boot.initrd.kernelModules = [ "amdgpu" ];
  
  boot.kernelParams = [ 
    "amdgpu.sg_display=0"      # Убирает мерцание и фризы на встроенной графике
    "acpi_backlight=native"    # Корректная работа кнопок яркости
    "amdgpu.dcdebugmask=0x10"  # Фикс для Ryzen 5000: исправляет баги в коде управления питанием дисплея
    "idle=nomwait"             # Предотвращает "замирание" системы в простое
    "pcie_aspm=off"            # (Опционально) Помогает, если зависания связаны с шиной питания PCIe
  ];

  # Для T14 Gen 2 также полезно обновить микрокод процессора
  hardware.cpu.amd.updateMicrocode = true;
}

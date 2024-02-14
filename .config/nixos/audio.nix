{ pkgs, ... }:

{
    hardware.pulseaudio.enable = false; # seems to be necessary to avoid conflicts
   # rtkit is optional but recommended
    security.rtkit.enable = true;
    services.pipewire = {
        enable = true;
        alsa.enable = true;
        alsa.support32Bit = true;
        pulse.enable = true;
        # If you want to use JACK applications, uncomment this
        #jack.enable = true;
    };
}

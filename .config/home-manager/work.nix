{ pkgs, lib, user, ... }:

let
  git = {
    # credentials to use for company git
    username = user.name;
    email = user.email;

    access_token = ""; # if empty, will default to ssh
  };

  slack =
    pkgs.slack.overrideAttrs
      (oldAttrs: rec {
        version = "4.36.140";
        src = pkgs.fetchurl {
          url =
            "https://downloads.slack-edge.com/releases/linux/${version}/prod/x64/slack-desktop-${version}-amd64.deb";
          sha256 = "sha256-uQ82P69zWYcjG2U3Vte/+g5eMo5iVFUdbL2FxS6EUH0=";
        };

        fixupPhase = ''
          sed -i -e 's/,"WebRTCPipeWireCapturer"/,"LebRTCPipeWireCapturer"/' $out/lib/slack/resources/app.asar

          rm $out/bin/slack
          makeWrapper $out/lib/slack/slack $out/bin/slack \
            --prefix XDG_DATA_DIRS : $GSETTINGS_SCHEMAS_PATH \
            --suffix PATH : ${lib.makeBinPath [ pkgs.xdg-utils ]} \
            --add-flags "--ozone-platform-hint=auto --enable-features=WaylandWindowDecorations,WebRTCPipeWireCapturer"
        '';
      });
in
{

  home.packages = with pkgs; [
    # back
    golangci-lint
    protobuf
    protoc-gen-go
    protoc-gen-go-grpc

    # db
    cockroachdb-bin
    postgresql
    beekeeper-studio

    # pods
    tilt
    kubectl
    kind
    ctlptl

    # front
    nodejs_21
    corepack

    # chatting
    slack
  ];

  home.sessionVariables = {
    COCKROACH_BINARY = "${pkgs.cockroachdb-bin}/bin/cockroach";
  };

  # will fail if docker is not installed globally
  home.activation."ctlptl" = lib.hm.dag.entryAfter [ "writeBoundary" "installPackages" ] ''
    if [[ -v DRY_RUN ]] ; then exit 0 ; fi

    export PATH=$PATH:${pkgs.kind}/bin:${pkgs.ctlptl}/bin:${pkgs.docker}/bin:${pkgs.kubectl}/bin

    cat <<EOF | ctlptl apply -f -
    apiVersion: ctlptl.dev/v1alpha1
    kind: Cluster
    product: kind
    registry: ctlptl-registry
    EOF
  '';

  programs = {
    go = {
      enable = true;
      goPrivate = [
        "github.com/getalternative"
      ];
    };

    git = {
      enable = true;
      extraConfig = {
        url = (
          if (git.access_token == "") then
            {
              "git@github.com:getalternative" = {
                insteadOf = "https://github.com/getalternative";
              };
            }
          else
            {
              "https://${git.username}:${git.access_token}@github.com/getalternative" = {
                insteadOf = "https://github.com/getalternative";
              };
            }
        );
      };
      includes = [
        {
          condition = "hasconfig:remote.*.url:git@github.com:getalternative/**";
          contents = {
            user = {
              name = git.username;
              email = git.email;
            };
          };
        }
      ];
    };
  };
}


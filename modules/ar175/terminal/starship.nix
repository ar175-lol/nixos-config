_: {
  users.ar175.nixos.pc = {
    programs.starship = {
      enable = true;
      settings = {
        format = "[░▒▓](fg:#a6adc8)$os[](bg:#89b4fa fg:#a6adc8)$directory[](fg:#89b4fa bg:#45475a)$git_branch[](fg:#45475a bg:#1e1e2e)$time[](fg:#1e1e2e)\n[╰─](fg:#45475a)$character";

        os = {
          style = "bg:#a6adc8 fg:#1e1e2e";
          format = "[$symbol]($style)";
          disabled = false;
          symbols = {
            Android = "";
            NixOS = "";
          };
        };

        directory = {
          style = "fg:#cdd6f4 bg:#89b4fa";
          format = "[ $path ]($style)";
          truncation_length = 3;
          truncation_symbol = "../";
          substitutions = {
            Documents = "󰈙 ";
            Downloads = " ";
            Music = " ";
            Pictures = " ";
          };
        };

        git_branch = {
          symbol = "";
          style = "bg:#45475a";
          format = "[[ $symbol $branch ](fg:#89b4fa bg:#45475a)]($style)";
        };

        time = {
          disabled = false;
          time_format = "%R";
          style = "bg:#1e1e2e";
          format = "[[  $time ](fg:#a6adc8 bg:#1e1e2e)]($style)";
        };

        character = {
          format = "$symbol ";
          success_symbol = "[❯](bold #89b4fa)";
          error_symbol = "[❯](bold #f38ba8)";
        };
      };
    };
  };
}

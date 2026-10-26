_: {
  programs.starship = {
    enable = true;
    settings = {
      format = "[░▒▓](fg:#a6adc8)$os[](bg:#cba6f7 fg:#a6adc8)$directory[](fg:#cba6f7 bg:#45475a)$git_branch[](fg:#45475a bg:#1e1e2e)$time[](fg:#1e1e2e)\n[╰─](fg:#45475a)$character";

      directory = {
        style = "fg:#1e1e2e bg:#cba6f7";
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
        format = "[[ $symbol $branch ](fg:#cba6f7 bg:#45475a)]($style)";
      };

      time = {
        disabled = false;
        time_format = "%R";
        style = "bg:#1e1e2e";
        format = "[[  $time ](fg:#a6adc8 bg:#1e1e2e)]($style)";
      };

      character = {
        format = "$symbol ";
        success_symbol = "[❯](bold #cba6f7)";
        error_symbol = "[❯](bold #f38ba8)";
      };
    };
  };
}

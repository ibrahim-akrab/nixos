# nbfc.nix
{
  config,
  inputs,
  pkgs,
  ...
}: {
  environment.systemPackages = with pkgs; [
    inputs.nbfc-linux.packages.x86_64-linux.default
    (pkgs.writeShellScriptBin "set-charge-limit" ''
      # Function to print usage
      print_usage() {
          echo "Usage: $(basename $0) <percentage>"
          echo "  <percentage>   A battery percentage between 0 and 100."
          echo "  -h, --help Show this help message."
      }

      # Check for help flag
      if [ "$1" = "-h" ] || [ "$1" = "--help" ]; then
          print_usage
          exit 0
      fi

      # Check if an argument is provided
      if [ $# -ne 1 ]; then
          print_usage
          exit 1
      fi

      # Read the argument
      input="$1"

      # Validate the input to ensure it is a number between 0 and 100
      if ! [ "$input" -eq "$input" ] 2>/dev/null || [ "$input" -lt 0 ] || [ "$input" -gt 100 ]; then
          echo "Error: percentage must be a number between 0 and 100."
          exit 1
      fi

      # Add 128 to the input number (msi decided this offset)
      result=$((input + 128))

      # Convert the result to hexadecimal format
      hex_result=$(printf '0x%X\n' "$result")

      # write value to embedded controller's register (0xD7)
      sudo ${inputs.nbfc-linux.packages.x86_64-linux.default}/bin/ec_probe write 0xD7 "$hex_result"
    '')
  ];
}

import 
  std/osproc,
  std/parsecfg,
  system

if defined(posix)==false:
  system.quit("ERROR: Not a posix system", -1)

let
  (kernel,error1) = execcmdex("uname -r")
  (host,error2) = execcmdex("uname -n")
  (cpuname,error3) = execcmdex("""lscpu | grep 'Model name' | cut -f 2 -d ":" | awk '{$1=$1}1'""")
  cpucores: int = countProcessors()

proc getDistro*(): string =
  result = "/etc/os-release".loadConfig.getSectionValue("", "PRETTY_NAME")

write(stdout,"Host: ", host)
echo("Distro: ", getDistro())
write(stdout,"Kernel: ", kernel)
write(stdout,"CPU: ", cpuname)
echo("Core(s): ", cpucores)

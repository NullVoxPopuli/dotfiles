if [ "$(nvram get wan_proto)" == "pppoe" ]; then
    WAN_IF="$(nvram get pppoe_ifname)"
elif [ "$(nvram get wan_proto)" == "pptp" ]; then
    WAN_IF="$(nvram get pptp_ifname)"
else
    WAN_IF="$(nvram get wan_ifname)"
fi

# Usage:
#   killswitch_for ipv4Address
function killswitch_for {
  local address=$1

  iptables \
    --insert FORWARD \
    --source $address \
    --out-interface $WAN_IF \
    --jump REJECT \
    --reject-with icmp-host-prohibited

  iptables \
    --insert FORWARD \
    --source $address \
    --out-interface $WAN_IF \
    --protocol tcp \
    --jump REJECT \
    --reject-with tcp-reset
}

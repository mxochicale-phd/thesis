clear


echo '#################################################################'
echo '## Ubuntu Version: $lsb_release -a'
lsb_release -a


echo '#################################################################'
echo '## Machine Arquitecture: $uname -a'
uname -a


echo '#################################################################'
echo '## CPU INFO: $grep -E: (^model name|^vendor_id|^flags) /proc/cpuinfo | sort | uniq'
grep -E '(^model name|^vendor_id|^flags)' /proc/cpuinfo | sort | uniq


echo '#################################################################'
echo '#GRAPHIC CARD INFO:  $lspci -vnn | grep VGA -A 12'
lspci -vnn | grep VGA -A 12


echo '#################################################################'
echo '## gcc version: $gcc --version -O3 -std=c99'
gcc --version -O3 -std=c99




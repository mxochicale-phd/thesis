
```
sh machineinfo.sh
```
on Sun 11 Aug 17:34:52 BST 2019


```
#################################################################
## Ubuntu Version: $lsb_release -a
No LSB modules are available.
Distributor ID:	Ubuntu
Description:	Ubuntu 18.04.3 LTS
Release:	18.04
Codename:	bionic
#################################################################
## Machine Arquitecture: $uname -a
Linux blue 4.18.0-15-generic #16~18.04.1-Ubuntu SMP Thu Feb 7 14:06:04 UTC 2019 x86_64 x86_64 x86_64 GNU/Linux
#################################################################
## CPU INFO: $grep -E: (^model name|^vendor_id|^flags) /proc/cpuinfo | sort | uniq
flags		: fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe syscall nx pdpe1gb rdtscp lm constant_tsc art arch_perfmon pebs bts rep_good nopl xtopology nonstop_tsc cpuid aperfmperf tsc_known_freq pni pclmulqdq dtes64 monitor ds_cpl vmx est tm2 ssse3 sdbg fma cx16 xtpr pdcm pcid sse4_1 sse4_2 x2apic movbe popcnt tsc_deadline_timer aes xsave avx f16c rdrand lahf_lm abm 3dnowprefetch cpuid_fault epb invpcid_single pti ssbd ibrs ibpb stibp tpr_shadow vnmi flexpriority ept vpid fsgsbase tsc_adjust bmi1 avx2 smep bmi2 erms invpcid mpx rdseed adx smap clflushopt intel_pt xsaveopt xsavec xgetbv1 xsaves dtherm ida arat pln pts hwp hwp_notify hwp_act_window hwp_epp flush_l1d
model name	: Intel(R) Core(TM) i5-8250U CPU @ 1.60GHz
vendor_id	: GenuineIntel
#################################################################
#GRAPHIC CARD INFO:  $lspci -vnn | grep VGA -A 12
00:02.0 VGA compatible controller [0300]: Intel Corporation UHD Graphics 620 [8086:5917] (rev 07) (prog-if 00 [VGA controller])
	Subsystem: Huawei Technologies Co., Ltd. UHD Graphics 620 [19e5:3e04]
	Flags: bus master, fast devsel, latency 0, IRQ 139
	Memory at 2ff2000000 (64-bit, non-prefetchable) [size=16M]
	Memory at 2fc0000000 (64-bit, prefetchable) [size=256M]
	I/O ports at 3000 [size=64]
	[virtual] Expansion ROM at 000c0000 [disabled] [size=128K]
	Capabilities: <access denied>
	Kernel driver in use: i915
	Kernel modules: i915

00:04.0 Signal processing controller [1180]: Intel Corporation Xeon E3-1200 v5/E3-1500 v5/6th Gen Core Processor Thermal Subsystem [8086:1903] (rev 08)
	Subsystem: Huawei Technologies Co., Ltd. Xeon E3-1200 v5/E3-1500 v5/6th Gen Core Processor Thermal Subsystem [19e5:3e04]
xima@blue:~/phd/thesis/0_code_data/1_code/0_machineinfo$ 
```



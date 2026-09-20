@echo off
rem ================================================================
rem  KAT-Coder-V2.5-Dev APEX I-Compact (15.4G, Kuaishou Kwaipilot)
rem  on Thetom TQP v0.3.0 engine - 2026-09-19 FINAL (validated)
rem  MEASURED (server probe, production params):
rem    load 22s | smoke CN/code/math all correct
rem    PP 1080 @20K depth / 823 @118K depth
rem    TG 36.3 @20K / 21.2 @118K (first 35B-class over 20 t/s deep)
rem    TG 40-41 shallow - same league as Ornith (392 vs 378 ctrl)
rem  NOTES:
rem    - NO -ngl flag: let --fit auto-balance (ngl 99 aborts fit =
rem      Sysmem Fallback 10x slowdown, verified)
rem    - NO manual ncmoe: fit beats explicit ncmoe 35 (TG -8.6%)
rem    - no mmproj: KAT ships text-only weights
rem    - MTP: officially none (mtp_num_hidden_layers=0); mixed-offload
rem      MTP is negative anyway - keep spec none
rem  ================================================================
cd /d D:\llm\bin\atomic-b10269\pkg\build\bin
llama-server.exe ^
  -m "D:\lmstudio-models\mudler\KAT-Coder-V2.5-Dev-APEX-I-Compact.gguf" ^
  -c 131072 -np 1 -fa on ^
  -ctk turbo4 -ctv turbo4 ^
  -b 2816 -ub 2816 ^
  --threads 24 ^
  --cache-prompt --ctx-checkpoints 8 ^
  --no-mmap --mlock --spec-type none ^
  --reasoning on --reasoning-budget 2048 --reasoning-budget-message "Thinking budget reached; continue to the final answer based on the analysis so far." --reasoning-preserve --jinja --reasoning-format deepseek ^
  --host 127.0.0.1 --port 24558
pause

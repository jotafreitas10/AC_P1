@echo off
REM ****************************************************************************
REM Vivado (TM) v2024.2 (64-bit)
REM
REM Filename    : simulate.bat
REM Simulator   : AMD Vivado Simulator
REM Description : Script for simulating the design by launching the simulator
REM
REM Generated by Vivado on Tue Mar 11 15:57:16 +0000 2025
REM SW Build 5239630 on Fri Nov 08 22:35:27 MST 2024
REM
REM Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
REM Copyright 2022-2024 Advanced Micro Devices, Inc. All Rights Reserved.
REM
REM usage: simulate.bat
REM
REM ****************************************************************************
REM simulate design
echo "xsim placa_mae_tb_behav -key {Behavioral:sim_1:Functional:placa_mae_tb} -tclbatch placa_mae_tb.tcl -log simulate.log"
call xsim  placa_mae_tb_behav -key {Behavioral:sim_1:Functional:placa_mae_tb} -tclbatch placa_mae_tb.tcl -log simulate.log
if "%errorlevel%"=="0" goto SUCCESS
if "%errorlevel%"=="1" goto END
:END
exit 1
:SUCCESS
exit 0

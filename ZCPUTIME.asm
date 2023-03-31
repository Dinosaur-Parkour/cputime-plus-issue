       TITLE 'Get CPU TIME in Microseconds'
ZCPUTIME RSECT
ZCPUTIME AMODE 31
ZCPUTIME RMODE ANY
*---------------------------------------------------------------------
* IMPORTANT:  CPUTIME must be invoked dynamically.
*---------------------------------------------------------------------
*      01  CPUTIME-DATA-ITEMS.
*          05 W-CPUTIME          PIC  X(08) VALUE 'CPUTIME'.
*          05 CPUTIME-Start      PIC  9(12)V9(6) COMP-5.
*          05 CPUTIME-End        PIC  9(12)V9(6) COMP-5.
*          05 CPUTIME-Diff       PIC  9(12)V9(6) COMP-5.
*          05 CPUTIME-Show-CPU   PIC  ZZZ,ZZZ,ZZZ,ZZ9.9(6).
* __Stage_____
* 1 Start-Time   Call W-CPUTIME Using CPUTIME-Start
*
* 2 Measure      Perform Cnt  Times
* 2   This          Whatever you want to measure
* 2     Code     End-perform
*
* 3 End-Time     Call W-CPUTIME Using CPUTIME-End
*
* 4 Calc Diff    Compute CPUTIME-DIFF = CPUTIME-End - CPUTIME-Start
* 4   Format     Move CPUTIME-DIFF to CPUTIME-Show-CPU
* 4   & Show     Display 'TCB/CPU seconds: ' CPUTIME-Show-CPU
*
*   CPUTIME of 9(12)V9(6) maps as  seconds V microseconds
*   CPUTIME of 9(18)      maps as  microseconds
*
* IMPORTANT:  CPUTIME must be invoked dynamically.
*---------------------------------------------------------------------
*
* Start: Program Entry    (NO SaveArea)
       PRINT ON,GEN
       SAVE    (14,12)
       LR      R12,R15             BASE REGISTER FOR THIS PGM = R12
       USING   ZCPUTIME,R12
* End: Program Entry


*---------------------------------------------------------------------
*  PROGRAM LOGIC
THISPGM EQU  *
       L     R2,0(,R1)    Parm 1:  PIC 9(12)V9(6) or 9(18) COMP-5.
AGAIN  TIMEUSED  STORADR=(R2),LINKAGE=SYSTEM,CPU=MIC
       CFI   R15,8
       BE    AGAIN               RC = 08 :  Try again
       BH    ERROR               RC > 08 :  abend


*---------------------------------------------------------------------
* Program Exit                   Successful   CC = 00
DONE   EQU *
       XR    R15,R15             RC=00
       Return (14,12),RC=(15)

*--------------------------------------------------------------------
* Abend when TimeUsed has a problem.
* The bad return code in R15 is wiped out by WTO... Save it in R11
*--------------------------------------------------------------------
ERROR  EQU   *
       LR  R11,R15      SAVE return code in R11
       XR  R0,R0        Clear R0 to be safe.
       WTO '*- Error! -------------------------------------------'
       WTO ' ZCPUTIME:  TIMEUSED Macro had a Return Code > 8'
       WTO '           Return Code from TIMEUSED saved in R11.'
       WTO '*----------------------------------------------------'
       ABEND  0012,DUMP
*--------------------------------------------------------------------
DATA   LTORG
       COPY  REGISTER
       END

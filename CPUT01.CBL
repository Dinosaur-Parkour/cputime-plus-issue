       CBL OPT(2),DYNAM
       CBL ARCH(12) TUNE(12)
       CBL DISPSIGN(SEP)
       IDENTIFICATION DIVISION.
    5  PROGRAM-ID.    CPUT01.
      *===============================================================
      *  Call VARIABLE Test of:
      *     ZCPUTIME   CPU=MIC;   NO SAVE-AREA
      *     CPUTIME2   CPU=MIC    Has a Save-Area
      *     CPUTIME9   ECT=YES    NO SAVE-AREA
      *===============================================================
   12  DATA DIVISION.
   13  WORKING-STORAGE SECTION.


   16  01  CPUTIME-DATA-ITEMS.
   17      05 CPUTIME-WORK       PIC  9(12)V9(6) COMP-5.
   18      05 ZCPUTIME-Start     PIC  9(12)V9(6) COMP-5.
   19      05 CPUTIME9-Start     PIC  9(12)V9(6) COMP-5.
   20      05 ZCPUTIME-End       PIC  9(12)V9(6) COMP-5.
   21      05 CPUTIME9-End       PIC  9(12)V9(6) COMP-5.
   22      05 CPUTIME-Diff       PIC  9(12)V9(6) COMP-5.
   23      05 CPUTIME-Show-CPU   PIC              ZZ9.9(6).
   24      05 COBOL-DIFF         PIC  9(03)V9(6) COMP-5.
   25      05 W-CPUTIME2         PIC  X(08) Value 'CPUTIME2'.
   26      05 W-CPUTIME9         PIC  X(08) Value 'CPUTIME9'.
   27      05 W-ZCPUTIME         PIC  X(08) Value 'ZCPUTIME'.
   25      05 W-CPUTIME3         PIC  X(08) Value 'CPUTIME3'.


      *===============================================================
   31  PROCEDURE DIVISION.
      *---------------------------------------------------------------
      *
      *---------------------------------------------------------------
   35  PROGRAM-MAIN.
   36      Perform Get-Start-CPU         *> Setup call


   39      DISPLAY 'Measure ZCPUTIME   1 million Times: '
   40      Perform Measure-ZCPUTIME  3 times

   42      DISPLAY ' '
   43      DISPLAY 'Measure CPUTIME2   1 million Times: '
   44      Perform Measure-CPUTIME2  3 times

   46      DISPLAY ' '
   47      DISPLAY 'Measure CPUTIME9   1 million Times: '
   48      Perform Measure-CPUTIME9  3 times

   46      DISPLAY ' '
   47      DISPLAY 'Measure CPUTIME3   1 million Times: '
   48      Perform Measure-CPUTIME3  3 times

   50      GOBACK.


      *--------------------------------------------------------------
      *  Measure Calling ZCPUTIME
      *--------------------------------------------------------------
   56  Measure-ZCPUTIME.
   57      Perform Get-Start-CPU
   58      Perform 1000000 Times
   59          Call W-ZCPUTIME  Using CPUTIME-WORK
   60      End-Perform
   61      Perform Get-End-CPU
   62      Perform Show-CPU-Used
   63      EXIT.


      *--------------------------------------------------------------
      *  Measure Calling CPUTIME2
      *--------------------------------------------------------------
   69  Measure-CPUTIME2.
   70      Perform Get-Start-CPU
   71      Perform 1000000 Times
   72          Call W-CPUTIME2 Using CPUTIME-WORK
   73      End-Perform
   74      Perform Get-End-CPU
   75      Perform Show-CPU-Used
   76      EXIT.


      *--------------------------------------------------------------
      *  Measure Calling CPUTIME9
      *--------------------------------------------------------------
   82  Measure-CPUTIME9.
   83      Perform Get-Start-CPU
   84      Perform 1000000 Times
   85          Call W-CPUTIME9 Using CPUTIME-WORK
   86      End-Perform
   87      Perform Get-End-CPU
   88      Perform Show-CPU-Used
   89      EXIT.


      *--------------------------------------------------------------
      *  Measure Calling CPUTIME3
      *--------------------------------------------------------------
   82  Measure-CPUTIME3.
   83      Perform Get-Start-CPU
   84      Perform 1000000 Times
   85          Call W-CPUTIME3 Using CPUTIME-WORK
   86      End-Perform
   87      Perform Get-End-CPU
   88      Perform Show-CPU-Used
   89      EXIT.





      *--------------------------------------------------------------
      *    get the CPU Usage before the code to be measured.
      *--------------------------------------------------------------
   98  GET-Start-CPU.
   99      Call W-ZCPUTIME Using ZCPUTIME-Start
  100      Call W-CPUTIME9 Using CPUTIME9-Start
  101      EXIT.


      *--------------------------------------------------------------
      *    get the CPU Usage before the code to be measured.
      *--------------------------------------------------------------
  107  GET-End-CPU.
  108      Call W-CPUTIME9 Using CPUTIME9-End
  109      Call W-ZCPUTIME Using ZCPUTIME-End
  110      EXIT.


      *--------------------------------------------------------------
      *    Calculate the amount Of CPU Used and SHOW results
      *--------------------------------------------------------------
  116  Show-CPU-Used.
  117      Compute CPUTIME-DIFF = CPUTIME9-End - CPUTIME9-Start
  118      Move CPUTIME-DIFF to CPUTIME-Show-CPU
  119      Display ' 9 E: '  CPUTIME9-End '  -  S: '  CPUTIME9-Start
  120              ' =  '  CPUTIME-Show-CPU

  122      Compute CPUTIME-DIFF = ZCPUTIME-End - ZCPUTIME-Start
  123      Move CPUTIME-DIFF to CPUTIME-Show-CPU
  124      Display ' Z E: '  ZCPUTIME-End '  -  S: '  ZCPUTIME-Start
  125              ' =  '  CPUTIME-Show-CPU
  126      Display ' '
  127      EXIT.


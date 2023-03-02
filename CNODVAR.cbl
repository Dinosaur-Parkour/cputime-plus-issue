       CBL OPT(2),NODYNAM                                             
       CBL ARCH(12) TUNE(12)                                          
       CBL DISPSIGN(SEP)                                              
       IDENTIFICATION DIVISION.                                       
       PROGRAM-ID.    CDYNVAR.                                        
      *===============================================================
      *  NoDynam   CALL VAR                                           
      *===============================================================
       DATA DIVISION.                                                 
       WORKING-STORAGE SECTION.                                       
       01  Work-Fields.                                               
           05 W-A31BR14     PIC  X(08) Value 'A31BR14'.               
                                                                      
                                                                      
       01  CPUTIME-DATA-ITEMS.                                        
           05 W-CPUTIME          PIC  X(08) Value 'CPUTIME'.          
           05 CPUTIME-Start      PIC  9(12)V9(6) COMP-5.              
           05 CPUTIME-End        PIC  9(12)V9(6) COMP-5.              
           05 CPUTIME-Diff       PIC  9(12)V9(6) COMP-5.              
           05 CPUTIME-Show-CPU   PIC  ZZZ,ZZZ,ZZZ,ZZ9.9(6).           
           05 COBOL-DIFF         PIC  9(12)V9(6) COMP-5.              
                                                                      
                                                                      
      *===============================================================
       PROCEDURE DIVISION.                                            
      *---------------------------------------------------------------
      *                                                               
      *---------------------------------------------------------------
       PROGRAM-MAIN.                                                  
                                                                      
      * Burn some CPU Cycles.                                         
           Perform 2500000 Times                                      
               Call W-A31BR14  Using CPUTIME-Data-Items               
           End-Perform                                                
                                                                      
                                                                      
           Call W-CPUTIME Using CPUTIME-START                         
                                                                      
           Perform 750000 Times                                       
               Call W-A31BR14  Using CPUTIME-Data-Items               
           End-Perform                                                
                                                                      
           Call W-CPUTIME Using CPUTIME-End                           
           Display 'Results for NoDYNAM  CALL VAR:'                  
           Perform Show-CPU-Used                                     
           GOBACK.                                                   
                                                                     
                                                                     
                                                                     
      *--------------------------------------------------------------
      *    Calculate the amount Of CPU Used and SHOW results         
      *--------------------------------------------------------------
       Show-CPU-Used.                                                
           Compute CPUTIME-DIFF = CPUTIME-End - CPUTIME-Start        
           Move CPUTIME-DIFF to CPUTIME-Show-CPU                     
           Display '       End   : '  CPUTIME-End                    
           Display ' Minus Start : '  CPUTIME-Start                  
           Display ' Differnce   : '  CPUTIME-Show-CPU               
           Display ' '                                               
           EXIT.                                                     
                                                                     

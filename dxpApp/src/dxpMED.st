program dxpMED("P=13GE2:med:,DXP=dxp,MCA=mca,N_DETECTORS=16")

/*  This sequencer program works with dxp.db and dxpMED.db. 
 *  It supports copying PVs from the first DXP to all of the DXPs
 *  and multi-element MCA operations
 *
 *  Mark Rivers
 *  January 7, 2005
 *
/* This program must be compiled with the recursive option so that multiple copies
 * can run at once */
option +r;

#define MAX_DETECTORS 30

int i;
int det;
int nDetectors;
char temp[100];

char *prefix;
char *dxp;
char *mca;

double  TRIG_PKTIM[MAX_DETECTORS];
assign  TRIG_PKTIM to {"","","","","","","","","","","","","","","","","","","","","","","","","","","","","",""};
int     copyTRIG_PKTIM; assign copyTRIG_PKTIM to "{P}CopyTRIG_PKTIM";
monitor copyTRIG_PKTIM; evflag copyTRIG_PKTIMMon; sync copyTRIG_PKTIM copyTRIG_PKTIMMon;

double  TRIG_GAPTIM[MAX_DETECTORS];
assign  TRIG_GAPTIM to {"","","","","","","","","","","","","","","","","","","","","","","","","","","","","",""};
int     copyTRIG_GAPTIM; assign copyTRIG_GAPTIM to "{P}CopyTRIG_GAPTIM";
monitor copyTRIG_GAPTIM; evflag copyTRIG_GAPTIMMon; sync copyTRIG_GAPTIM copyTRIG_GAPTIMMon;

double  FAST_TRIG[MAX_DETECTORS]; 
assign  FAST_TRIG to {"","","","","","","","","","","","","","","","","","","","","","","","","","","","","",""};
int     copyFAST_TRIG; assign copyFAST_TRIG to "{P}CopyFAST_TRIG";
monitor copyFAST_TRIG; evflag copyFAST_TRIGMon; sync copyFAST_TRIG copyFAST_TRIGMon;

double  PKTIM[MAX_DETECTORS]; 
assign  PKTIM to {"","","","","","","","","","","","","","","","","","","","","","","","","","","","","",""};
int     copyPKTIM; assign copyPKTIM to "{P}CopyPKTIM";
monitor copyPKTIM; evflag copyPKTIMMon; sync copyPKTIM copyPKTIMMon;

double  GAPTIM[MAX_DETECTORS]; 
assign  GAPTIM to {"","","","","","","","","","","","","","","","","","","","","","","","","","","","","",""};
int     copyGAPTIM; assign copyGAPTIM to "{P}CopyGAPTIM";
monitor copyGAPTIM; evflag copyGAPTIMMon; sync copyGAPTIM copyGAPTIMMon;

double  SLOW_TRIG[MAX_DETECTORS]; 
assign  SLOW_TRIG to {"","","","","","","","","","","","","","","","","","","","","","","","","","","","","",""};
int     copySLOW_TRIG; assign copySLOW_TRIG to "{P}CopySLOW_TRIG";
monitor copySLOW_TRIG; evflag copySLOW_TRIGMon; sync copySLOW_TRIG copySLOW_TRIGMon;

double  MAX_WIDTH[MAX_DETECTORS]; 
assign  MAX_WIDTH to {"","","","","","","","","","","","","","","","","","","","","","","","","","","","","",""};
int     copyMAX_WIDTH; assign copyMAX_WIDTH to "{P}CopyMAX_WIDTH";
monitor copyMAX_WIDTH; evflag copyMAX_WIDTHMon; sync copyMAX_WIDTH copyMAX_WIDTHMon;

double  BASE_CUT_PCT[MAX_DETECTORS]; 
assign  BASE_CUT_PCT to {"","","","","","","","","","","","","","","","","","","","","","","","","","","","","",""}; 
int     copyBASE_CUT_PCT; assign copyBASE_CUT_PCT to "{P}CopyBASE_CUT_PCT";
monitor copyBASE_CUT_PCT; evflag copyBASE_CUT_PCTMon; sync copyBASE_CUT_PCT copyBASE_CUT_PCTMon;

double  BASE_CUT_ENBL[MAX_DETECTORS]; 
assign  BASE_CUT_ENBL to {"","","","","","","","","","","","","","","","","","","","","","","","","","","","","",""};
int     copyBASE_CUT_ENBL; assign copyBASE_CUT_ENBL to "{P}CopyBASE_CUT_ENBL";
monitor copyBASE_CUT_ENBL; evflag copyBASE_CUT_ENBLMon; sync copyBASE_CUT_ENBL copyBASE_CUT_ENBLMon;

double  BASE_THRESH[MAX_DETECTORS]; 
assign  BASE_THRESH to {"","","","","","","","","","","","","","","","","","","","","","","","","","","","","",""};
int     copyBASE_THRESH; assign copyBASE_THRESH to "{P}CopyBASE_THRESH";
monitor copyBASE_THRESH; evflag copyBASE_THRESHMon; sync copyBASE_THRESH copyBASE_THRESHMon;

double  BASE_THRESH_ENBL[MAX_DETECTORS]; 
assign  BASE_THRESH_ENBL to {"","","","","","","","","","","","","","","","","","","","","","","","","","","","","",""};
int     copyBASE_THRESH_ENBL; assign copyBASE_THRESH_ENBL to "{P}CopyBASE_THRESH_ENBL";
monitor copyBASE_THRESH_ENBL; evflag copyBASE_THRESH_ENBLMon; sync copyBASE_THRESH_ENBL copyBASE_THRESH_ENBLMon;

double  BASE_THRESHADJ[MAX_DETECTORS]; 
assign  BASE_THRESHADJ to {"","","","","","","","","","","","","","","","","","","","","","","","","","","","","",""};
int     copyBASE_THRESHADJ; assign copyBASE_THRESHADJ to "{P}CopyBASE_THRESHADJ";
monitor copyBASE_THRESHADJ; evflag copyBASE_THRESHADJMon; sync copyBASE_THRESHADJ copyBASE_THRESHADJMon;

double  EMAX[MAX_DETECTORS]; 
assign  EMAX to {"","","","","","","","","","","","","","","","","","","","","","","","","","","","","",""};
int     copyEMAX; assign copyEMAX to "{P}CopyEMAX";
monitor copyEMAX; evflag copyEMAXMon; sync copyEMAX copyEMAXMon;

double  ADC_RULE[MAX_DETECTORS]; 
assign  ADC_RULE to {"","","","","","","","","","","","","","","","","","","","","","","","","","","","","",""};
int     copyADC_RULE; assign copyADC_RULE to "{P}CopyADC_RULE";
monitor copyADC_RULE; evflag copyADC_RULEMon; sync copyADC_RULE copyADC_RULEMon;

int     mcaStart[MAX_DETECTORS]; 
assign  mcaStart to {"","","","","","","","","","","","","","","","","","","","","","","","","","","","","",""};
int     StartAll; assign StartAll to "{P}StartAll";
monitor StartAll; evflag StartAllMon; sync StartAll StartAllMon;

int     mcaStop[MAX_DETECTORS]; 
assign  mcaStop to {"","","","","","","","","","","","","","","","","","","","","","","","","","","","","",""};
int     StopAll; assign StopAll to "{P}StopAll";
monitor StopAll; evflag StopAllMon; sync StopAll StopAllMon;

int     mcaErase[MAX_DETECTORS]; 
assign  mcaErase to {"","","","","","","","","","","","","","","","","","","","","","","","","","","","","",""};
int     EraseAll; assign EraseAll to "{P}EraseAll";
monitor EraseAll; evflag EraseAllMon; sync EraseAll EraseAllMon;

int     mcaEraseStart[MAX_DETECTORS]; 
assign  mcaEraseStart to {"","","","","","","","","","","","","","","","","","","","","","","","","","","","","",""};
int     EraseStart; assign EraseStart to "{P}EraseStart";
monitor EraseStart; evflag EraseStartMon; sync EraseStart EraseStartMon;

int     readDXP[MAX_DETECTORS]; 
assign  readDXP to {"","","","","","","","","","","","","","","","","","","","","","","","","","","","","",""};
int     readDXPs; assign readDXPs to "{P}DoReadDXPs";
monitor readDXPs; evflag readDXPsMon; sync readDXPs readDXPsMon;

int     readMCA[MAX_DETECTORS]; 
assign  readMCA to {"","","","","","","","","","","","","","","","","","","","","","","","","","","","","",""};
int     ReadMCAs; assign ReadMCAs to "{P}DoReadAll";
monitor ReadMCAs; evflag ReadMCAsMon; sync ReadMCAs ReadMCAsMon;

int     statusMCA[MAX_DETECTORS];
assign  statusMCA to {"","","","","","","","","","","","","","","","","","","","","","","","","","","","","",""};
int     StatusMCAs; assign StatusMCAs to "{P}DoStatusAll";
monitor StatusMCAs; evflag StatusMCAsMon; sync StatusMCAs StatusMCAsMon;

double  mcaPresetReal[MAX_DETECTORS]; 
assign  mcaPresetReal to {"","","","","","","","","","","","","","","","","","","","","","","","","","","","","",""};
double  PresetReal; assign PresetReal to "{P}PresetReal";
monitor PresetReal; evflag PresetRealMon; sync PresetReal PresetRealMon;

double  mcaPresetLive[MAX_DETECTORS]; 
assign  mcaPresetLive to {"","","","","","","","","","","","","","","","","","","","","","","","","","","","","",""};
double  PresetLive; assign PresetLive to "{P}PresetLive";
monitor PresetLive; evflag PresetLiveMon; sync PresetLive PresetLiveMon;

int     mcaAcquiring[MAX_DETECTORS]; 
assign  mcaAcquiring to {"","","","","","","","","","","","","","","","","","","","","","","","","","","","","",""};
int     Acquiring; assign Acquiring to "{P}Acquiring";
evflag  AcquiringMon; sync mcaAcquiring AcquiringMon;

double  mcaElapsedReal[MAX_DETECTORS];
assign  mcaElapsedReal to {"","","","","","","","","","","","","","","","","","","","","","","","","","","","","",""};
double  ElapsedReal; assign ElapsedReal to "{P}ElapsedReal";
evflag  ElapsedRealMon; sync mcaElapsedReal ElapsedRealMon;

double  mcaElapsedLive[MAX_DETECTORS]; 
assign  mcaElapsedLive to {"","","","","","","","","","","","","","","","","","","","","","","","","","","","","",""};
double  ElapsedLive; assign ElapsedLive to "{P}ElapsedLive";
evflag  ElapsedLiveMon; sync mcaElapsedLive ElapsedLiveMon;

double  mcaDeadTime[MAX_DETECTORS]; 
assign  mcaDeadTime to {"","","","","","","","","","","","","","","","","","","","","","","","","","","","","",""};
double  DeadTime; assign DeadTime to "{P}DeadTime";
evflag  DeadTimeMon; sync mcaDeadTime DeadTimeMon;

ss dxp_control {
    state init {
        when() {
            /* We set the following event flags to force these modes and
               labels to be set correctly initially */
            prefix = macValueGet("P");
            dxp = macValueGet("DXP");
            mca = macValueGet("MCA");
            nDetectors = atoi(macValueGet("N_DETECTORS"));
            for (i=0; i<nDetectors; i++) {
               det = i+1;
               sprintf(temp, "%s%s%d.TRIG_PKTIM", prefix, dxp, det);
               pvAssign(TRIG_PKTIM[i], temp);
               sprintf(temp, "%s%s%d.TRIG_GAPTIM", prefix, dxp, det);
               pvAssign(TRIG_GAPTIM[i], temp);
               sprintf(temp, "%s%s%d.FAST_TRIG", prefix, dxp, det);
               pvAssign(FAST_TRIG[i], temp);
               sprintf(temp, "%s%s%d.PKTIM", prefix, dxp, det);
               pvAssign(PKTIM[i], temp);
               sprintf(temp, "%s%s%d.GAPTIM", prefix, dxp, det);
               pvAssign(GAPTIM[i], temp);
               sprintf(temp, "%s%s%d.SLOW_TRIG", prefix, dxp, det);
               pvAssign(SLOW_TRIG[i], temp);
               sprintf(temp, "%s%s%d.F05V", prefix, dxp, det);
               pvAssign(MAX_WIDTH[i], temp);
               sprintf(temp, "%s%s%d.BASE_CUT_PCT", prefix, dxp, det);
               pvAssign(BASE_CUT_PCT[i], temp);
               sprintf(temp, "%s%s%d.T11V", prefix, dxp, det);
               pvAssign(BASE_CUT_ENBL[i], temp);
               sprintf(temp, "%s%s%d.BASE_THRESH", prefix, dxp, det);
               pvAssign(BASE_THRESH[i], temp);
               sprintf(temp, "%s%s%d.T14V", prefix, dxp, det);
               pvAssign(BASE_THRESH_ENBL[i], temp);
               sprintf(temp, "%s%s%d.BASE_THRESHADJ", prefix, dxp, det);
               pvAssign(BASE_THRESHADJ[i], temp);
               sprintf(temp, "%s%s%d.EMAX", prefix, dxp, det);
               pvAssign(EMAX[i], temp);
               sprintf(temp, "%s%s%d.ADC_RULE", prefix, dxp, det);
               pvAssign(ADC_RULE[i], temp);
               sprintf(temp, "%s%s%d.STRT", prefix, mca, det);
               pvAssign(mcaStart[i], temp);
               sprintf(temp, "%s%s%d.STOP", prefix, mca, det);
               pvAssign(mcaStop[i], temp);
               sprintf(temp, "%s%s%d.ERAS", prefix, mca, det);
               pvAssign(mcaErase[i], temp);
               sprintf(temp, "%s%s%d.ERST", prefix, mca, det);
               pvAssign(mcaEraseStart[i], temp);
               sprintf(temp, "%s%s%d.PROC", prefix, dxp, det);
               pvAssign(readDXP[i], temp);
               sprintf(temp, "%s%s%d.READ", prefix, mca, det);
               pvAssign(readMCA[i], temp);
               sprintf(temp, "%s%s%d.PROC", prefix, mca, det);
               pvAssign(statusMCA[i], temp);
               sprintf(temp, "%s%s%d.PRTM", prefix, mca, det);
               pvAssign(mcaPresetReal[i], temp);
               sprintf(temp, "%s%s%d.PLTM", prefix, mca, det);
               pvAssign(mcaPresetLive[i], temp);
               sprintf(temp, "%s%s%d.ACQG", prefix, mca, det);
               pvAssign(mcaAcquiring[i], temp);
               pvMonitor(mcaAcquiring[i]);
               sprintf(temp, "%s%s%d.ERTM", prefix, mca, det);
               pvAssign(mcaElapsedReal[i], temp);
               pvMonitor(mcaElapsedReal[i]);
               sprintf(temp, "%s%s%d.ELTM", prefix, mca, det);
               pvAssign(mcaElapsedLive[i], temp);
               pvMonitor(mcaElapsedLive[i]);
               sprintf(temp, "%s%s%d.IDTIM", prefix, mca, det);
               pvAssign(mcaDeadTime[i], temp);
               pvMonitor(mcaDeadTime[i]);
           }
        } state monitor_changes
    }
    state monitor_changes {
        when(efTestAndClear(copyTRIG_PKTIMMon) && (copyTRIG_PKTIM == 1)) {
            pvGet(TRIG_PKTIM[0]);
            for (i=1; i<nDetectors; i++) {
                TRIG_PKTIM[i] = TRIG_PKTIM[0];
                pvPut(TRIG_PKTIM[i]);
            }
            copyTRIG_PKTIM = 0;
            pvPut(copyTRIG_PKTIM);
        } state monitor_changes

        when(efTestAndClear(copyTRIG_GAPTIMMon) && (copyTRIG_GAPTIM == 1)) {
            pvGet(TRIG_GAPTIM[0]);
            for (i=1; i<nDetectors; i++) {
                TRIG_GAPTIM[i] = TRIG_GAPTIM[0];
                pvPut(TRIG_GAPTIM[i]);
            }
            copyTRIG_GAPTIM = 0;
            pvPut(copyTRIG_GAPTIM);
        } state monitor_changes

        when(efTestAndClear(copyFAST_TRIGMon) && (copyFAST_TRIG == 1)) {
            pvGet(FAST_TRIG[0]);
            for (i=1; i<nDetectors; i++) {
                FAST_TRIG[i] = FAST_TRIG[0];
                pvPut(FAST_TRIG[i]);
            }
            copyFAST_TRIG = 0;
            pvPut(copyFAST_TRIG);
        } state monitor_changes

        when(efTestAndClear(copyPKTIMMon) && (copyPKTIM == 1)) {
            pvGet(PKTIM[0]);
            for (i=1; i<nDetectors; i++) {
                PKTIM[i] = PKTIM[0];
                pvPut(PKTIM[i]);
            }
            copyPKTIM = 0;
            pvPut(copyPKTIM);
        } state monitor_changes

        when(efTestAndClear(copyGAPTIMMon) && (copyGAPTIM == 1)) {
            pvGet(GAPTIM[0]);
            for (i=1; i<nDetectors; i++) {
                GAPTIM[i] = GAPTIM[0];
                pvPut(GAPTIM[i]);
            }
            copyGAPTIM = 0;
            pvPut(copyGAPTIM);
        } state monitor_changes

        when(efTestAndClear(copySLOW_TRIGMon) && (copySLOW_TRIG == 1)) {
            pvGet(SLOW_TRIG[0]);
            for (i=1; i<nDetectors; i++) {
                SLOW_TRIG[i] = SLOW_TRIG[0];
                pvPut(SLOW_TRIG[i]);
            }
            copySLOW_TRIG = 0;
            pvPut(copySLOW_TRIG);
        } state monitor_changes

        when(efTestAndClear(copyMAX_WIDTHMon) && (copyMAX_WIDTH == 1)) {
            pvGet(MAX_WIDTH[0]);
            for (i=1; i<nDetectors; i++) {
                MAX_WIDTH[i] = MAX_WIDTH[0];
                pvPut(MAX_WIDTH[i]);
            }
            copyMAX_WIDTH = 0;
            pvPut(copyMAX_WIDTH);
        } state monitor_changes

        when(efTestAndClear(copyBASE_CUT_PCTMon) && (copyBASE_CUT_PCT == 1)) {
            pvGet(BASE_CUT_PCT[0]);
            for (i=1; i<nDetectors; i++) {
                BASE_CUT_PCT[i] = BASE_CUT_PCT[0];
                pvPut(BASE_CUT_PCT[i]);
            }
            copyBASE_CUT_PCT = 0;
            pvPut(copyBASE_CUT_PCT);
        } state monitor_changes

        when(efTestAndClear(copyBASE_CUT_ENBLMon) && (copyBASE_CUT_ENBL == 1)) {
            pvGet(BASE_CUT_ENBL[0]);
            for (i=1; i<nDetectors; i++) {
                BASE_CUT_ENBL[i] = BASE_CUT_ENBL[0];
                pvPut(BASE_CUT_ENBL[i]);
            }
            copyBASE_CUT_ENBL = 0;
            pvPut(copyBASE_CUT_ENBL);
        } state monitor_changes

        when(efTestAndClear(copyBASE_THRESHMon) && (copyBASE_THRESH == 1)) {
            pvGet(BASE_THRESH[0]);
            for (i=1; i<nDetectors; i++) {
                BASE_THRESH[i] = BASE_THRESH[0];
                pvPut(BASE_THRESH[i]);
            }
            copyBASE_THRESH = 0;
            pvPut(copyBASE_THRESH);
        } state monitor_changes

        when(efTestAndClear(copyBASE_THRESH_ENBLMon) && (copyBASE_THRESH_ENBL == 1)) {
            pvGet(BASE_THRESH_ENBL[0]);
            for (i=1; i<nDetectors; i++) {
                BASE_THRESH_ENBL[i] = BASE_THRESH_ENBL[0];
                pvPut(BASE_THRESH_ENBL[i]);
            }
            copyBASE_THRESH_ENBL = 0;
            pvPut(copyBASE_THRESH_ENBL);
        } state monitor_changes

        when(efTestAndClear(copyBASE_THRESHADJMon) && (copyBASE_THRESHADJ == 1)) {
            pvGet(BASE_THRESHADJ[0]);
            for (i=1; i<nDetectors; i++) {
                BASE_THRESHADJ[i] = BASE_THRESHADJ[0];
                pvPut(BASE_THRESHADJ[i]);
            }
            copyBASE_THRESHADJ = 0;
            pvPut(copyBASE_THRESHADJ);
        } state monitor_changes

        when(efTestAndClear(copyEMAXMon) && (copyEMAX == 1)) {
            pvGet(EMAX[0]);
            for (i=1; i<nDetectors; i++) {
                EMAX[i] = EMAX[0];
                pvPut(EMAX[i]);
            }
            copyEMAX = 0;
            pvPut(copyEMAX);
        } state monitor_changes

        when(efTestAndClear(copyADC_RULEMon) && (copyADC_RULE == 1)) {
            pvGet(ADC_RULE[0]);
            for (i=1; i<nDetectors; i++) {
                ADC_RULE[i] = ADC_RULE[0];
                pvPut(ADC_RULE[i]);
            }
            copyADC_RULE = 0;
            pvPut(copyADC_RULE);
        } state monitor_changes

        when(efTestAndClear(readDXPsMon) && (readDXPs == 1)) {
            for (i=0; i<nDetectors; i++) {
                readDXP[i] = 1;
                pvPut(readDXP[i]);
            }
            readDXPs = 0;
            pvPut(readDXPs);
        } state monitor_changes

        when(efTestAndClear(ReadMCAsMon) && (ReadMCAs == 1)) {
            for (i=0; i<nDetectors; i++) {
                readMCA[i] = 1;
                pvPut(readMCA[i]);
            }
            ReadMCAs = 0;
            pvPut(ReadMCAs);
        } state monitor_changes

        when(efTestAndClear(StatusMCAsMon) && (StatusMCAs == 1)) {
            for (i=0; i<nDetectors; i++) {
                statusMCA[i] = 1;
                pvPut(statusMCA[i]);
            }
            StatusMCAs = 0;
            pvPut(StatusMCAs);
        } state monitor_changes

        when(efTestAndClear(StartAllMon) && (StartAll == 1)) {
            /* We could just do first channel on each module for efficiency */
            for (i=0; i<nDetectors; i++) {
                mcaStart[i] = 1;
                pvPut(mcaStart[i]);
            }
            StartAll = 0;
            pvPut(StartAll);
        } state monitor_changes

        when(efTestAndClear(StopAllMon) && (StopAll == 1)) {
            /* We could just do first channel on each module for efficiency */
            for (i=0; i<nDetectors; i++) {
                mcaStop[i] = 1;
                pvPut(mcaStop[i]);
            }
            StopAll = 0;
            pvPut(StopAll);
        } state monitor_changes

        when(efTestAndClear(EraseAllMon) && (EraseAll == 1)) {
            for (i=0; i<nDetectors; i++) {
                mcaErase[i] = 1;
                pvPut(mcaErase[i]);
            }
            EraseAll = 0;
            pvPut(EraseAll);
        } state monitor_changes

        when(efTestAndClear(EraseStartMon) && (EraseStart == 1)) {
            /* We could just do first channel on each module for efficiency */
            for (i=0; i<nDetectors; i++) {
                mcaEraseStart[i] = 1;
                pvPut(mcaEraseStart[i]);
            }
            EraseStart = 0;
            pvPut(EraseStart);
        } state monitor_changes

        when(efTestAndClear(PresetRealMon)) {
            for (i=0; i<nDetectors; i++) {
                mcaPresetReal[i] = PresetReal;
                pvPut(mcaPresetReal[i]);
            }
        } state monitor_changes

        when(efTestAndClear(PresetLiveMon)) {
            for (i=0; i<nDetectors; i++) {
                mcaPresetLive[i] = PresetLive;
                pvPut(mcaPresetLive[i]);
            }
        } state monitor_changes

        when(efTestAndClear(AcquiringMon)) {
            Acquiring = 0;
            for (i=0; i<nDetectors; i++) {
                if (mcaAcquiring[i]) Acquiring = 1;
            }
            pvPut(Acquiring);
        } state monitor_changes

        when(efTestAndClear(ElapsedRealMon)) {
            ElapsedReal = 0.;
            for (i=0; i<nDetectors; i++) {
                if (mcaElapsedReal[i] > ElapsedReal) ElapsedReal = mcaElapsedReal[i];
            }
            pvPut(ElapsedReal);
        } state monitor_changes

        when(efTestAndClear(ElapsedLiveMon)) {
            ElapsedLive = 0.;
            for (i=0; i<nDetectors; i++) {
                if (mcaElapsedLive[i] > ElapsedLive) ElapsedLive = mcaElapsedLive[i];
            }
            pvPut(ElapsedLive);
        } state monitor_changes
 
        when(efTestAndClear(DeadTimeMon)) {
            DeadTime = 0.;
            for (i=0; i<nDetectors; i++) {
                if (mcaDeadTime[i] > DeadTime) DeadTime = mcaDeadTime[i];
            }
            pvPut(DeadTime);
        } state monitor_changes
 
   }
}

#include "EXTERN.h"
#include "perl.h"
#include "XSUB.h"
#include "Iphlpapi.h"



static int
not_here(char *s)
{
    croak("%s not implemented on this architecture", s);
    return -1;
}

static double
constant(char *name, int len, int arg)
{
    errno = EINVAL;
    return 0;
}

MODULE = Win32::IPStat		PACKAGE = Win32::IPStat		

SV* GetIPStat(perror)
    	SV* perror
    PREINIT:
	MIB_IPSTATS *pStats;
	DWORD status;
	HV *rh;
	AV* result;
	DWORD   dwChars;
        char   wszMsgBuff[512];
    CODE:
    	result = newAV();
    	rh = newHV();
    	result = (AV *)sv_2mortal((SV *)newAV());
        rh = (HV *)sv_2mortal((SV *)newHV());
        pStats = (MIB_IPSTATS*) malloc(sizeof(MIB_IPSTATS));
	status = GetIpStatistics(pStats);
	if(status == NO_ERROR) {
        	hv_store(rh,"Forwarding",strlen("Forwarding"),newSViv(pStats->dwForwarding), 0);
   	 	hv_store(rh,"DefaultTTL",strlen("DefaultTTL"),newSViv(pStats->dwDefaultTTL), 0);
   	 	hv_store(rh,"InReceives",strlen("InReceives"),newSViv(pStats->dwInReceives), 0);
   	 	hv_store(rh,"InHdrErrors",strlen("InHdrErrors"),newSViv(pStats->dwInHdrErrors), 0);
   	 	hv_store(rh,"InAddrErrors",strlen("InAddrErrors"),newSViv(pStats->dwInAddrErrors), 0);
   	 	hv_store(rh,"ForwDatagrams",strlen("ForwDatagrams"),newSViv(pStats->dwForwDatagrams), 0);
   	 	hv_store(rh,"InUnknownProtos",strlen("InUnknownProtos"),newSViv(pStats->dwInUnknownProtos), 0);
   	 	hv_store(rh,"InDiscards",strlen("InDiscards"),newSViv(pStats->dwInDiscards), 0);
   	 	hv_store(rh,"InDelivers",strlen("InDelivers"),newSViv(pStats->dwInDelivers), 0);
   	 	hv_store(rh,"OutRequests",strlen("OutRequests"),newSViv(pStats->dwOutRequests), 0);
   	 	hv_store(rh,"RoutingDiscards",strlen("RoutingDiscards"),newSViv(pStats->dwRoutingDiscards), 0);
   	 	hv_store(rh,"OutDiscards",strlen("OutDiscards"),newSViv(pStats->dwOutDiscards), 0);
   	 	hv_store(rh,"OutNoRoutes",strlen("OutNoRoutes"),newSViv(pStats->dwOutNoRoutes), 0);
   	 	hv_store(rh,"ReasmTimeout",strlen("ReasmTimeout"),newSViv(pStats->dwReasmTimeout), 0);
   	 	hv_store(rh,"ReasmTimeout",strlen("ReasmTimeout"),newSViv(pStats->dwReasmTimeout), 0);
   	 	hv_store(rh,"ReasmOks",strlen("ReasmOks"),newSViv(pStats->dwReasmOks), 0);
   	 	hv_store(rh,"ReasmFails",strlen("ReasmFails"),newSViv(pStats->dwReasmFails), 0);
   	 	hv_store(rh,"FragOks",strlen("FragOks"),newSViv(pStats->dwFragOks), 0);
   	 	hv_store(rh,"FragFails",strlen("FragFails"),newSViv(pStats->dwFragFails), 0);
   	 	hv_store(rh,"FragCreates",strlen("FragCreates"),newSViv(pStats->dwFragCreates), 0);
   	 	hv_store(rh,"NumIf",strlen("NumIf"),newSViv(pStats->dwNumIf), 0);
   	 	hv_store(rh,"NumAddr",strlen("NumAddr"),newSViv(pStats->dwNumAddr), 0);
   	 	hv_store(rh,"NumRoutes",strlen("NumRoutes"),newSViv(pStats->dwNumRoutes), 0);
   	 } else
   	 {
		dwChars = FormatMessage( FORMAT_MESSAGE_FROM_SYSTEM |
               				FORMAT_MESSAGE_IGNORE_INSERTS,
					NULL,
                             		status,
                             		0,
                             		(LPTSTR)wszMsgBuff,
                             		512,
                             		NULL );
   	 	sv_upgrade(perror,SVt_PVIV);
		sv_setpvn(perror, (char*)wszMsgBuff, strlen(wszMsgBuff));
		sv_setiv(perror,(IV) status);
		SvPOK_on(perror);
		XPUSHs(sv_2mortal(newSViv(-1)));
	}
	GlobalFree(pStats);
    	av_push(result, newRV((SV *)rh));
    	RETVAL = newRV((SV *)result);
   OUTPUT:
   	RETVAL




double
constant(sv,arg)
    PREINIT:
	STRLEN		len;
    INPUT:
	SV *		sv
	char *		s = SvPV(sv, len);
	int		arg
    CODE:
	RETVAL = constant(s,len,arg);
    OUTPUT:
	RETVAL


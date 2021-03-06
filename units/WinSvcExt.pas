{*******************************************************}
{                                                       }
{                Delphi Runtime Library                 }
{                                                       }
{     File: winsvc.h                                    }
{     Copyright (c) 1995-1998 Microsoft Corporation.    }
{                                                       }
{     Translator: Andrej Sinicyn                        }
{                                                       }
{     v1.0  2013-12-03  Synced with Win2k-SDK           }
{       Though EnumServicesStatusEx was available since }
{       WinNT4.0, Win9x product line didn't have this   }
{       function so this unit will compile only         }
{       with Delphi 6 (Compiler v14) or newer.          }
{     v1.0a 2013-12-03  Synced with WinXP-SDK           }
{     v1.1  xxxx-xx-xx  Synced with WinVista SDK        }
{*******************************************************}

{*******************************************************}
{       Win32 service API interface unit                }
{*******************************************************}

unit WinSvcExt;

{$ALIGN ON}
{$MINENUMSIZE 4}
{$WEAKPACKAGEUNIT}

{$IF CompilerVersion >= 14.0}
  {$DEFINE WINDOWS50_MIN} // Win2k and greater.
{$IFEND}
{$IF CompilerVersion >= 15.0}
  {$DEFINE WINDOWS51_MIN} // WinXP and greater.
{$IFEND}
{$IF CompilerVersion >= 18.5}
  {$DEFINE WINDOWS60_MIN} // WinVista and greater.
{$IFEND}

interface

{$IFDEF WINDOWS50_MIN}

uses Windows, WinSvc;

//
// Constants
//

const

//
// Controls
//
  {$EXTERNALSYM SERVICE_CONTROL_PARAMCHANGE}
  SERVICE_CONTROL_PARAMCHANGE           = $00000006;
  {$EXTERNALSYM SERVICE_CONTROL_NETBINDADD}
  SERVICE_CONTROL_NETBINDADD            = $00000007;
  {$EXTERNALSYM SERVICE_CONTROL_NETBINDREMOVE}
  SERVICE_CONTROL_NETBINDREMOVE         = $00000008;
  {$EXTERNALSYM SERVICE_CONTROL_NETBINDENABLE}
  SERVICE_CONTROL_NETBINDENABLE         = $00000009;
  {$EXTERNALSYM SERVICE_CONTROL_NETBINDDISABLE}
  SERVICE_CONTROL_NETBINDDISABLE        = $0000000A;
  {$EXTERNALSYM SERVICE_CONTROL_DEVICEEVENT}
  SERVICE_CONTROL_DEVICEEVENT           = $0000000B;
  {$EXTERNALSYM SERVICE_CONTROL_HARDWAREPROFILECHANGE}
  SERVICE_CONTROL_HARDWAREPROFILECHANGE = $0000000C;
  {$EXTERNALSYM SERVICE_CONTROL_POWEREVENT}
  SERVICE_CONTROL_POWEREVENT            = $0000000D;
{$IFDEF WINDOWS51_MIN}
  {$EXTERNALSYM SERVICE_CONTROL_SESSIONCHANGE}
  SERVICE_CONTROL_SESSIONCHANGE         = $0000000E;
{$ENDIF}
{$IFDEF WINDOWS60_MIN}
  {$EXTERNALSYM SERVICE_CONTROL_PRESHUTDOWN}
  SERVICE_CONTROL_PRESHUTDOWN           = $0000000F;
  {$EXTERNALSYM SERVICE_CONTROL_TIMECHANGE}
  SERVICE_CONTROL_TIMECHANGE            = $00000010;
  {$EXTERNALSYM SERVICE_CONTROL_TRIGGEREVENT}
  SERVICE_CONTROL_TRIGGEREVENT          = $00000020;
{$ENDIF}

//
// Controls Accepted  (Bit Mask)
//
  {$EXTERNALSYM SERVICE_ACCEPT_PARAMCHANGE}
  SERVICE_ACCEPT_PARAMCHANGE           = $00000008;
  {$EXTERNALSYM SERVICE_ACCEPT_NETBINDCHANGE}
  SERVICE_ACCEPT_NETBINDCHANGE         = $00000010;
  {$EXTERNALSYM SERVICE_ACCEPT_HARDWAREPROFILECHANGE}
  SERVICE_ACCEPT_HARDWAREPROFILECHANGE = $00000020;
  {$EXTERNALSYM SERVICE_ACCEPT_POWEREVENT}
  SERVICE_ACCEPT_POWEREVENT            = $00000040;
{$IFDEF WINDOWS51_MIN}
  {$EXTERNALSYM SERVICE_ACCEPT_SESSIONCHANGE}
  SERVICE_ACCEPT_SESSIONCHANGE         = $00000080;
{$ENDIF}
{$IFDEF WINDOWS60_MIN}
  {$EXTERNALSYM SERVICE_ACCEPT_PRESHUTDOWN}
  SERVICE_ACCEPT_PRESHUTDOWN           = $00000100;
  {$EXTERNALSYM SERVICE_ACCEPT_TIMECHANGE}
  SERVICE_ACCEPT_TIMECHANGE            = $00000200;
  {$EXTERNALSYM SERVICE_ACCEPT_TRIGGEREVENT}
  SERVICE_ACCEPT_TRIGGEREVENT          = $00000400;
{$ENDIF}

//
// Info levels for ChangeServiceConfig2 and QueryServiceConfig2
//
  {$EXTERNALSYM SERVICE_CONFIG_DESCRIPTION}
  SERVICE_CONFIG_DESCRIPTION              = 1;
  {$EXTERNALSYM SERVICE_CONFIG_FAILURE_ACTIONS}
  SERVICE_CONFIG_FAILURE_ACTIONS          = 2;
{$IFDEF WINDOWS60_MIN}
  {$EXTERNALSYM SERVICE_CONFIG_DELAYED_AUTO_START_INFO}
  SERVICE_CONFIG_DELAYED_AUTO_START_INFO  = 3;
  {$EXTERNALSYM SERVICE_CONFIG_FAILURE_ACTIONS_FLAG}
  SERVICE_CONFIG_FAILURE_ACTIONS_FLAG     = 4;
  {$EXTERNALSYM SERVICE_CONFIG_SERVICE_SID_INFO}
  SERVICE_CONFIG_SERVICE_SID_INFO         = 5;
  {$EXTERNALSYM SERVICE_CONFIG_REQUIRED_PRIVILEGES_INFO}
  SERVICE_CONFIG_REQUIRED_PRIVILEGES_INFO = 6;
  {$EXTERNALSYM SERVICE_CONFIG_PRESHUTDOWN_INFO}
  SERVICE_CONFIG_PRESHUTDOWN_INFO         = 7;
  {$EXTERNALSYM SERVICE_CONFIG_TRIGGER_INFO}
  SERVICE_CONFIG_TRIGGER_INFO             = 8;
  {$EXTERNALSYM SERVICE_CONFIG_PREFERRED_NODE}
  SERVICE_CONFIG_PREFERRED_NODE           = 9;
{$ENDIF}

{$IFDEF WINDOWS60_MIN}
//
// Info levels for NotifyServiceStatusChange
//
  {$EXTERNALSYM SERVICE_NOTIFY_STATUS_CHANGE_1}
  SERVICE_NOTIFY_STATUS_CHANGE_1 = 1;
  {$EXTERNALSYM SERVICE_NOTIFY_STATUS_CHANGE_2}
  SERVICE_NOTIFY_STATUS_CHANGE_2 = 2;

  {$EXTERNALSYM SERVICE_NOTIFY_STATUS_CHANGE}
  SERVICE_NOTIFY_STATUS_CHANGE = SERVICE_NOTIFY_STATUS_CHANGE_2;

//
// Service notification masks
//
  {$EXTERNALSYM SERVICE_NOTIFY_STOPPED}
  SERVICE_NOTIFY_STOPPED          = $00000001;
  {$EXTERNALSYM SERVICE_NOTIFY_START_PENDING}
  SERVICE_NOTIFY_START_PENDING    = $00000002;
  {$EXTERNALSYM SERVICE_NOTIFY_STOP_PENDING}
  SERVICE_NOTIFY_STOP_PENDING     = $00000004;
  {$EXTERNALSYM SERVICE_NOTIFY_RUNNING}
  SERVICE_NOTIFY_RUNNING          = $00000008;
  {$EXTERNALSYM SERVICE_NOTIFY_CONTINUE_PENDING}
  SERVICE_NOTIFY_CONTINUE_PENDING = $00000010;
  {$EXTERNALSYM SERVICE_NOTIFY_PAUSE_PENDING}
  SERVICE_NOTIFY_PAUSE_PENDING    = $00000020;
  {$EXTERNALSYM SERVICE_NOTIFY_PAUSED}
  SERVICE_NOTIFY_PAUSED           = $00000040;
  {$EXTERNALSYM SERVICE_NOTIFY_CREATED}
  SERVICE_NOTIFY_CREATED          = $00000080;
  {$EXTERNALSYM SERVICE_NOTIFY_DELETED}
  SERVICE_NOTIFY_DELETED          = $00000100;
  {$EXTERNALSYM SERVICE_NOTIFY_DELETE_PENDING}
  SERVICE_NOTIFY_DELETE_PENDING   = $00000200;



  {$EXTERNALSYM SERVICE_TRIGGER_STARTED_ARGUMENT}
  SERVICE_TRIGGER_STARTED_ARGUMENT: array[0..14] of WideChar = 'TriggerStarted';
{$ENDIF}

type

//
// Service description string
//
  PServiceDescriptionA = ^TServiceDescriptionA;
  PServiceDescriptionW = ^TServiceDescriptionW;
  PServiceDescription = PServiceDescriptionW;
  {$EXTERNALSYM _SERVICE_DESCRIPTIONA}
  _SERVICE_DESCRIPTIONA = record
    lpDescription: PAnsiChar;
  end;
{#BEGIN}
  {$EXTERNALSYM SERVICE_DESCRIPTIONA}
  SERVICE_DESCRIPTIONA = _SERVICE_DESCRIPTIONA;
  {$EXTERNALSYM _SERVICE_DESCRIPTIONW}
  _SERVICE_DESCRIPTIONW = record
    lpDescription: PWideChar;
  end;
{#BEGIN}
  {$EXTERNALSYM SERVICE_DESCRIPTIONW}
  SERVICE_DESCRIPTIONW = _SERVICE_DESCRIPTIONW;
  {$EXTERNALSYM _SERVICE_DESCRIPTION}
  _SERVICE_DESCRIPTION = _SERVICE_DESCRIPTIONW;
  TServiceDescriptionA = _SERVICE_DESCRIPTIONA;
  TServiceDescriptionW = _SERVICE_DESCRIPTIONW;
  TServiceDescription = TServiceDescriptionW;

//
// Actions to take on service failure
//
  {$EXTERNALSYM SC_ACTION_TYPE}
  SC_ACTION_TYPE= (
    SC_ACTION_NONE          = 0,
    SC_ACTION_RESTART       = 1,
    SC_ACTION_REBOOT        = 2,
    SC_ACTION_RUN_COMMAND   = 3
  );

  PScAction = ^TScAction;
  {$EXTERNALSYM _SC_ACTION}
  _SC_ACTION = record
    &Type: SC_ACTION_TYPE;
    Delay: DWORD;
  end;
  {$EXTERNALSYM SC_ACTION}
  SC_ACTION = _SC_ACTION;
  TScAction = _SC_ACTION;

  PServiceFailureActionsA = ^TServiceFailureActionsA;
  PServiceFailureActionsW = ^TServiceFailureActionsW;
  PServiceFailureActions = PServiceFailureActionsW;
  {$EXTERNALSYM _SERVICE_FAILURE_ACTIONSA}
  _SERVICE_FAILURE_ACTIONSA = record
    dwResetPeriod: DWORD;
    lpRebootMsg: PAnsiChar;
    lpCommand: PAnsiChar;
    cActions: DWORD;
    lpsaActions: PScAction;
  end;
{#BEGIN}
  {$EXTERNALSYM SERVICE_FAILURE_ACTIONSA}
  SERVICE_FAILURE_ACTIONSA = _SERVICE_FAILURE_ACTIONSA;
  {$EXTERNALSYM _SERVICE_FAILURE_ACTIONSW}
  _SERVICE_FAILURE_ACTIONSW = record
    dwResetPeriod: DWORD;
    lpRebootMsg: PWideChar;
    lpCommand: PWideChar;
    cActions: DWORD;
    lpsaActions: PScAction;
  end;
{#BEGIN}
  {$EXTERNALSYM SERVICE_FAILURE_ACTIONSW}
  SERVICE_FAILURE_ACTIONSW = _SERVICE_FAILURE_ACTIONSW;
  {$EXTERNALSYM _SERVICE_FAILURE_ACTIONS}
  _SERVICE_FAILURE_ACTIONS = _SERVICE_FAILURE_ACTIONSW;
  TServiceFailureActionsA = _SERVICE_FAILURE_ACTIONSA;
  TServiceFailureActionsW = _SERVICE_FAILURE_ACTIONSW;
  TServiceFailureActions = TServiceFailureActionsW;

//
// Info levels for EnumServicesStatusEx
//
  {$EXTERNALSYM SC_ENUM_TYPE}
  SC_ENUM_TYPE = (
    SC_ENUM_PROCESS_INFO = 0
  );

//
// Service Status Structure
//
  PServiceStatusProcess = ^TServiceStatusProcess;
  {$EXTERNALSYM _SERVICE_STATUS_PROCESS}
  _SERVICE_STATUS_PROCESS = record
    dwServiceType: DWORD;
    dwCurrentState: DWORD;
    dwControlsAccepted: DWORD;
    dwWin32ExitCode: DWORD;
    dwServiceSpecificExitCode: DWORD;
    dwCheckPoint: DWORD;
    dwWaitHint: DWORD;
    dwProcessId: DWORD;
    dwServiceFlags: DWORD;
  end;
  {$EXTERNALSYM SERVICE_STATUS_PROCESS}
  SERVICE_STATUS_PROCESS = _SERVICE_STATUS_PROCESS;
  TServiceStatusProcess = _SERVICE_STATUS_PROCESS;

//
// Prototype for the Service Control Handler Function
//
  {$EXTERNALSYM LPHANDLER_FUNCTION_EX}
  LPHANDLER_FUNCTION_EX = TFarProc;

  THandlerFunctionEx = LPHANDLER_FUNCTION_EX;


///////////////////////////////////////////////////////////////////////////
// API Function Prototypes
///////////////////////////////////////////////////////////////////////////

{$EXTERNALSYM ChangeServiceConfig2}
function ChangeServiceConfig2(hService: SC_HANDLE; dwInfoLevel: DWORD;
  lpInfo: Pointer): BOOL; stdcall;
{$EXTERNALSYM ChangeServiceConfig2A}
function ChangeServiceConfig2A(hService: SC_HANDLE; dwInfoLevel: DWORD;
  lpInfo: Pointer): BOOL; stdcall;
{$EXTERNALSYM ChangeServiceConfig2W}
function ChangeServiceConfig2W(hService: SC_HANDLE; dwInfoLevel: DWORD;
  lpInfo: Pointer): BOOL; stdcall;
{$IFDEF WINDOWS60_MIN}
{$EXTERNALSYM ControlServiceEx}
function ControlServiceEx(hService: SC_HANDLE; dwControl, dwInfoLevel: DWORD;
  var lpServiceStatus: TServiceStatus): BOOL; stdcall;
{$EXTERNALSYM ControlServiceExA}
function ControlServiceExA(hService: SC_HANDLE; dwControl, dwInfoLevel: DWORD;
  var lpServiceStatus: TServiceStatus): BOOL; stdcall;
{$EXTERNALSYM ControlServiceExW}
function ControlServiceExW(hService: SC_HANDLE; dwControl, dwInfoLevel: DWORD;
  var lpServiceStatus: TServiceStatus): BOOL; stdcall;
{$ENDIF}
{$EXTERNALSYM EnumServicesStatusEx}
function EnumServicesStatusEx(hSCManager: SC_HANDLE; InfoLevel: SC_ENUM_TYPE;
  dwServiceType, dwServiceState: DWORD; var lpServices: TEnumServiceStatus;
  cbBufSize: DWORD; var pcbBytesNeeded, lpServicesReturned,
  lpResumeHandle: DWORD; pszGroupName: PWideChar): BOOL; stdcall;
{$EXTERNALSYM EnumServicesStatusExA}
function EnumServicesStatusExA(hSCManager: SC_HANDLE; InfoLevel: SC_ENUM_TYPE;
  dwServiceType, dwServiceState: DWORD; var lpServices: TEnumServiceStatus;
  cbBufSize: DWORD; var pcbBytesNeeded, lpServicesReturned,
  lpResumeHandle: DWORD; pszGroupName: PAnsiChar): BOOL; stdcall;
{$EXTERNALSYM EnumServicesStatusExW}
function EnumServicesStatusExW(hSCManager: SC_HANDLE; InfoLevel: SC_ENUM_TYPE;
  dwServiceType, dwServiceState: DWORD; var lpServices: TEnumServiceStatus;
  cbBufSize: DWORD; var pcbBytesNeeded, lpServicesReturned,
  lpResumeHandle: DWORD; pszGroupName: PWideChar): BOOL; stdcall;
{$EXTERNALSYM QueryServiceConfig2}
function QueryServiceConfig2(hService: SC_HANDLE; dwInfoLevel: DWORD;
  lpBuffer: PByte; cbBufSize: DWORD; var pcbBytesNeeded: DWORD): BOOL; stdcall;
{$EXTERNALSYM QueryServiceConfig2A}
function QueryServiceConfig2A(hService: SC_HANDLE; dwInfoLevel: DWORD;
  lpBuffer: PByte; cbBufSize: DWORD; var pcbBytesNeeded: DWORD): BOOL; stdcall;
{$EXTERNALSYM QueryServiceConfig2W}
function QueryServiceConfig2W(hService: SC_HANDLE; dwInfoLevel: DWORD;
  lpBuffer: PByte; cbBufSize: DWORD; var pcbBytesNeeded: DWORD): BOOL; stdcall;
{$EXTERNALSYM RegisterServiceCtrlHandlerEx}
function RegisterServiceCtrlHandlerEx(lpServiceName: PWideChar;
  lpHandlerProc: THandlerFunctionEx): SERVICE_STATUS_HANDLE; stdcall;
{$EXTERNALSYM RegisterServiceCtrlHandlerExA}
function RegisterServiceCtrlHandlerExA(lpServiceName: PAnsiChar;
  lpHandlerProc: THandlerFunctionEx): SERVICE_STATUS_HANDLE; stdcall;
{$EXTERNALSYM RegisterServiceCtrlHandlerExW}
function RegisterServiceCtrlHandlerExW(lpServiceName: PWideChar;
  lpHandlerProc: THandlerFunctionEx): SERVICE_STATUS_HANDLE; stdcall;

{$ENDIF}

implementation

{$IFDEF WINDOWS50_MIN}

const
  advapi32 = 'advapi32.dll';

function ChangeServiceConfig2;          external advapi32 name 'ChangeServiceConfig2W';
function ChangeServiceConfig2A;         external advapi32 name 'ChangeServiceConfig2A';
function ChangeServiceConfig2W;         external advapi32 name 'ChangeServiceConfig2W';
{$IFDEF WINDOWS60_MIN}
function ControlServiceEx;              external advapi32 name 'ControlServiceExW';
function ControlServiceExA;             external advapi32 name 'ControlServiceExA';
function ControlServiceExW;             external advapi32 name 'ControlServiceExW';
{$ENDIF}
function EnumServicesStatusEx;          external advapi32 name 'EnumServicesStatusExW';
function EnumServicesStatusExA;         external advapi32 name 'EnumServicesStatusExA';
function EnumServicesStatusExW;         external advapi32 name 'EnumServicesStatusExW';
function QueryServiceConfig2;           external advapi32 name 'QueryServiceConfig2W';
function QueryServiceConfig2A;          external advapi32 name 'QueryServiceConfig2A';
function QueryServiceConfig2W;          external advapi32 name 'QueryServiceConfig2W';
function RegisterServiceCtrlHandlerEx;  external advapi32 name 'RegisterServiceCtrlHandlerExW';
function RegisterServiceCtrlHandlerExA; external advapi32 name 'RegisterServiceCtrlHandlerExA';
function RegisterServiceCtrlHandlerExW; external advapi32 name 'RegisterServiceCtrlHandlerExW';

{$ENDIF}

end.
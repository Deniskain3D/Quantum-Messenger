section '.text' code readable executable
;--
start:
    invoke GetModuleHandle,0
    mov [hInstance],eax        
    invoke GetCurrentThread
    mov [hMainThread], eax
    invoke SetThreadAffinityMask, eax, 2 
invoke InitializeCriticalSection, addr csCritical
stdcall GetIniFilePath
stdcall loadset
invoke EnterCriticalSection, addr csCritical
pusha
 mov esi,  default_license
 mov edi,  license_buffer
 mov ecx, 19
 cld
 rep cmpsb
 jne @f
 jmp .pass
 @@:
 popa
invoke LeaveCriticalSection, addr csCritical
 stdcall [MessageBox],0, "  License key wrong Please Register",ini_file_path,MB_OK
 invoke ExitProcess,0
.pass:
 popa
invoke LeaveCriticalSection, addr csCritical
;--
	invoke DialogBoxParam,[hInstance],38,HWND_DESKTOP,DialogProc,0 
    invoke ExitProcess,0 
;--
proc DialogProc hwnddlg, msg, wparam, lparam  
    cmp [msg], WM_INITDIALOG
    je .wminitdialog
	cmp [msg], WM_DROPFILES
    je .wm_dropfiles
    cmp [msg], WM_COMMAND
    je .wmcommand
     cmp [msg], WM_DRAWITEM
    je .wmdrawitem
    cmp [msg], WM_MEASUREITEM
    je .wmmeasureitem
        cmp [msg], WM_MOVE
    je .wmmove
    cmp [msg], WM_CLOSE
    je DialogProc.wmclose
    cmp [msg], WM_APP_UPDATE
    je .wmappupdate
    cmp byte[kalive], 1      
    je .wmdo_task
    cmp byte[syncro], 2      
    je  DialogProc.wmdo_task
    xor eax, eax
    jmp DialogProc.finish
;--
DialogProc.wm_dropfiles:
    mov ebx,[wparam]
    invoke DragQueryFile,ebx,-1,0,0
    test eax,eax
    jz DialogProc.drop_done
    invoke DragQueryFile,ebx,0,szFileName,260
    test eax,eax
    jz DialogProc.drop_done
    cinvoke wsprintf,mess,szDropMessage, szFileName
	invoke SendMessage,[hTEdit],EM_REPLACESEL,0,mess
;--
DialogProc.drop_done:
    invoke DragFinish,ebx
    mov eax,0
jmp choosef.ole_case
    jmp DialogProc.processed
;--
DialogProc.wmmove:
    stdcall GetWindowPosition
    jmp DialogProc.processed
;--
DialogProc.wmmeasureitem:
mov esi, [lparam]  
    mov dword [esi + MEASUREITEMSTRUCT.itemHeight], 20
jmp DialogProc.processed
;--
DialogProc.wmdrawitem:
    mov esi,[lparam]   
    mov eax,[esi+DRAWITEMSTRUCT.CtlID] 
    cmp eax,ID_LISTBOX
    jne .defaultdraw
    mov ebx,[esi+DRAWITEMSTRUCT.itemID] 
    cmp ebx,0FFFFFFFFh
    je .defaultdraw
    cmp ebx,[itemCount]
    jae .defaultdraw
invoke WaitForSingleObject, [hMutexXC], 0  
    cmp eax, WAIT_OBJECT_0 
    jne .defaultdraw  
.if[dizzy]=0                          
jmp .skip_update
.endif                                
mov [dizzy],0                           
        mov ebx, [esi+8]  
        mov edx,0
		imul ebx,sizeof.LIST_ITEM
    lea edi,[listItems+ebx]
    mov eax,[edi+LIST_ITEM.color] 
    invoke SetTextColor,dword[esi+DRAWITEMSTRUCT.hDC],eax 
    invoke SetBkColor,dword[esi+DRAWITEMSTRUCT.hDC],00FFFFFFh 
    invoke SetBkMode,dword[esi+DRAWITEMSTRUCT.hDC],OPAQUE 
    lea edx,[esi+DRAWITEMSTRUCT.rcItem] 
    invoke FillRect,dword[esi+DRAWITEMSTRUCT.hDC],edx,00FFFFFFh   
    mov eax,[esi+DRAWITEMSTRUCT.itemState] 
    test eax,ODS_SELECTED
    jz .drawingt
    invoke SetTextColor,dword[esi+DRAWITEMSTRUCT.hDC],00FFFFFFh 
    invoke SetBkColor,dword[esi+DRAWITEMSTRUCT.hDC],00C04000h 
    lea edx,[esi+DRAWITEMSTRUCT.rcItem] 
.fill_background:  
    lea eax, [esi+DRAWITEMSTRUCT.rcItem]
    invoke ExtTextOut,dword[esi+DRAWITEMSTRUCT.hDC], edx,00C04000h, ETO_OPAQUE, eax, 0, 0, 0
.drawingt:  
    mov eax,[edi] 
    test eax,eax  
    jz .drawcomp
    lea edx,[esi+DRAWITEMSTRUCT.rcItem] 
    invoke DrawText,dword[esi+DRAWITEMSTRUCT.hDC],dword[edi],-1,edx,DT_LEFT or DT_VCENTER or DT_SINGLELINE
    mov eax,[esi+DRAWITEMSTRUCT.itemState] 
    test eax,ODS_SELECTED
    jz .drawcomp
lea edx,[esi+DRAWITEMSTRUCT.rcItem] 
invoke DrawFocusRect,dword[esi+DRAWITEMSTRUCT.hDC],edx
.drawcomp:
mov [dizzy],1
    jmp DialogProc.processed
.skip_update:
.defaultdraw:
    xor eax,eax
    jmp DialogProc.finish
DialogProc.wminitdialog:
.if [firstchk]='1'
call EULA
cmp eax, ID_CANCEL
je DialogProc.wmclose
mov [firstchk], '0'
.endif
invoke SetWindowPos,[hwnddlg],0,[windowX],[windowY],0,0,SWP_NOSIZE or SWP_NOZORDER
        invoke CreateMutex, 0, FALSE, 0
    mov [hMutexX], eax
        invoke CreateMutex, 0, FALSE, 0
    mov [hMutexXA], eax
        invoke CreateMutex, 0, FALSE, 0
    mov [hMutexXB], eax
        invoke CreateMutex, 0, FALSE, 0
    mov [hMutexXC], eax
        invoke CreateMutex, 0, FALSE, 0
    mov [hMutexXD], eax
        invoke CreateMutex, 0, FALSE, 0
    mov [hMutexXE], eax
        invoke CreateMutex, 0, FALSE, 0
    mov [hMutexXF], eax
        invoke CreateMutex, 0, FALSE, 0
    mov [hMutexXG], eax

 
        invoke GetDlgItem,[hwnddlg],ID_PROGRESS
        mov [hProgress],eax
		
    mov eax, [hwnddlg]
    mov [hDialog], eax
	mov [hwnd], eax

    invoke GetDlgItem, [hwnddlg], ID_LISTBOX 
    mov [hListBox], eax

   
    invoke GetDlgItem,[hwnddlg],ID_MESSAGE
    mov [hTEdit],eax
    
    
    invoke DragAcceptFiles,[hwnddlg],TRUE
 invoke WaitForSingleObject, [hMutexX], 10	
   mov byte[syncro],  3 
   mov byte[srvmode], 1
   mov byte[srvmsg],  1 
   mov [startKeep],   1
invoke ReleaseMutex, hMutexX
        
    

    
    
invoke WaitForSingleObject, [hMutexXC], 10
    invoke CheckDlgButton, [hwnddlg], ID_CHECKBOX, BST_UNCHECKED
    invoke SendDlgItemMessage, [hwnddlg], ID_PORT, EM_LIMITTEXT, 5, 0
    invoke SendDlgItemMessage, [hwnddlg], ID_IPSET, EM_LIMITTEXT, 15, 0
    invoke SetDlgItemInt, [hwnddlg], ID_PORT, [portstart_value], FALSE
invoke GetDlgItemText, [hwnddlg], ID_PORT, portstart_buffer, 5 
        stdcall strippWRK, portstart_buffer
    invoke SetDlgItemText, [hwnddlg], ID_IPSET, ip_start 
    invoke SetDlgItemText, [hwnddlg], ID_USER, my_nick_buffer
    invoke SetDlgItemText, [hwnddlg], ID_USERTO, target_nick_buffer
        invoke GetDlgItemText, [hwnddlg], ID_USER, Name1_SAVE, 32
        invoke GetDlgItemText, [hwnddlg], ID_USERTO, Name2_SAVE, 32

        invoke SendMessage,[hProgress],PBM_SETRANGE,0,65535 shl 16
        invoke SendMessage,[hProgress],PBM_SETPOS,[Progress],0
invoke ReleaseMutex, hMutexXC


        
        
    invoke GetDlgItemText, [hwnddlg], ID_IPSET, stringAddr, 16
    
    

    invoke CreateThread, 0, 0, timer_thread, [hwnddlg], 0, timer_thread_id
        mov [hTimerThread], eax         
        invoke Sleep, 100
invoke SetThreadAffinityMask, [hTimerThread], 1

        invoke CreateDialogParam, [hInstance], 38, 0, DebugDialogProc, 0
    mov [hDebugWnd], eax
    invoke CreateThread, 0, 0, DebugDialogProc, [hDebugWnd], 0, thread2_id
    mov [hDbgWndT], eax          
        invoke Sleep, 100
invoke SetThreadAffinityMask, [hDbgWndT], 1
    invoke ShowWindow, [hDebugWnd], SW_SHOW
	
    invoke CreateThread, 0, 0, init_network, [hwnddlg], 0, thread_id
    mov [hInitThread], eax          
        invoke Sleep, 100
invoke SetThreadAffinityMask, [hInitThread], 1

    invoke CreateThread, 0, 0, MainLoop, [hwnddlg], 0, thread3_id
        mov [FileThread], eax         
        invoke Sleep, 100
invoke SetThreadAffinityMask, [FileThread], 8

    invoke CreateThread, 0, 0, RefreshPB, [hProgress], 0, Refresh_thread_id
        mov [hRefreshThread], eax         
        invoke Sleep, 100
invoke SetThreadAffinityMask, [hRefreshThread], 1

mov eax,1
    jmp DialogProc.processed


DialogProc.wmappupdate:

    jmp DialogProc.processed
;--
DialogProc.wmcommand:
    cmp [wparam], BN_CLICKED shl 16 + IDOK
        jne @f
invoke WaitForSingleObject, [hMutexX], 10
           
        mov byte[srvmsg], 1 
        mov byte[syncro], 0                      
        mov byte[kalive], 0                      
          
invoke ReleaseMutex, hMutexX 
 jmp DialogProc.button
 
        @@:
   cmp [wparam], BN_CLICKED shl 16 + ID_FILE
   jne @f
        jmp choosef
DialogProc.continueL:		
        cinvoke wsprintf, mess, filesend, szFileName
        stdcall AddDebugMessage, mess
invoke WaitForSingleObject, [hMutexX], 10
        
                mov byte[srvmsg], 0 
                mov    [srvmode], 0
               
                mov byte[kalive], 1 
               
invoke ReleaseMutex, hMutexX
DialogProc.continueEr:
        @@:
    cmp  [wparam],BN_CLICKED shl 16 + ID_ABOUT
    jne @f
invoke WaitForSingleObject, [hMutexXB], 10
        stdcall AddTextToListBox, [hwnddlg], testText, 00C04000h 
invoke ReleaseMutex, hMutexXB
        stdcall AddDebugMessage, testText
                jmp DialogProc.about
    @@:
        cmp [wparam], BN_CLICKED shl 16 + ID_SN         
        jne @f
        invoke WaitForSingleObject, [hMutexX], 20
		mov byte[srvmsg], 1  
        mov [srvmode],    1
        mov byte[syncro], 1  
        mov byte[kalive], 0
        mov [startKeep],  0  

        mov [Restart], 1   
invoke ReleaseMutex, hMutexX
        jmp DialogProc.override    
        @@:

    mov eax, [wparam]
    cmp ax, ID_CHECKBOX
    jne @f
    
    shr eax, 16
    cmp ax, BN_CLICKED
    jne @f
    
    invoke IsDlgButtonChecked, [hwnddlg], ID_CHECKBOX
    cmp eax, BST_CHECKED
    jne .uncheck
    
    invoke SetWindowPos, [hwnddlg], HWND_TOPMOST, 0,0,0,0, SWP_NOMOVE+SWP_NOSIZE
    jmp @f
.uncheck:
    
    invoke SetWindowPos, [hwnddlg], HWND_NOTOPMOST, 0,0,0,0, SWP_NOMOVE+SWP_NOSIZE
@@:

    jmp DialogProc.processed
;--
DialogProc.wmdo_task: 


    cmp byte[syncro], 2           
       je @f
    cmp byte[syncro], 0 
       je DialogProc.send_message
    cmp byte[syncro], 3             
       je DialogProc.send_message
   jmp DialogProc.processed
@@:
invoke WaitForSingleObject, [hMutexX], 10
mov byte[kalive], 0
invoke ReleaseMutex, hMutexX
jmp DialogProc.send_message
   jmp DialogProc.processed
        
DialogProc.about:

stdcall About_ShowDialog, [hInstance]
    jmp DialogProc.processed           

DialogProc.button: 
@@:                         
cmp [comp], 0
jne @f    
invoke Sleep, 0.1
jmp @b    
@@:

.if [srvmode]=0 
                
DialogProc.override: 

invoke WaitForSingleObject, [hMutexXA], 10
mov [comp],0 
invoke ReleaseMutex, hMutexXA


 mov ecx, sizeof.all_nick_buffer
 mov edi, my_nick_buffer
 mov eax, 0
 rep stosb                    

invoke WaitForSingleObject, [hMutexXC], 5
    invoke GetDlgItemText, [hwnddlg], ID_USER, my_nick_buffer, 32
    stdcall strippWRK, my_nick_buffer
invoke ReleaseMutex, hMutexXC
invoke WaitForSingleObject, [hMutexXC], 5
    invoke GetDlgItemText, [hwnddlg], ID_USERTO, target_nick_buffer, 32
    stdcall strippWRK, target_nick_buffer

invoke ReleaseMutex, hMutexXC
invoke WaitForSingleObject, [hMutexXA], 10
mov [comp],1 
invoke ReleaseMutex, hMutexXA
.endif
;--
DialogProc.send_message:

@@:                         
cmp [comp], 0
jne @f    
invoke Sleep, 0.1
jmp @b    
@@:
invoke WaitForSingleObject, [hMutexXA], 10
mov [comp],0 
invoke ReleaseMutex, hMutexXA
    
    cmp [hSocket], INVALID_SOCKET
    jne @f
    cinvoke wsprintf, mess, buzzy
invoke WaitForSingleObject, [hMutexXB], 10
    stdcall AddTextToListBox, [hwnddlg], mess, MSG_TYPE_ERROR
invoke ReleaseMutex, hMutexXB

jmp .endsend
@@:

cmp byte[kalive],1 
je @f
.if byte[syncro]=2
invoke WaitForSingleObject, [hMutexX], 10 
mov byte[kalive],0  
invoke ReleaseMutex, hMutexX
.endif
invoke WaitForSingleObject, [hMutexXC], 10
        invoke GetDlgItemText, [hwnddlg], ID_USER, Name1_SAVE, 32
        invoke GetDlgItemText, [hwnddlg], ID_USERTO, Name2_SAVE, 32
        invoke GetDlgItemText, [hwnddlg], ID_IPSET, ip_start, 15
        invoke GetDlgItemText, [hwnddlg], ID_PORT, portstart_buffer, 5
        stdcall strippWRK, portstart_buffer
invoke ReleaseMutex, hMutexXC

invoke WaitForSingleObject, [hMutexXC], 5
invoke GetDlgItemText, [hwnddlg], ID_IPSET, stringAddr, 16
 stdcall strippWRK, stringAddr
invoke ReleaseMutex, hMutexXC
    invoke GetDlgItemInt, [hwnddlg], ID_PORT, 0, FALSE 

mov [portNumber],eax 
@@:

.if byte[kalive]<>1 
    invoke WaitForSingleObject, [hMutexXC], 5
        invoke GetDlgItemText, [hwnddlg], ID_MESSAGE, userInput, 1024
    stdcall stripping, userInput
    invoke ReleaseMutex, hMutexXC
.endif  
.if byte [kalive]=0
    .if byte[syncro]<>2 
        mov [clientAddr.sin_family], AF_INET
    
;--
        mov eax, [portNumber]
        xchg al, ah
        .if ax=0
            mov ax, word[portstart_value] 
            xchg al, ah
        .endif
;--
        mov [clientAddr.sin_port], ax
        
invoke WaitForSingleObject, [hMutexXC], 5
    invoke GetDlgItemText, [hwnddlg], ID_IPSET, stringAddr, 16
     stdcall strippWRK, stringAddr 
    invoke ReleaseMutex, hMutexXC
;--
    invoke inet_addr, stringAddr
;--
        mov [clientAddr.sin_addr], eax
        mov dword [clientAddr.sin_zero], 0
        mov dword [clientAddr.sin_zero+4], 0
    
    .endif
.syncmode:
.if byte[syncro]=1      
stdcall SyncmoD, [hwnddlg]
.endif
.if byte[syncro]=2
    cinvoke wsprintf, userInput, png_msg, stringAddr, strPort 
    mov [savereg3], eax
    mov [height], eax
    
    @@:
.endif
.if byte[syncro]=0
mov edx,0
mov esi, userInput
mov edi, userOutput  
;--
 @@:
   lodsb
   cmp al,0
   je  @f
   inc edx
   sub al, 30
   stosb
   jmp @b
 @@:
mov [height], edx
.endif
    .if byte[syncro]=0  
    .if byte[srvmsg]=1  
;--
      invoke MultiByteToWideChar, CP_ACP, 0, userOutput, -1, tmplocal, 1024
;--
      invoke WideCharToMultiByte, CP_UTF8, 0, tmplocal, -1, userOutput, 2048, 0, 0
;--
      cinvoke wsprintf, userInput, str_msg, userOutput 
      mov edx, eax
      mov [height], edx
    .endif
    .endif
.endif
.if byte[kalive]=1         
stdcall SyncmoD, [hwnddlg] 
.endif 
.if byte[syncro]<>2 
        mov edx,[height]
        .if byte[kalive]=1
          mov edx,[heightk]
        .endif
                    .if byte[srvmsg]<>1 
                      jmp .woutf        
                    .endif           
;--
                           invoke sendto, [hSocket], userInput, edx, 0, clientAddr, SOCKADDR_SIZE
                           invoke Sleep, 15
                           invoke WaitForSingleObject, [hMutexXF], 1
                           mov [init_s2], 1
                           invoke ReleaseMutex, hMutexXF
                           invoke Sleep, 15
                            jmp .sk
 

    .woutf:
    .if dword[userInput]<>'74jh'
        cinvoke wsprintf, tmplocal, str_msg, userOutput 

        
;--
        invoke sendto, [hSocket], tmplocal, eax, 0, clientAddr, SOCKADDR_SIZE 
        
        jmp .sk
    .endif

    
;--
    invoke sendto, [hSocket], userInput, eax, 0, clientAddr, SOCKADDR_SIZE 
    
	 invoke Sleep, 15
                           invoke WaitForSingleObject, [hMutexXF], 1
;--
                           mov [init_s2], 1
                           invoke ReleaseMutex, hMutexXF
                           invoke Sleep, 15
    .sk:
.endif
.if byte[syncro]=2 
mov [srvmode], 0   
mov byte[kalive],0 
    cinvoke wsprintf, mess, chg_format, userInput, stringAddr, strPort
    
        stdcall AddDebugMessage, mess
    mov ecx,6
    mov edx, [savereg3]
    .punch:
    
    mov [savereg2], ecx
;--
				invoke sendto, [hSocket], userInput, edx, 0, clientAddr, SOCKADDR_SIZE
                invoke Sleep, 15
                           invoke WaitForSingleObject, [hMutexXF], 1
;--
                            mov [init_s2], 1
                           invoke ReleaseMutex, hMutexXF
                invoke Sleep, 15
    mov ecx, [savereg2]
    dec ecx
        cmp ecx, 0
        jne .punch
 invoke WaitForSingleObject, [hMutexX], 10
           mov [startKeep], 1  
           mov [srvmode], 0  
 invoke ReleaseMutex, hMutexX
           
    jmp .skipping
.endif
.checkerr:
    cmp eax, SOCKET_ERROR
    .if eax<>SOCKET_ERROR
    jmp .success
        .endif
    invoke WSAGetLastError
    cinvoke wsprintf, mess, errMsg, eax
invoke WaitForSingleObject, [hMutexXB], 10
    stdcall AddTextToListBox, [hwnddlg], mess, MSG_TYPE_ERROR
invoke ReleaseMutex, hMutexXB
    jmp .endsend
.success:
cmp byte[syncro],3         
je .skipping               
cmp byte[kalive],1         
je .skipping            
    invoke GetDlgItemInt, [hwnddlg], ID_PORT, 0, FALSE 
            mov [portNumber], eax
.if byte[syncro]=1
        cinvoke wsprintf, mess, msg_format, userInput, stringAddr, [portNumber] 
        jmp @f  
.endif
invoke WaitForSingleObject, [hMutexXC], 5
        invoke GetDlgItemText, [hwnddlg], ID_MESSAGE, userInput, 1024   
                stdcall stripping, userInput
invoke ReleaseMutex, hMutexXC
stdcall GetTD 
movzx eax, word[sysTime.wMinute]
movzx edx, word[sysTime.wHour]     
		cinvoke wsprintf, mess, msg_simple, edx, eax, userInput 		
        invoke SetDlgItemText, [hwnddlg], ID_MESSAGE, 0, 1024 
@@:
invoke WaitForSingleObject, [hMutexXB], 10
       stdcall AddTextToListBox, [hwnddlg], mess, MSG_TYPE_NORMAL   
invoke ReleaseMutex, hMutexXB
.skipping:
.endsend:
stdcall clrInput     
 .if dword[srvmode]=0
invoke WaitForSingleObject, [hMutexX], 10 
   mov byte[syncro], 3   
   mov byte[srvmsg], 1   
   mov byte[kalive], 0    
invoke ReleaseMutex, hMutexX
   jmp @f
 .endif
invoke WaitForSingleObject, [hMutexX], 10  
mov byte[syncro], 3  
mov byte[srvmsg], 1  
mov byte[kalive], 0   
invoke ReleaseMutex, hMutexX
@@:
invoke WaitForSingleObject, [hMutexXA], 10
mov [comp],1 
invoke ReleaseMutex, hMutexXA
        jmp DialogProc.processed
DialogProc.wmclose:
wmclose:
stdcall saveset
    mov [exitFlag2], 1
    invoke closesocket, [hSocket2]
    cmp [LPTR_storeF], 0
    jz @f
	invoke Free,[hHeap],0,[LPTR_storeF]
invoke Sleep, 100
    mov [LPTR_storeF], 0
@@:
    cmp [LPTR_lfile], 0
    jz @f
    invoke LocalFree, [LPTR_lfile]
invoke Sleep, 100
    mov [LPTR_lfile], 0
@@:
    invoke DeleteCriticalSection, addr csCritical
    invoke WaitForSingleObject, [hThread2], 200
    invoke CloseHandle, [hThread2]
    mov [exitFlag], 1
    cmp [hSocket], INVALID_SOCKET
    je @f
    invoke closesocket, [hSocket]
@@:
    invoke WaitForSingleObject, [hThread], 200
    invoke CloseHandle, [hThread]
    invoke CloseHandle, [FileThread]
    invoke CloseHandle, [hInitThread]
    invoke CloseHandle, [hTimerThread]
	invoke CloseHandle, [hRefreshThread]
    invoke CloseHandle, [hDbgWndT]
    invoke CloseHandle, [hMutexX]
        invoke CloseHandle, [hMutexXA]
        invoke CloseHandle, [hMutexXB]
        invoke CloseHandle, [hMutexXC]
                invoke CloseHandle, [hMutexXD]
                invoke CloseHandle, [hMutexXE]
				invoke CloseHandle, [hMutexXF]

	invoke WSACleanup
    invoke EndDialog, [hwnddlg], 0
    invoke CloseHandle, [hMainThread]
DialogProc.processed:
    mov eax, 1
    jmp @f
DialogProc.finish:
mov eax, 0
@@:
   
   ret
endp
;--
proc receiver_thread hwnddlg
;--
    .thread_loop:
        cmp [exitFlag], 1
        je receiver_thread.thread_exit
invoke WaitForSingleObject, [hMutexXB], 10 
                mov [addrSize], SOCKADDR_SIZE
;--
        invoke recvfrom, [hSocket], buffer, sizeof.buffer, 0, clientAddr, addrSize 

                cmp eax, SOCKET_ERROR
        jle .no_data
        
        mov byte [buffer + eax], 0
                mov [savereg],eax             
;--
stdcall storeADR
invoke ReleaseMutex, hMutexXB




;--
invoke MultiByteToWideChar, CP_UTF8, 0, buffer, -1, tmp, 2048     
;--
invoke WideCharToMultiByte, CP_ACP, 0, tmp, -1, check, 2048, 0, 0 

@@:
cmp [comp],0
jne @f
invoke Sleep, 1 
jmp @b
@@:


        cmp dword[check], 'PEER'           
        jne @f

invoke WaitForSingleObject, [hMutexX], 10 
		mov [startKeep],  0
        mov byte[kalive], 0 
        mov [srvmode],    0    
        mov byte[srvmsg], 0    
invoke ReleaseMutex, hMutexX




mov eax, 0
mov edi, target_nick_buffer
mov ecx, 32/4             
rep stosd
stdcall sStore, target_nick_buffer


mov eax,0
mov edi, stringAddr
mov ecx,16/4
cld
rep stosd
stdcall sStore, stringAddr
mov esi, stringAddr
mov edi, stringAddr2
mov ecx,16/4
cld
;--
 rep movsd                 

mov eax,0
mov edi, strPort
mov ecx,6
cld
rep stosb
stdcall sStore, strPort

mov eax,0
mov edi, strPort2
mov ecx,6
cld
rep stosb
stdcall sStore, strPort2
mov [curSymbol],0              

;--
                invoke atoi, strPort2
                      xchg al,ah
;--
                      mov [clientAddr2.sin_port], ax
                                          xchg al,ah
;--
                  and eax, 00000000000000001111111111111111b 
				  mov [ressFPort], eax




invoke SetDlgItemText, [hwnddlg], ID_IPSET, stringAddr
invoke SetDlgItemText, [hwnddlg], ID_PORT, strPort

               invoke inet_addr, stringAddr 
               mov [clientAddr.sin_addr], eax 
               mov [clientAddr2.sin_addr], eax 
               
invoke GetDlgItemInt, [hwnddlg], ID_PORT, 0, FALSE 

                mov dword[ressPort],eax 
                      xchg al,ah
                      mov [clientAddr.sin_port], ax


;--
cinvoke wsprintf, income, peer_ress, check, stringAddr2, [ressFPort]

stdcall AddDebugMessage, income
invoke WaitForSingleObject, [hMutexX], 10 
        mov byte[syncro], 2    
        mov [popup],      0    
invoke ReleaseMutex, hMutexX            

                                jmp .after
@@:

        cmp dword[check], '53te'
         jne @f
        
invoke WaitForSingleObject, [hMutexX], 10 
           mov [srvmode], 1

        mov byte[syncro], 3
        mov [startKeep],  1   
        mov byte[kalive], 1
invoke ReleaseMutex, hMutexX

                jmp .utf2ansi
@@:     
        cmp dword[buffer], 'MSG:' 
        jne @f
invoke WaitForSingleObject, [hMutexX], 10 
        mov byte[srvmsg], 1   
        mov byte[syncro], 3
        mov    [srvmode], 0   
             mov [popup], 0   
invoke ReleaseMutex, hMutexX
               
                                jmp .msgmode
@@:     
        cmp dword[check], 'MSG_'
        jne @f
invoke WaitForSingleObject, [hMutexX], 10 
        mov byte[syncro], 3
           mov [srvmode], 1
invoke ReleaseMutex, hMutexX
invoke WaitForSingleObject, [hMutexXB], 10
                   stdcall AddTextToListBox, [hwnddlg], check, MSG_TYPE_SYSTEM  
invoke ReleaseMutex, hMutexXB
                jmp .utf2ansi
@@:     
        cmp dword[check], 'PEND'   
        jne @f                     
invoke WaitForSingleObject, [hMutexX], 10 
        mov byte[syncro], 0
           mov byte[srvmsg], 1   
invoke ReleaseMutex, hMutexX
                jmp .utf2ansi     
@@:     
        cmp dword[check], 'ERRO'
        jne @f
invoke WaitForSingleObject, [hMutexX], 10 
        mov byte[syncro], 3
           mov [srvmode], 1
invoke ReleaseMutex, hMutexX
                jmp .utf2ansi
@@:     
        cmp dword[check], 'TARG'
        jne @f
invoke WaitForSingleObject, [hMutexX], 10 
        mov byte[syncro], 3
           mov [srvmode], 1
invoke ReleaseMutex, hMutexX
                jmp .utf2ansi
@@:     
        cmp dword[check], '74jh'
        jne @f
invoke WaitForSingleObject, [hMutexX], 10 
                mov byte[syncro], 3
                
                mov byte[srvmsg], 0  
                mov [srvmode], 0
invoke ReleaseMutex, hMutexX
                           invoke WaitForSingleObject, [hMutexXF], 1
;--
                            mov [init_s2], 1
                           invoke ReleaseMutex, hMutexXF

                jmp .skipdec
@@:     
        cmp dword[check], 'IGNO'
        jne @f
invoke WaitForSingleObject, [hMutexX], 10 
        mov byte[syncro], 3
           mov [srvmode], 1
invoke ReleaseMutex, hMutexX
                jmp .utf2ansi                           
@@:     
        cmp dword[buffer], 'ALIV' 
        jne @f
invoke WaitForSingleObject, [hMutexX], 10
       
            mov byte[syncro], 3
           mov [srvmode], 1    
invoke ReleaseMutex, hMutexX
                           

                jmp .skipdec                            
@@:
        cmp dword[buffer], 'g14:'   
        jne @f
invoke WaitForSingleObject, [hMutexX], 10

       mov byte[srvmsg], 0   
       mov byte[syncro], 3   
       mov    [srvmode], 0   
invoke ReleaseMutex, hMutexX

                    jmp .skipdec

@@: 
.msgmode:
invoke WaitForSingleObject, [hMutexX], 10 
       mov byte[syncro], 0 
       cmp byte[srvmsg], 1 
invoke ReleaseMutex, hMutexX
je .utf2ansi        
jmp .over           
.utf2ansi:

                mov esi, check
                mov edi, buffer                
	mov eax, [savereg]  
    mov edx, eax        
	shr eax, 2          
    and edx, 3          
    mov ecx, eax        
    cld
;--
 rep movsd           
    mov ecx, edx        
    rep movsb           
    mov byte[edi],0



cmp dword[buffer],'PEND' 
je .over   

.if byte[syncro]=0
.over:
mov edx,0
mov ecx, [savereg]   
mov esi, buffer
mov edi, buffer
.if dword[buffer]='PEND'
add esi, 8 
sub ecx, 8
.endif
.if dword[buffer]='74jh'
add esi, 4 
sub ecx, 4
.endif
.if dword[buffer]='MSG:'
add esi, 4 
sub ecx, 4
.endif
;--
 @@:
cmp ecx,0             
   je  @f
   lodsb
   cmp al,0           
   je  @f
   dec ecx

   add al, 30
   stosb
   jmp @b
 @@:

mov dword[edi],0
.endif
.skipdec:                           
stdcall GetTD 
              

movzx eax, word[sysTime.wMinute]
movzx edx, word[sysTime.wHour]
.if [srvmode]=0
;--
cinvoke wsprintf, income, msg_simple, edx, eax, buffer 


jmp @f
.endif
;--
cinvoke wsprintf, income, msg2_ress, buffer, stringAddr, edx, eax
@@:
.if dword[check]<>'MSG:'
.if dword[check]<>'PEND'
  stdcall AddDebugMessage, income
jmp @f
.endif
.endif
invoke WaitForSingleObject, [hMutexXB], 10
        stdcall AddTextToListBox, [hwnddlg], income, MSG_TYPE_USER1
invoke ReleaseMutex, hMutexXB
invoke InvalidateRect,[hListBox],0,TRUE  
invoke UpdateWindow,[hListBox]
@@:
.if byte[syncro]<>2 
cmp dword[buffer], 'g14:'
je .after
;--
        invoke SetDlgItemInt, [hwnddlg], ID_PORT, dword[ressPort], FALSE 
;--
        invoke SetDlgItemText, [hwnddlg], ID_IPSET, stringAddr 
.endif
.after:
mov dword[check],0000 
    stdcall clrBuffer 
.if [popup]=0
    invoke IsIconic, [hwnddlg]
    test eax, eax
    jz .not_minimized
    invoke ShowWindow, [hwnddlg], SW_RESTORE
    invoke Sleep,10
	invoke ShowWindow, [hwnddlg], SW_SHOW
    invoke MessageBeep, MB_OK
	invoke Sleep,10
.not_minimized:
    invoke SetForegroundWindow, [hwnddlg]
	invoke Sleep,10
    invoke MessageBeep, MB_ICONQUESTION
        mov [popup], 1
invoke Sleep, 15
.endif
        jmp .thread_loop
    .no_data: 
        jmp .thread_loop
    receiver_thread.thread_exit:
        invoke ExitThread, 0
        ret
endp
;--
proc storeADR
 
    
                        mov eax,0
;--
                        mov ax, [clientAddr.sin_port]
                        xchg al,ah
;--
                        mov dword[ressPort], eax

 
invoke WaitForSingleObject, [hMutexXC], 1
                mov eax, [clientAddr.sin_addr]
        invoke inet_ntoa, eax
                mov esi, eax
                mov edi, stringAddr
                        mov ecx, 15
                        cld
;--
						rep movsb
invoke ReleaseMutex, hMutexXC
          ret
                
endp
;--
proc init_network hwnddlg
    invoke WSAStartup, 0x202, wsaData
    test eax, eax
    jz @f
    jmp .error
@@:  
invoke WaitForSingleObject, [hMutexXB], 10
	stdcall AddDebugMessage, wsaStartMsg
invoke ReleaseMutex, hMutexXB
    invoke socket, AF_INET, SOCK_DGRAM, IPPROTO_UDP
    cmp eax, INVALID_SOCKET
    jne @f
    jmp .error
@@:
    mov [hSocket], eax
    invoke WaitForSingleObject, [hMutexXB], 10
    stdcall AddDebugMessage, socketCreatedMsg
	invoke ReleaseMutex, hMutexXB
    invoke setsockopt, [hSocket], SOL_SOCKET, SO_REUSEADDR, [reuse], 4
	invoke setsockopt, [hSocket], SOL_SOCKET, SO_RCVTIMEO, TIMEOUT, 4
	invoke setsockopt, [hSocket], SOL_SOCKET, SO_SNDTIMEO, TIMEOUT, 4
    invoke ioctlsocket, [hSocket], FIONBIO, MODE
    mov [serverAddr.sin_family], AF_INET
    mov ax, word[portserver_value] 
    xchg al, ah
    mov [serverAddr.sin_port], ax
    mov [clientAddr.sin_addr], NULL  
    mov dword [serverAddr.sin_zero], 0
    mov dword [serverAddr.sin_zero+4], 0
    invoke bind, [hSocket], serverAddr, SOCKADDR_SIZE
    cmp eax, SOCKET_ERROR
    jne .create_thread
    invoke WSAGetLastError
    cinvoke wsprintf, mess, bindErrorMsg, eax
    invoke WaitForSingleObject, [hMutexXB], 10
    stdcall AddTextToListBox, [hwnddlg], mess, MSG_TYPE_ERROR
    invoke ReleaseMutex, hMutexXB
    jmp .error
.create_thread:
    mov ax, [serverAddr.sin_port]
    rol ax,8
    cinvoke wsprintf, mess, portMsg, eax
    invoke WaitForSingleObject, [hMutexXB], 10
    stdcall AddDebugMessage, mess
	invoke ReleaseMutex, hMutexXB
    invoke CreateThread, 0, 0, receiver_thread, [hwnddlg], 0, thread_id
    mov [hThread], eax
	invoke Sleep, 100
.success:
invoke Sleep, 100
invoke SetThreadAffinityMask, [hThread], 2
    cinvoke wsprintf, mess, initSuccessMsg
    invoke WaitForSingleObject, [hMutexXB], 10
stdcall AddTextToListBox, [hwnddlg], mess, MSG_TYPE_SYSTEM
    invoke ReleaseMutex, hMutexXB
    jmp .exit
.error:
    invoke WSACleanup
    mov [hSocket], INVALID_SOCKET
.exit:
ret
endp
;--
proc RefreshPB hDialog
.oborot:
		invoke Sleep, 100
		invoke GetTickCount
        
        cmp eax,0
		jne @f
		inc eax
		@@:
		mov [alltick], eax
        
		cmp [refreshB],1
		jne .oborot
		mov [refreshB], 0
		invoke PostMessage,[hProgress],PBM_SETPOS,[Progress],0
		
   jmp .oborot
ret
endp
;--
proc timer_thread hwnd         
    .looping:
        cmp [exitFlag], 1
        je .exit
.if [startKeep]=1
    .if byte[srvmode]=0 
    stdcall keepalive, [hwnd]                  
invoke Sleep, 30000
    .endif
    .if byte[syncro]=3
      .if [srvmode]=1
        invoke WaitForSingleObject, [hMutexX], 10
        mov byte[kalive],1
        invoke ReleaseMutex, hMutexX
        @@:
        cmp [comp],0
        jne @f
        invoke Sleep, 0.1 
        jmp @b
        @@:
        invoke PostMessage, [hwnd], WM_NULL, 0, 0
invoke Sleep, 30000
     .endif
    .endif
.endif
    jmp .looping
       .exit:
     ret
endp
;--
proc keepalive hwnd
mov byte[srvmsg], 0 

invoke WaitForSingleObject, [hMutexX], 10
   mov byte[kalive],1
invoke ReleaseMutex, hMutexX
@@:
cmp [comp],0
jne @f
invoke Sleep, 0.1 
jmp @b
@@:
 invoke PostMessage, [hwnd], WM_NULL, 0, 0
.nextmin:
    ret
endp
;--
proc GetTD

 invoke GetLocalTime, sysTime  
 ret
endp
;--
proc sStore field
mov esi, check
mov edi, [field]
.if dword[check]='PEER'
add esi, 5 
.endif
.if dword[buffer]='g14:'
add esi, 4 
.endif

add esi, dword[curSymbol]
@@:
inc dword[curSymbol]
   lodsb
   cmp al,':'
   je  @f
   stosb
   cmp dword[esi],0000
   je @f
   jmp @b
 @@:
ret
endp
;--
proc SyncmoD hwnddlg
    .if byte[syncro]=1 
        invoke SetDlgItemInt, [hwnddlg], ID_PORT, [portstart_value], FALSE 
        invoke SetDlgItemText, [hwnddlg], ID_IPSET, ip_server 
     
		        mov eax, 0 
                mov ecx, 16
                mov esi, ip_server 
                mov edi, stringAddr
                cld
				repne movsb
                mov byte[edi],0
        invoke inet_addr, stringAddr
        mov [clientAddr.sin_addr], eax
        mov [clientAddr2.sin_addr], eax
                mov ax, word[portstart_value] 
                xchg al, ah
                        mov [clientAddr.sin_port], ax
                mov ax, F_SERVER_PORT
                xchg al, ah
                        mov [clientAddr2.sin_port], ax
        cinvoke wsprintf, userInput, str_nick, my_nick_buffer, target_nick_buffer
        mov [height], eax  
        mov [init_s2], 1   
        jmp @f
    .endif
    .if byte[kalive]=1
        cinvoke wsprintf, userInput, str_keep, my_nick_buffer, target_nick_buffer
        mov [heightk], eax
    .endif
@@:
        ret
endp
proc Hello
       stdcall [MessageBox],0,Cont,About,MB_OK
       ret
endp
proc EULA
       stdcall [MessageBox],0,EULAtxt,"Impotant Information",MB_OKCANCEL + MB_ICONINFORMATION
       ret
endp
;--
proc stripping string 

@@:
.if[dizzy]=0                              
invoke Sleep, 0.1                         
jmp @b
.endif
mov [dizzy],0                        
local count dd 0
        mov edx, eax
mov [count], edx
        mov edi, [string]
        add edi, eax
.strip: 
    cmp byte [edi], 127
        jl .smaller
mov byte[edi],32
jmp .succes
.smaller:
        cmp byte [edi], 32
        jae .succes
mov byte[edi],32
.succes:
cmp edx, 0
je .compl
dec edi
dec edx
jmp .strip
.compl:
add edi, [count]
mov byte[edi], 0
mov [dizzy], 1
ret
endp
;--
proc strippWRK string
@@:
.if[dizzy]=0                              
invoke Sleep, 0.1                         
jmp @b
.endif
mov [dizzy],0                        
mov ebx, edi
        mov edi, [string]
        add edi, eax
.strip: 
        cmp byte [edi], 32
        ja .succes
mov byte[edi],0
dec edi
jmp .strip
.succes:
mov edi, ebx
mov [dizzy], 1
ret
endp
proc clrInput
mov ebx, edi
mov ecx, sizeof.input / 4
mov edi, tmplocal
mov eax, 0
rep stosd
mov edi, ebx
ret
endp
;--
proc clrBuffer
mov ebx, edi
mov ecx, sizeof.buffers / 4
mov edi, tmp
mov eax, 0
rep stosd
mov edi, ebx
ret
endp
;--
proc AddTextToListBox hwnddlg, pText, msgType

@@:
.if[dizzy]=0                         
invoke Sleep, 1                         
jmp @b
.endif
mov [dizzy],0                        
    local hListBox dd 0
    local textLength dd 0
    local index dd 0  
;--
    invoke GetDlgItem, [hwnddlg], ID_LISTBOX
    mov [hListBox], eax
    invoke lstrlen, [pText]
    mov [textLength], eax 
    cmp eax, MAX_LINE_LENGTH
    jle .add_as_is 
    mov esi, [pText]
    lea edi, [tempBuffer]
    xor ecx, ecx
.split_string:
.split_loop:
;--
    lodsb
    cmp al, 0
    jz .add_last_line
    stosb
    inc ecx
    cmp ecx, MAX_LINE_LENGTH
    jl .next_char
    
    mov ebx, edi
    dec ebx
    lea edx, [tempBuffer]

.find_break:
    cmp ebx, edx
    jle .force_break
    mov al, byte[ebx]
    cmp al, ' '
    je .found_break
    cmp al, '.'
    je .found_break
    dec esi
    dec ebx
    jmp .find_break
.force_break:
    mov ebx, edi
    add esi, MAX_LINE_LENGTH
    dec esi
.found_break:
    mov byte[ebx], 0
;--
    stdcall AddCachedItem, [hwnddlg], addr tempBuffer, [msgType]
    lea edi, [tempBuffer]
    mov ecx, 0
    jmp .split_string
.next_char:
    jmp .split_loop
.add_last_line:
    mov byte[edi], 0
    stdcall AddCachedItem, [hwnddlg], addr tempBuffer, [msgType]
        jmp .done
.add_as_is:
;--
    stdcall AddCachedItem, [hwnddlg], [pText], [msgType]
.done:
mov [dizzy],1 
    invoke InvalidateRect,edx,0,TRUE
    invoke UpdateWindow,edx
    mov eax, [itemCount]
    dec eax
    invoke SendMessage, [hListBox], LB_SETCURSEL, eax, 0
        ret
endp
;--
proc AddCachedItem hwnddlg, text, itemType    
    mov ebx, [itemCount]
    cmp ebx, MAX_ITEMS
    jl .count_ok
    xor eax,eax
    jmp .exit
.count_ok:
    invoke lstrlen,[text] 
    inc eax               
    invoke LocalAlloc, LPTR, eax
    test eax, eax
    jz .error_alloc
    mov edi, eax    
    invoke lstrcpy, edi, [text] 
    mov ebx,[itemCount]
    mov edx,0
	imul ebx,sizeof.LIST_ITEM
    lea ecx,[listItems+ebx]
    mov [ecx],edi 
    mov eax,[itemType]        
    mov [ecx+LIST_ITEM.color],eax 
inc dword [itemCount]  
    invoke GetDlgItem, [hwnddlg], ID_LISTBOX
        mov edx, eax 
    invoke SendMessage,edx,LB_ADDSTRING,0, 0    
jmp .exit
.no_increment:
    jmp .exit
.error_alloc:
    invoke LocalFree, eax 
    xor eax, eax
.exit:
    ret
endp
;--
proc DebugDialogProc hDebugWnd,dmsg,dwparam,dlparam
    cmp [dmsg],WM_INITDIALOG
    je .wminitdialog
    cmp [dmsg],WM_CLOSE
    je .wmclose
        cmp [dmsg], WM_SIZE
    je .wmsize
    cmp [dmsg],WM_COMMAND
    je .wmcommand
    xor eax,eax
    ret
.wminitdialog:
    mov eax,1
    ret
.wmsize:
    mov eax, [dlparam]
    movzx ebx, ax          
    shr eax, 16                   
    invoke GetDlgItem, [hDebugWnd], ID_DEBUG_LISTBOX
    test eax, eax
    jz .wm_size_done
    mov esi, eax   
    mov ebx, [dlparam]          
    movzx ecx, bx              
    shr ebx, 16                    
    sub ecx, 10                
    sub ebx, 10                   
    cmp ecx, 0
    jg @f
    mov ecx, 1
@@:
    cmp ebx, 0
    jg @f
    mov ebx, 1
@@:  
    invoke SetWindowPos, esi, 0, 5, 5, ecx, ebx, SWP_NOZORDER   
.wm_size_done:
    mov eax, 0
    ret
.wmcommand:
    mov eax,1
    ret
DebugDialogProc.wmclose:
    invoke DestroyWindow,[hDebugWnd]
    mov [hDebugWnd],0
    mov eax,1
    ret
endp
;--
proc AddDebugMessage dmsg
    cmp [hDebugWnd], 0
    je .exit
    invoke GetDlgItem, [hDebugWnd], ID_DEBUG_LISTBOX
    mov ebx, eax
    invoke SendMessage, ebx, LB_ADDSTRING, 0, [dmsg]
    invoke SendMessage, ebx, LB_GETCOUNT, 0, 0
    dec eax   
    invoke SendMessage, ebx, LB_SETTOPINDEX, eax, 0
.exit:
    ret
endp
;--
proc InitializeListResources
        invoke CreateSolidBrush,00000000h  
    mov [hBlackBrush],eax
    invoke CreateSolidBrush,00008000h  
    mov [hGreenBrush],eax
    invoke CreateSolidBrush,000000FFh 
    mov [hErrorBrush], eax
        invoke CreateSolidBrush,00800000h  
    mov [hBlueBrush],eax
        invoke CreateSolidBrush,00FFFFFFh 
    mov [hWhiteBrush], eax
    invoke CreateSolidBrush,00F0F0F0h 
    mov [hGrayBrush], eax
    invoke CreateSolidBrush,00C04000h 
    mov [hHighlightBrush], eax
    ret
endp
;--
proc MainLoop
.Init_block:
invoke socket, AF_INET, SOCK_DGRAM, IPPROTO_UDP
mov [hSocket2], eax
invoke setsockopt, [hSocket2], SOL_SOCKET, SO_REUSEADDR, [reuse], 4
invoke setsockopt, [hSocket2], SOL_SOCKET, SO_RCVBUF, [InbuffSize], 4
invoke setsockopt, [hSocket2], SOL_SOCKET, SO_SNDBUF, [InbuffSize], 4				   
invoke setsockopt, [hSocket2], SOL_SOCKET, SO_RCVTIMEO, TIMEOUT, 4
invoke setsockopt, [hSocket2], SOL_SOCKET, SO_SNDTIMEO, TIMEOUT, 4
invoke ioctlsocket, [hSocket2], FIONBIO, MODE
    mov [clientAddr2.sin_family], AF_INET
    mov ax, word[Fportstart_value] 
    xchg al, ah
    mov [clientAddr2.sin_port], ax
    mov [clientAddr2.sin_addr], NULL 
    mov dword [clientAddr2.sin_zero], 0
    mov dword [clientAddr2.sin_zero+4], 0
    mov [serverAddr2.sin_family], AF_INET
    mov ax, word[Fportserver_value] 
    xchg al, ah
    mov [serverAddr2.sin_port], ax
    mov [serverAddr2.sin_addr], NULL 
    mov dword [serverAddr2.sin_zero], 0
    mov dword [serverAddr2.sin_zero+4], 0
        invoke bind, [hSocket2], serverAddr2, SOCKADDR_SIZE
    cmp eax, SOCKET_ERROR
    je .error
 invoke CreateThread, 0, 0, receiver_thread2, [hwnddlg], 0, thread_id
    mov [hThread2], eax          
     test eax, eax
     jnz .success
 .error:
     invoke WSACleanup
     mov [hSocket2], INVALID_SOCKET
 jmp .Init_block
.success:
invoke Sleep, 100 
invoke SetThreadAffinityMask, [hThread2], 4
.restart:
mov [Restart], 0 
invoke Sleep, 20 
cmp [LPTR_lfile],0
    jz @f
invoke LocalFree, [LPTR_lfile]
invoke Sleep, 100
    mov [LPTR_lfile],0
@@:
cmp [LPTR_storeF],0      
jz @f
invoke Free,[hHeap],0,[LPTR_storeF]
invoke Sleep, 100
    mov [LPTR_storeF],0  
@@:
invoke WaitForSingleObject, [hMutexX], 10
   mov byte[syncro], 3 
   mov byte[srvmode], 1 
   mov byte[srvmsg], 1  
   mov [startKeep], 1  
invoke ReleaseMutex, hMutexX
invoke WaitForSingleObject, [hMutexXD], 10
.back:           
mov [szOffSet],0
mov [flow_file],0
mov [rflow_file],0
mov [headerSize],0
mov dword[curFSymbol], 0
mov [session_id],'1234'
mov [rsOffSet],0     
mov [last_OffSet],-1 
mov [RdataWOHead],0     
mov [szFileNameSize],0
mov [BaseFileSize],0
mov [last_rpack_time],0  
mov [last_spack_time],0  
mov [firstEnter],1
mov [firstPacket],1
mov [mapping],0
mov [Hnakopla],0
mov [mapsend],0
mov [mapsize],0
mov [bingoCount],0
mov [Retry],0
mov [skipcnt],0
mov [cnt_recv_mode],0
invoke RtlZeroMemory, rsOffSetA, 32
invoke RtlZeroMemory, FNSizeString, 32
invoke RtlZeroMemory, dbgres, 32
invoke RtlZeroMemory, szFileName, 260
invoke RtlZeroMemory, fsend, UbuffSize
invoke RtlZeroMemory, fbuffer, UbuffSize
invoke RtlZeroMemory, fpng, 256
       invoke ReleaseMutex, hMutexXD
mov ecx, 131072 / 4 
mov edi, checkPacket  
rep stosd
mov [Progress],65535 
mov [Countpack],0
mov [Peaces],0
mov [last_update],0
mov [refreshB], 1
cinvoke wsprintf, fmess, msg_systemPI, "Re/Start socket2 recv tread", stringAddr, F_SERVER_PORT
stdcall AddDebugMessage, fmess
invoke WaitForSingleObject, [hMutexXD], 10
mov [sendsize],1 
mov [transfer],4 
invoke ReleaseMutex, hMutexXD
invoke WaitForSingleObject, [hMutexXE], 1 
mov [complete],1
invoke ReleaseMutex, hMutexXE
xor eax, eax
xor ebx, ebx
xor edx, edx
xor ecx, ecx
xor esi, esi
xor edi, edi
;--
.sendblk:
@@:
cmp [complete],0
jne @f
invoke Sleep, 1 
jmp @b
@@:
invoke WaitForSingleObject, [hMutexXE], 1 
mov [complete],0  
invoke ReleaseMutex, hMutexXE
invoke EnterCriticalSection, addr csCritical 
cmp [last_rpack_time],0
je @f
   cmp [transfer],4
   jne @f
      cmp [cnt_recv_mode],1
      jne @f
        mov eax, [alltick]
        sub eax, [last_rpack_time]
        cmp eax, 1000
        jle @f 
          mov [last_rpack_time],0 
          mov [last_spack_time],0 
		  mov [Retry],0
		  mov [mapping],1
          mov [transfer],6  
@@:
cmp [last_spack_time],0
je @f
mov eax, [alltick]
sub eax, [last_spack_time]
cmp eax, TIMEOUT
jl @f
mov [mapping],0
mov [Restart],1
@@:
invoke LeaveCriticalSection, addr csCritical
.if [transfer]=0  
invoke WaitForSingleObject, [hMutexX], 10
mov [startKeep], 0  
invoke ReleaseMutex, hMutexX
 mov esi, stringAddr
 mov edi, stringAddr2
 mov ecx, 16/4
 cld
;--
 rep movsd
               invoke inet_addr, stringAddr 
;--
           mov [clientAddr.sin_addr], eax 
;--
           mov [clientAddr2.sin_addr], eax 
                 mov eax,0
;--
             mov ax,[clientAddr2.sin_port]
                 xchg al,ah
;--
             mov dword[ressFPort],eax
;--
                 invoke _itoa, [ressFPort], strPort2, 10
                                 invoke WaitForSingleObject, [hMutexXC], 1
                 stdcall strippWRK, strPort2
                 invoke ReleaseMutex, hMutexXC
invoke WaitForSingleObject, [hMutexXD], 1
mov [transfer],2  
invoke ReleaseMutex, hMutexXD
;--
cinvoke wsprintf, fsend, data_hdr, session_id, [szFileNameSize], szFileName  
;--
invoke sendto, [hSocket2], fsend, eax, 0, clientAddr2, SOCKADDR_SIZE
invoke Sleep, 3500 
.endif
.if [transfer]=1  
invoke  GetProcessHeap
    mov     dword[hHeap],eax
     mov eax, [szFileNameSize]
     cmp eax, 0
     jz MainLoop.restart
    add eax, UbuffSize * 2
	invoke  HeapAlloc,[hHeap],HEAP_ZERO_MEMORY+HEAP_GENERATE_EXCEPTIONS,eax
    test eax, eax
    jnz .alloc_ok
	invoke Free,[hHeap],0,[LPTR_storeF]
	mov [LPTR_storeF], 0
	invoke Sleep, 100
    invoke MessageBox, 0, "Ошибка HeapAlloc", "Dest File - Ошибка HeapAlloc" , MB_ICONERROR
    xor eax, eax
    jmp MainLoop.restart
.alloc_ok:
mov [LPTR_storeF], eax   
invoke Sleep, 100 
mov eax, [szFileNameSize]
cmp [szFileNameSize], UbuffSize
jna @f
mov edx,0
mov ebx, 16256 
div ebx
cmp edx, 0
jz @f
inc eax
@@:
mov [mapsize],eax 
mov [mapsend],eax 
stdcall init_bar
invoke WaitForSingleObject, [hMutexXD], 1
mov [transfer],4 
invoke ReleaseMutex, hMutexXD
invoke WaitForSingleObject, [hMutexXE], 1
mov [complete], 1
invoke ReleaseMutex, hMutexXE
jmp .sendblk
.endif
.if [transfer]=7  
 ;--
invoke EnterCriticalSection, addr csCritical 
pusha
 mov eax, [alltick] 
 mov [last_spack_time],eax 
cmp [firstEnter],1
jne @f
mov [startKeep], 0  
mov [szOffSet], 0
mov [flow_file], 0
mov [headerSize], 0
mov [firstEnter], 0
mov eax, [mapsize]
mov [mapsend], eax
mov [mapping],1 
mov [last_rpack_time],0 
mov [skipcnt], 0
 @@:
cmp [mapsize],0  
jne @f
.completret:
mov [transfer],4
mov [firstEnter],1
mov [complete], 1
popa
invoke LeaveCriticalSection, addr csCritical
jmp MainLoop.sendblk
@@:
mov edi, matrix    
add edi, [mapsize] 
dec edi
mov eax,0          
mov ecx, [mapsize]
std
repne scasb          
cld
mov [mapsize], ecx   
mov edx,0
mov eax, 16256       
mul [mapsize]
mov [szOffSet], eax
mov eax, [LPTR_lfile] 
add eax, [szOffSet]   
mov [flow_file], eax  
cmp ecx, 0 
jne @f
cmp dword[LPTR_lfile],0  
je .completret          
@@:
cinvoke wsprintf, fsend, data_retry, session_id, dword[szOffSet]  
mov eax, 128
mov [headerSize], 128
jmp MainLoop.rit
.endif
.if [transfer]=2  
.if [sendsize]>0 
          mov eax, [alltick]
mov [last_spack_time],eax 
mov eax, [LPTR_lfile]
add eax, [szOffSet]
mov [flow_file], eax   
cmp dword[fbuffer], '568:' 
je MainLoop.fixing                 
invoke EnterCriticalSection, addr csCritical
pusha
cinvoke wsprintf, fsend, data_cnt, session_id, dword[szOffSet]  
mov eax, 128
mov [headerSize], 128
MainLoop.rit:        
mov ebx, UbuffSize      
sub ebx, [headerSize]   
mov esi, [flow_file]    
mov edi, fsend
add edi, [headerSize]   
cld
mov ecx, UbuffSize  
shr ecx, 6          
;--
.copy_64_loop:
    movdqu xmm0, [esi]
    movdqu xmm1, [esi+16]
    movdqu xmm2, [esi+32]
    movdqu xmm3, [esi+48]
    movdqu [edi], xmm0
    movdqu [edi+16], xmm1
    movdqu [edi+32], xmm2
    movdqu [edi+48], xmm3
    add esi, 64
    add edi, 64
    dec ecx
    jnz .copy_64_loop
popa
invoke LeaveCriticalSection, addr csCritical
call ProgBarS 
MainLoop.flow03:
inc [skipcnt]
.if [skipcnt]>7
cmp [skipcnt], 19
jae .normal
jmp @f
.endif
.normal:
mov eax, UbuffSize
;--
invoke sendto, [hSocket2], fsend, eax, 0, clientAddr2, SOCKADDR_SIZE
@@:
mov eax, UbuffSize
sub eax, 128 
cmp [transfer],7
je @f
add [szOffSet], eax     
mov eax,[sendsize]      
@@:
cmp dword[fbuffer], '568:' 
je MainLoop.fixing
.if [firstEnter]<>0  
mov ebx, [szFileNameSize]
add ebx, [headerSize] 
cmp ebx, UbuffSize
jna .minis
.if eax>=[szFileNameSize]    
.minis:
.if [sendsize]>1
cmp [transfer],7    
je MainLoop.fixing          
invoke WaitForSingleObject, [hMutexXD], 1
mov [transfer],4
mov [szOffSet],0
mov [sendsize],0     
mov [flow_file],0
mov [szFileNameSize],0
mov byte[szFileName],0
mov [headerSize],0
invoke ReleaseMutex, hMutexXD
.endif
.endif
mov eax, [szOffSet]
mov [sendsize], eax
MainLoop.fixing:
.endif
.endif
.endif
.if [transfer]=6  
invoke EnterCriticalSection, addr csCritical
pusha
mov eax, [alltick] 
mov [last_spack_time],eax 
cmp [firstEnter],1
jne @f
mov [startKeep], 0  
mov [szOffSet],0
mov [flow_file], 0
mov [headerSize], 0
mov [firstEnter], 0
@@:
;--
cinvoke wsprintf, fsend, data_matrix, session_id, dword[mapsize], dword[szOffSet]  
mov eax, 128
mov [headerSize], 128
mov ebx, dword[szOffSet]          
lea esi, [checkPacket+ebx] 
lea edi, [fsend+eax]       
 mov ecx, 16256
 shr ecx, 2
 cld
 rep movsd           
mov ecx, [mapsend]   
mov ebx, [headerSize]
add ebx, ecx         
cmp ebx, UbuffSize   
jna @f               
mov ecx, UbuffSize
sub ecx, [headerSize]
sub [mapsend], ecx   
add [szOffSet], ecx  
jmp .sendmtx
@@:
mov eax, [mapsize] 
mov [mapsend], eax 
mov [last_spack_time],0 
mov [transfer],4      
mov [firstEnter], 1
.sendmtx:
mov eax, UbuffSize 
;--
invoke sendto, [hSocket2], fsend, eax, 0, clientAddr2, SOCKADDR_SIZE
popa
invoke LeaveCriticalSection, addr csCritical
jmp MainLoop.Bupas 
.endif
.if [transfer]=3  
invoke WaitForSingleObject, [hMutexXD], 1
mov [transfer],5  
invoke ReleaseMutex, hMutexXD
invoke WaitForSingleObject, [hMutexXE], 1
mov [complete], 0 
invoke ReleaseMutex, hMutexXE
jmp choosefS
;--
MainLoop.continueS:
.endif
.if [init_s2]=1
cmp [transfer],4  
jne .newremya
cmp [mapping],1
je .newremya
mov eax, [last_spack_time]
  .if [last_rpack_time]=eax

       .if byte[syncro]=1             
		cinvoke wsprintf, fpng, str_nick, my_nick_buffer, target_nick_buffer
mov edx, eax
         jmp @f		 
.endif
                          .if byte[kalive]=1
                             mov edx,4
                             mov dword[fpng],'74jh'     
                             jmp @f
                           
                          .endif
        .if byte[syncro]=2             
         mov edx,4
         mov dword[fpng],'g14:'       
         jmp @f
        .endif
                    mov edx,[height]
                    mov esi,userInput  
                    mov edi,fpng
                    mov ecx, edx
                    cld
    ;--
                    rep movsb
                    mov byte[edi],0
        @@:
    ;--
                           invoke sendto, [hSocket2], fpng, edx, 0, clientAddr2, SOCKADDR_SIZE
  .endif
.newremya:  
invoke WaitForSingleObject, [hMutexXF], 1
;--
mov [init_s2], 0
invoke ReleaseMutex, hMutexXF
.endif
MainLoop.Bupas:
;--
invoke RtlZeroMemory, fsend, UbuffSize 
.flow:
.if [Restart]=1
mov [Restart], 0
jmp MainLoop.restart
.endif
invoke WaitForSingleObject, [hMutexXE], 1
mov [complete],1        
invoke ReleaseMutex, hMutexXE
invoke Sleep, 10 
jmp MainLoop.sendblk
ret
endp
;--
proc receiver_thread2 hwnddlg 
    receiver_thread2.thread_loop: 
        cmp [exitFlag2], 1
        je receiver_thread2.thread_exit
invoke EnterCriticalSection, addr csCritical
     cmp [last_rpack_time],0
     jz @f
	 cmp[last_spack_time],0 
	 jne @f
     cmp [transfer], 4 
     jne @f      
          mov eax, [alltick]       
          sub eax, [last_rpack_time] 	  
.generic:
	  cmp eax, TIMEOUT
      jl @f
      mov [last_rpack_time],0

                  mov [Restart], 1
@@:
invoke LeaveCriticalSection, addr csCritical
mov [addrSize], SOCKADDR_SIZE
;--
        invoke recvfrom, [hSocket2], fbuffer, sizeof.fbuffer, 0, clientAddr2, addrSize 
                cmp eax, SOCKET_ERROR
        je receiver_thread2.no_data      
;--
        mov byte [fbuffer + eax], 0
                mov [RdataWOHead], eax            
@@:
invoke Sleep, 0 
cmp [complete],0
jne @f
jmp @b
@@:
invoke WaitForSingleObject, [hMutexXE], 1
mov [complete],0
invoke ReleaseMutex, hMutexXE
cmp dword[fbuffer], '568:'
jne .norix
stdcall sFStore, session_id
cmp [session_id], '1234'  
jne receiver_thread2.thread_loop  
stdcall sFStore, FNSizeString
stdcall sFStore, rsOffSetA
mov dword[curFSymbol], 0    
invoke EnterCriticalSection, addr csCritical 
pusha
invoke atoi, FNSizeString    
mov [mapsize],eax   
invoke atoi, rsOffSetA
mov [rsOffSet], eax 
.if [firstPacket]=1
mov [firstPacket],0
mov [transfer], 4 
mov [last_spack_time],0 
.endif
mov ebx, 128
mov [RecvHeader], ebx
lea esi, [fbuffer+ebx]
mov ebx, [rsOffSet]
lea edi, [matrix+ebx]           
mov ecx, 16256
shr ecx, 2
cld
rep movsd           
mov ebx, [RecvHeader]     
add ebx, [mapsize]
cmp ebx, UbuffSize
jl @f
mov eax, [rsOffSet]
add eax, UbuffSize
.if eax>=[mapsize]
@@:
mov [rsOffSet], 0
mov [transfer], 7       
mov [firstPacket],1     
mov [last_rpack_time],0 
mov [RecvHeader], 0
.endif
popa
invoke LeaveCriticalSection, addr csCritical
invoke RtlZeroMemory, FNSizeString, 32
jmp receiver_thread2.iter 
.norix:
cmp [transfer],2                    
je receiver_thread2.skipmode
cmp [transfer],3                    
je receiver_thread2.skipmode
cmp [transfer],5
je receiver_thread2.skipmode
cmp [transfer],7
je receiver_thread2.skipmode
.if dword[fbuffer]='268:' 
cmp [Retry],0
jne receiver_thread2.Ritri
invoke WaitForSingleObject, [hMutexXD], 1
mov [transfer],4
mov [last_spack_time],0 
invoke ReleaseMutex, hMutexXD
mov [Retry],1  
mov [last_OffSet],-1
jmp receiver_thread2.Ritri
.endif
cmp [transfer],6          
je receiver_thread2.badpacket
cmp [firstEnter],0        
je receiver_thread2.badpacket 
.if dword[fbuffer]='114:'  
;--
receiver_thread2.Ritri:
stdcall sFStore, session_id
cmp [session_id], '1234'  
jne receiver_thread2.thread_loop          
;--
stdcall sFStore, rsOffSetA
mov dword[curFSymbol], 0 
;--
invoke atoi, rsOffSetA
cmp  eax, [BaseFileSize] 
jnb receiver_thread2.badpacket  
mov ebx, eax
add ebx, [LPTR_storeF]
cmp ebx, [LPTR_storeF]
jb receiver_thread2.badpacket  
 mov [rsOffSet], eax
 cmp [last_OffSet],0      
 je @f
 cmp [last_OffSet], eax  
 je receiver_thread2.iter
@@:
 mov [last_OffSet], eax  
jmp receiver_thread2.ProgressBarR     
receiver_thread2.flow02:              
invoke EnterCriticalSection, addr csCritical
pusha
mov ebx, 128
mov [RecvHeader], ebx
sub [RdataWOHead], ebx   
lea esi, [fbuffer+ebx]   
mov edi, [LPTR_storeF]   
add edi, [rsOffSet]      
 cmp dword[edi],0  
 jz .netu          
 popa
 invoke LeaveCriticalSection, addr csCritical
 jmp receiver_thread2.iter
 .netu:
cmp [cnt_recv_mode],1 
je @f
mov [cnt_recv_mode],1 
@@:
mov edx, [RdataWOHead]
add [rflow_file], edx  
add [Hnakopla], ebx    
cld
mov ecx, 16256  
shr ecx, 6          
;--
.copy_64_loop2:
    movdqu xmm0, [esi]
    movdqu xmm1, [esi+16]
    movdqu xmm2, [esi+32]
    movdqu xmm3, [esi+48]   
    movdqu [edi], xmm0
    movdqu [edi+16], xmm1
    movdqu [edi+32], xmm2
    movdqu [edi+48], xmm3    
    add esi, 64
    add edi, 64
    dec ecx
    jnz .copy_64_loop2
mov eax, [rsOffSet] 
cmp eax, 0 
je @f
mov ebx, 16256
mov edx,0
div ebx
@@:      
mov ebx, checkPacket  
add ebx, eax
mov byte[ebx],1
inc [bingoCount]      
mov eax, [alltick]
mov [last_rpack_time],eax 
popa
invoke LeaveCriticalSection, addr csCritical
.if [mapping]=1
invoke EnterCriticalSection, addr csCritical
pusha
mov edi, checkPacket   
add edi, [mapsend] 
dec edi
mov eax,0
mov ecx, [mapsend]
std
repne scasb
cld
.filler:
cmp ecx,0 
jne receiver_thread2.skpfinchk 
mov edi, checkPacket   
add edi, [mapsize] 
dec edi
mov eax,0
mov ecx, [mapsize]
std
repne scasb
cld
mov [mapsend], ecx 
mov [mapsize], ecx 
cmp ecx,0 
je receiver_thread2.bingobin
receiver_thread2.Reply:
mov [Retry],0
mov [transfer],6  
mov [last_rpack_time],0 
receiver_thread2.skpfinchk:
popa
invoke LeaveCriticalSection, addr csCritical
jmp @f
receiver_thread2.bingobin:
popa
invoke LeaveCriticalSection, addr csCritical
jmp receiver_thread2.right
@@:
jmp receiver_thread2.iter 
.endif
mov ebx, [RecvHeader]
add ebx, [szFileNameSize] 
cmp ebx, UbuffSize
jna receiver_thread2.minir
mov eax, [rsOffSet]     
add eax, [RdataWOHead]      
.if eax>=[szFileNameSize] 
invoke EnterCriticalSection, addr csCritical
pusha
mov edi, checkPacket   
add edi, [mapsize] 
dec edi
mov eax,0
mov ecx, [mapsize]
std
repne scasb
cld
je @f
popa
invoke LeaveCriticalSection, addr csCritical
 jmp receiver_thread2.right
@@:
popa
invoke LeaveCriticalSection, addr csCritical
invoke WaitForSingleObject, [hMutexXD], 1
mov [mapping],1                      
mov [transfer],6  
mov [last_rpack_time],0 
invoke ReleaseMutex, hMutexXD
jmp receiver_thread2.iter 
receiver_thread2.right:
mov [mapping],0  
mov [Retry],0
receiver_thread2.minir:
invoke WaitForSingleObject, [hMutexXD], 1
mov [cnt_recv_mode],0
mov [last_rpack_time],0 
mov [last_spack_time],0 
invoke ReleaseMutex, hMutexXD
.if [transfer]<>3
invoke WaitForSingleObject, [hMutexXD], 1
mov [rsOffSet],0     
mov [last_OffSet],-1 
mov [RdataWOHead],0  
invoke ReleaseMutex, hMutexXD
.if [mapping]=0
invoke WaitForSingleObject, [hMutexXD], 1
mov [transfer],3     
invoke ReleaseMutex, hMutexXD
jmp receiver_thread2.iter
.endif
.endif
.endif
.endif

.if [last_rpack_time]=0 
        cmp dword[fbuffer], '74jh'
        jne @f
 mov esi, stringAddr
 mov edi, stringAddr2
 mov ecx, 16/4
 cld
;--
 rep movsd
                 mov eax,0
                 mov ax,[clientAddr2.sin_port]
                 xchg al,ah
                 mov dword[ressFPort],eax
                 invoke _itoa, [ressFPort], strPort2, 10
                                 invoke WaitForSingleObject, [hMutexXC], 10
                 stdcall strippWRK, strPort2
                 invoke ReleaseMutex, hMutexX
;--
cinvoke wsprintf, fmess, FnpU_ress, "keep channel", stringAddr2, strPort2
stdcall AddDebugMessage, fmess
@@:
.endif
.if [last_rpack_time]=0 
        cmp dword[fbuffer], 'g14:'
        jne @f
;--
cinvoke wsprintf, fmess, FnpU_ress, "Ping", stringAddr2, strPort2
stdcall AddDebugMessage, fmess
@@:
.endif
.if [last_rpack_time]=0
.if dword[fbuffer]='264:'
xor ebx, ebx
xor edx, edx
xor ecx, ecx
xor esi, esi
xor edi, edi
invoke WaitForSingleObject, [hMutexX], 1
mov [startKeep], 0  
invoke ReleaseMutex, hMutexX
mov [szFileNameSize],0
mov [rsOffSet],0     
mov [last_OffSet],-1 
mov dword[curFSymbol], 0
stdcall sFStore, session_id
stdcall sFStore, FNSizeString
invoke atoi, FNSizeString           
mov [szFileNameSize], eax
mov [BaseFileSize], eax
stdcall sFStore, szFileName
mov dword[curFSymbol], 0 
invoke RtlZeroMemory, FNSizeString, 32
invoke WaitForSingleObject, [hMutexXD], 1
mov [transfer],1 
invoke ReleaseMutex, hMutexXD
;--
mov eax, [alltick]
invoke WaitForSingleObject, [hMutexXD], 1
mov [last_rpack_time],eax 
invoke ReleaseMutex, hMutexXD
jmp receiver_thread2.iter
.endif
.endif
.if [last_rpack_time]=0
.if dword[fbuffer]='124:'  
stdcall sFStore, session_id
stdcall sFStore, FNSizeString
mov dword[curFSymbol], 0 
invoke atoi, FNSizeString
cmp eax, [szFileNameSize]
jz ._ok
    invoke MessageBox, 0, "Ошибка сравнения", " Несовпадение 124:szFileNameSize", MB_OK
    jmp MainLoop.restart
._ok:
invoke RtlZeroMemory, FNSizeString, 32
invoke WaitForSingleObject, [hMutexXD], 1
mov [transfer],  2 
invoke ReleaseMutex, hMutexXD
jmp receiver_thread2.iter
.endif
.endif
receiver_thread2.badpacket:
receiver_thread2.iter:
invoke RtlZeroMemory, rsOffSetA, 32 
receiver_thread2.skipmode:
invoke WaitForSingleObject, [hMutexXE], 1
mov [complete], 1 
invoke ReleaseMutex, hMutexXE
       jmp receiver_thread2.thread_loop
    receiver_thread2.no_data: 
        jmp receiver_thread2.thread_loop
    receiver_thread2.thread_exit:
        invoke Sleep, 500
        invoke ExitThread, 0
receiver_thread2.ProgressBarR:
cmp [Countpack], 0
je .complet
mov ebx, [Peaces]
sub [Progress],ebx
dec [Countpack]
.if [last_rpack_time]<>0  
;--
mov eax, [alltick]
mov ebx, eax
sub eax, [last_update]
cmp eax, 100              
jl .complet
mov [last_update], ebx
mov [refreshB], 1
.endif
.complet:
jmp receiver_thread2.flow02
   ret
endp
;--
proc ProgBarS
cmp [Countpack], 0
je .comples
mov ebx, [Peaces]
sub [Progress],ebx
dec [Countpack]
.if [last_spack_time]<>0  
;--
mov eax, [alltick]
mov ebx, eax
sub eax, [last_update]
cmp eax, 100              
jl .comples
mov [last_update], ebx
mov [refreshB], 1
.endif
.comples:
ret
endp
;--
proc sFStore field
mov esi, fbuffer
mov edi, [field]
add esi, 4 
add esi, dword[curFSymbol]
cld  
@@:
inc dword[curFSymbol]
   lodsb
   lea ebx, [esi-1]
   cmp dword[ebx],'яяяя'
   je  .key
   stosb
cmp dword[fbuffer],'114:'
je @b
cmp dword[fbuffer],'268:'
je @b
cmp dword[fbuffer],'568:'
je @b
   cmp dword[esi], 0x00000000
   je @f
   jmp @b
.key:
add [curFSymbol],3
 @@:
ret
endp
;--
proc fstoreADR 

                        mov eax,0
                    mov ax, [clientAddr2.sin_port]
                        xchg al,ah
                    mov dword[ressFPort], eax
;--
                        invoke _itoa, [ressFPort], strPort2, 10      
 mov esi, stringAddr
 mov edi, stringAddr2
 mov ecx, 16/4
 cld
;--
 rep movsd
ret
endp
;--
proc GetWindowPosition
invoke GetWindowRect, [hwnddlg], myRect
mov eax, [myRect.left]
mov [windowX], eax
mov eax, [myRect.top]
mov [windowY], eax
ret
endp
proc loadset
invoke EnterCriticalSection, addr csCritical
pusha
    invoke GetPrivateProfileStringA, sec_name, _license_key, 0, license_buffer, 20, ini_file_path
    invoke GetPrivateProfileStringA, sec_name, _FirstRun, 0, firstchk, 4, ini_file_path
    invoke GetPrivateProfileStringA, sec_name, _ipstart, start_ip, ip_start, 16, ini_file_path
    invoke GetPrivateProfileStringA, sec_name, _ip_Server, server_ip, ip_server, 15, ini_file_path
        invoke GetPrivateProfileStringA, sec_name, _Name1, 0, my_nick_buffer, 32, ini_file_path
        invoke GetPrivateProfileStringA, sec_name, _Name2, 0, target_nick_buffer, 32, ini_file_path 
    invoke GetPrivateProfileIntA, sec_name, _window_posX, [windowX], ini_file_path
        mov [windowX], eax
    invoke GetPrivateProfileIntA, sec_name, _window_posY, [windowY], ini_file_path
    mov [windowY], eax   
	invoke GetPrivateProfileIntA, sec_name, _portstart, [start_port], ini_file_path
    mov [portstart_value], eax
    invoke GetPrivateProfileIntA, sec_name, _portS, [server_port], ini_file_path
        mov [portserver_value], eax
    invoke GetPrivateProfileIntA, sec_name, _Fportstart, [Fstart_port], ini_file_path
    mov [Fportstart_value], eax
    invoke GetPrivateProfileIntA, sec_name, _FportS, [Fserver_port], ini_file_path
        mov [Fportserver_value], eax
popa
invoke LeaveCriticalSection, addr csCritical
ret
endp
proc saveset hwnddlg
invoke EnterCriticalSection, addr csCritical
pusha  
        invoke WritePrivateProfileString, sec_name, _FirstRun, firstchk, ini_file_path       
        invoke WritePrivateProfileString, sec_name, _Name1, Name1_SAVE, ini_file_path
        invoke WritePrivateProfileString, sec_name, _Name2, Name2_SAVE, ini_file_path
popa
invoke LeaveCriticalSection, addr csCritical
ret
endp
proc GetIniFilePath
invoke EnterCriticalSection, addr csCritical
pusha
    invoke GetModuleHandle, 0   
    invoke GetModuleFileNameA, eax, ini_file_path, 260   
    mov edi, ini_file_path + 260
    mov ecx, 260
    mov al, '\'
    std
    repne scasb
    cld   
    mov esi, ini_file_name
    lea edi, [edi+2]   
  @@:
        lodsb
        stosb
        test al, al
        jnz @b
mov byte[edi],0
popa
invoke LeaveCriticalSection, addr csCritical
    ret
endp
proc clPathFileName
invoke EnterCriticalSection, addr csCritical
pusha
	mov edi, szFileName + 260
    mov ecx, 260
    mov al, '\'
    std
    repne scasb
    cld   
    mov esi, szFileName
	lea edi, [edi+2]   
	xchg esi, edi
  @@:
        lodsb
        stosb
        test al, al
        jnz @b
mov byte[edi],0
popa
invoke LeaveCriticalSection, addr csCritical
ret
endp
proc init_bar
invoke EnterCriticalSection, addr csCritical
pusha
mov [Progress],65535 
mov [Countpack],0
mov [Peaces],0
mov eax, [szFileNameSize] 
cmp eax, UbuffSize
jna .low
mov ebx, eax
shr eax, 14
and ebx, 3
cmp ebx, 0
jz @f
.low:
inc eax           
@@:
mov [Countpack], eax      
mov eax, 65535
mov ebx, [Countpack]
xor edx, edx
div ebx           
cmp edx, 1
jbe @f
inc eax           
@@:
mov [Peaces],eax  
popa
invoke LeaveCriticalSection, addr csCritical
ret
endp
choosef: 
    mov [ofn.lStructSize], sizeof.OPENFILENAME
    mov [ofn.lpstrFile], szFileName
    mov [ofn.nMaxFile], 260
    mov [ofn.Flags], OFN_PATHMUSTEXIST or OFN_FILEMUSTEXIST
    mov [ofn.lpstrTitle], szTitle               
mov eax,0
mov byte [szFileName], 0
    invoke GetOpenFileName, ofn
	cmp byte [szFileName], 0
        jnz @f

		jmp DialogProc.continueEr
@@:    
    test eax, eax                    
    jnz @f
    jmp DialogProc.continueEr
@@:    
choosef.ole_case:    
    invoke CreateFile, szFileName, GENERIC_READ, FILE_SHARE_READ, 0, OPEN_EXISTING, FILE_ATTRIBUTE_NORMAL, 0
    cmp eax, INVALID_HANDLE_VALUE    
    je .err
    mov [hlFile], eax                    
    invoke GetFileSize, [hlFile], 0
     mov [szFileNameSize], eax
	 mov [BaseFileSize], eax
     cmp eax, 0
     jnz @f
     mov [Restart], 1
    jmp DialogProc.continueEr	
@@:
     add eax, UbuffSize * 2   
    invoke LocalAlloc, LPTR, eax
    mov [LPTR_lfile], eax
    test eax, eax
    jz .close_error   
mov [total_read], 0
mov [bytes_read], 0
mov eax, [szFileNameSize]
mov [bytes_to_read], eax
mov ebx, [LPTR_lfile]
.read_loop:
invoke ReadFile, [hlFile], ebx, [bytes_to_read], bytes_read, 0
test eax, eax
jz .close_error 
mov eax, [bytes_read]
add [total_read], eax
mov eax, [total_read]
cmp eax, [szFileNameSize]
jge .reading_done
add ebx, [bytes_read]
mov eax, [bytes_read]
sub [bytes_to_read], eax
jmp .read_loop

.reading_done:  
    jmp .next

        .close_error:
    invoke LocalFree, [LPTR_lfile]
	invoke Sleep, 100
    mov [LPTR_lfile],0
    xor eax, eax
    
    invoke CloseHandle, [hlFile]
    mov [hlFile],0
.err:
    
.exit:
    
    mov [Restart], 1
    jmp DialogProc.continueL
	
.next:
.close_file:
    invoke CloseHandle, [hlFile] 

call clPathFileName
invoke WaitForSingleObject, [hMutexXD], 1
mov [szOffSet],0
mov [flow_file],0
mov [transfer],0                
mov [sendsize],1 
invoke ReleaseMutex, hMutexXD
stdcall init_bar
jmp DialogProc.continueL
choosefS:
    mov [ofn.lStructSize], sizeof.OPENFILENAME
    mov [ofn.lpstrFile], szFileName
    mov [ofn.nMaxFile], 260
    mov [ofn.Flags], OFN_PATHMUSTEXIST or OFN_OVERWRITEPROMPT
    mov [ofn.lpstrTitle], szTitleS               
    mov eax,0    
    invoke GetSaveFileName, ofn
    test eax, eax                    
        jz .Sexit
cmp byte [szFileName], 0
        jz .Sexit
    invoke CreateFile, szFileName, GENERIC_WRITE, 0, 0, CREATE_ALWAYS, FILE_ATTRIBUTE_NORMAL, 0
    cmp eax, INVALID_HANDLE_VALUE    
    jz .Snext
    mov [hFileS], eax                 
   
invoke EnterCriticalSection, addr csCritical
pusha
    mov esi, [LPTR_storeF]
    mov ebx, [szFileNameSize]
    .write_loop:
    cmp ebx,0
    je .Sclose_file
    
    invoke WriteFile, [hFileS], esi, ebx, bytesWritten, 0
    
    cmp [bytesWritten],0
    jz .Sclose_file
    add esi, [bytesWritten]
    sub ebx, [bytesWritten]
    jnz .write_loop
    test eax, eax                    
    jz .Sclose_error
.Sclose_file:
    
    invoke CloseHandle, [hFileS]
    mov [hFileS], 0

	cmp [LPTR_storeF],0      
jz @f

invoke Free,[hHeap],0,[LPTR_storeF]
invoke Sleep, 100
    mov [LPTR_storeF],0  
@@:
popa
invoke LeaveCriticalSection, addr csCritical
                cinvoke wsprintf, fmess, filerecv, szFileName
                    stdcall AddDebugMessage, fmess              
    jmp .Snext
   .Sclose_error:
popa
invoke LeaveCriticalSection, addr csCritical
   .Serror:
    invoke CloseHandle, [hFileS]
    mov [hFileS], 0

	cmp [LPTR_storeF],0      
jz @f
invoke Free,[hHeap],0,[LPTR_storeF]
invoke Sleep, 100
    mov [LPTR_storeF],0  
@@:
.Sexit:   
.Snext:
invoke Sleep, 100

mov [Restart],1
jmp MainLoop.continueS

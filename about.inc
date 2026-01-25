section '.code' code readable executable
proc About_ShowDialog hInstance
    cmp [About_classRegistered], 0
    jne .class_registered
    invoke LoadIcon,0,IDI_APPLICATION
    mov [About_wc.hIcon],eax
    invoke LoadCursor,0,IDC_ARROW
    mov [About_wc.hCursor],eax
    mov [About_wc.style], CS_HREDRAW + CS_VREDRAW
    mov [About_wc.lpfnWndProc], About_WindowProc
    mov [About_wc.cbClsExtra], 0
    mov [About_wc.cbWndExtra], 0
    mov eax, [hInstance]
    mov [About_wc.hInstance], eax
    mov [About_wc.hbrBackground], COLOR_BTNFACE + 1
    mov [About_wc.lpszMenuName], 0
    mov [About_wc.lpszClassName], About_className
    invoke RegisterClass,About_wc
    test eax,eax
    jz .error
    mov [About_classRegistered], 1
.class_registered:
    invoke CreateWindowEx,0,About_className,About_dialogTitle,WS_OVERLAPPED or WS_CAPTION or WS_SYSMENU or WS_MINIMIZEBOX,\
                         100,100,800,570,NULL,NULL,[hInstance],NULL
    mov [haDialog],eax
    test eax,eax
    jz .error
    invoke CreateWindowEx,WS_EX_CLIENTEDGE,About_editClass,About_sampleText,\
                         WS_VISIBLE+WS_CHILD+ES_MULTILINE+ES_READONLY,\
                         300,20,470,500,[haDialog],2,[hInstance],NULL
    mov [hEdit],eax
    invoke CreateWindowEx,0,About_buttonClass,About_okText,WS_VISIBLE+WS_CHILD+BS_DEFPUSHBUTTON,\
                         25,400,250,30,[haDialog],1,[hInstance],NULL
    stdcall LoadEmbeddedBMP
    test eax, eax
    jz .error
    invoke GetStockObject,NULL_BRUSH
    mov [hNullBrush],eax
    invoke ShowWindow,[haDialog],SW_SHOW
    invoke UpdateWindow,[haDialog]
    .msg_loop:
        invoke GetMessage,About_msg,0,0,0
        cmp eax,0
        jle .exit_loop
        invoke TranslateMessage,About_msg
        invoke DispatchMessage,About_msg
        jmp .msg_loop
    .exit_loop:
    cmp [hImage],0
    je .no_delete
    invoke DeleteObject,[hImage]
    .no_delete:
    mov eax, [About_msg.wParam] 
    ret
.error:
    xor eax, eax
    ret
endp
proc LoadEmbeddedBMP
    mov esi, bmp_data
    cmp word [esi], 'BM'
    jne .error
    invoke GetDC, 0
    mov [hScreenDC], eax
    invoke CreateDIBSection, [hScreenDC], bmp_data+14, DIB_RGB_COLORS, pBits, 0, 0
    mov [hImage], eax
    test eax, eax
    jz .error_dc
    mov esi, bmp_data+54 
    mov edi, [pBits]      
    mov ecx, 256*256   
.convert_loop:
    mov al, [esi+2]
    mov bl, [esi+1]
    mov dl, [esi+0]
    mov [edi+2], al
    mov [edi+1], bl
    mov [edi+0], dl
    add esi, 3
    add edi, 3
    loop .convert_loop
    invoke ReleaseDC, 0, [hScreenDC]
    mov eax, 1 
    ret
.error_dc:
    invoke ReleaseDC, 0, [hScreenDC]
.error:
    xor eax, eax 
    ret
endp
proc About_WindowProc hwnda,uMsg,wParam,lParam
    cmp [uMsg],WM_CREATE
    je .wm_create
    cmp [uMsg],WM_PAINT
    je .wm_paint
    cmp [uMsg],WM_COMMAND
    je .wm_command
    cmp [uMsg],WM_DESTROY
    je .wm_destroy
    jmp .defwndproc
.wm_create:
    jmp .finish
.wm_paint:
    invoke BeginPaint,[hwnda],About_ps
    invoke CreatePen,PS_SOLID,1,000000h
    mov [hPen],eax
    invoke SelectObject,[About_ps.hdc],[hPen]
    invoke SelectObject,[About_ps.hdc],[hNullBrush]
    invoke Rectangle,[About_ps.hdc],20,20,276,276
	cmp [hImage],0
    je .no_image
    invoke CreateCompatibleDC,[About_ps.hdc]
    mov [hMemDC],eax
    invoke SelectObject,[hMemDC],[hImage]
    invoke BitBlt,[About_ps.hdc],21,21,255,255,[hMemDC],0,0,SRCCOPY
    invoke DeleteDC,[hMemDC]
.no_image:
    invoke SetBkMode,[About_ps.hdc],TRANSPARENT
    invoke TextOut,[About_ps.hdc],50,285,About_bmpCaption,About_bmpCaption_len
    invoke DeleteObject,[hPen]
    invoke EndPaint,[hwnda],About_ps
    jmp .finish
.wm_command:
    mov eax,[wParam]
    cmp ax,1  
    jne .finish
    invoke DestroyWindow,[hwnda]
    jmp .finish
.wm_destroy:
    invoke PostQuitMessage,0
    jmp .finish
.defwndproc:
    invoke DefWindowProc,[hwnda],[uMsg],[wParam],[lParam]
    ret
.finish:
    xor eax,eax
    ret
endp
section '.wc' data readable writeable
    About_wc WNDCLASS
section '.msg' data readable writeable
    About_msg MSG
section '.ps' data readable writeable
    About_ps PAINTSTRUCT



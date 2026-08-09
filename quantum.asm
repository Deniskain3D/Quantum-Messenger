			call GetModuleHandle,0
			mov [hInstance],eax        
		stdcall jh987
		stdcall gr65
		pusha
		 mov esi,  default_
		 mov edi,  _fgw33qs4
		 mov ecx, 19
		 cld
		 rep cmpsb
		 jne @f
		 jmp .pass
		 @@:
		 stdcall [MessageBox],0, "  Err",gdbn_2sst,MB_OK
		 call ExitProcess,0
		.pass:
		;--
			call DialogBoxParam,[hInstance],38,HWND_DESKTOP,tmp_257c,0 
			call ExitProcess,0 
		;--
		proc tmp_257c ws01_4, msg, wparam, lparam  
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
			je tmp_257c.wmclose
			cmp [msg], WM_APP_UPDATE
			je .wmappupdate
			cmp byte[k26], 1      
			je .wmdo_task
			cmp byte[snc256s], 2      
			je  tmp_257c.wmdo_task
			xor eax, eax
			jmp tmp_257c.finish
		;--
		tmp_257c.wm_dropfiles:
			mov ebx,[wparam]
			call DragQueryFile,ebx,-1,0,0
			test eax,eax
			jz tmp_257c.drop_done
			call DragQueryFile,ebx,0,szFileName,260
			test eax,eax
			jz tmp_257c.drop_done
			ccall wsprintf,786kgh,szDropMessage, szFileName
			call SendMessage,[hTEdit],EM_REPLACESEL,0,786kgh
		;--
		tmp_257c.drop_done:
			call DragFinish,ebx
			mov eax,0
		jmp gh450.ole_case
			jmp tmp_257c.processed
		;--
		tmp_257c.wmmove:
			stdcall yrw4
			jmp tmp_257c.processed
		;--
		tmp_257c.wmmeasureitem:
		mov esi, [lparam]  
			mov dword [esi + MEASUREITEMSTRUCT.itemHeight], 20
		jmp tmp_257c.processed
		;--
		tmp_257c.wmdrawitem:
			mov esi,[lparam]   
			mov eax,[esi+DRAWITEMSTRUCT.CtlID] 
			cmp eaxfsrLISTBOX
			jne .defaultdraw
			mov ebx,[esi+DRAWITEMSTRUCT.itemID] 
			cmp ebx,0FFFFFFFFh
			je .defaultdraw
			cmp ebx,[itemCount]
			jae .defaultdraw
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
			call SetTextColor,dword[esi+DRAWITEMSTRUCT.hDC],eax 
			call SetBkColor,dword[esi+DRAWITEMSTRUCT.hDC],00FFFFFFh 
			call SetBkMode,dword[esi+DRAWITEMSTRUCT.hDC],OPAQUE 
			lea edx,[esi+DRAWITEMSTRUCT.rcItem] 
			call FillRect,dword[esi+DRAWITEMSTRUCT.hDC],edx,00FFFFFFh   
			mov eax,[esi+DRAWITEMSTRUCT.itemState] 
			test eax,ODS_SELECTED
			jz .drawingt
			call SetTextColor,dword[esi+DRAWITEMSTRUCT.hDC],00FFFFFFh 
			call SetBkColor,dword[esi+DRAWITEMSTRUCT.hDC],00C04000h 
			lea edx,[esi+DRAWITEMSTRUCT.rcItem] 
		.fill_background:  
			lea eax, [esi+DRAWITEMSTRUCT.rcItem]
			call ExtTextOut,dword[esi+DRAWITEMSTRUCT.hDC], edx,00C04000h, ETO_OPAQUE, eax, 0, 0, 0
		.drawingt:  
			mov eax,[edi] 
			test eax,eax  
			jz .drawcomp
			lea edx,[esi+DRAWITEMSTRUCT.rcItem] 
			call DrawText,dword[esi+DRAWITEMSTRUCT.hDC],dword[edi],-1,edx,DT_LEFT or DT_VCENTER or DT_SINGLELINE
			mov eax,[esi+DRAWITEMSTRUCT.itemState] 
			test eax,ODS_SELECTED
			jz .drawcomp
		lea edx,[esi+DRAWITEMSTRUCT.rcItem] 
		call DrawFocusRect,dword[esi+DRAWITEMSTRUCT.hDC],edx
		.drawcomp:
		mov [dizzy],1
			jmp tmp_257c.processed
		.skip_update:
		.defaultdraw:
			xor eax,eax
			jmp tmp_257c.finish
		tmp_257c.wminitdialog:
		.if [firstchk]='1'
		call yyjk_43
		cmp eax,fsrCANCEL
		je tmp_257c.wmclose
		mov [firstchk], '0'
		.endif
		call SetWindowPos,[ws01_4],0,[windowX],[windowY],0,0,SWP_NOSIZE or SWP_NOZORDER
				call GetDlgItem,[ws01_4]fsrPROGRESS
				mov [hProgress],eax		
			mov eax, [ws01_4]
			mov [hDialog], eax
			mov [ws02_4], eax
			call GetDlgItem, [ws01_4],fsrLISTBOX 
			mov [hListBox], eax
			call GetDlgItem,[ws01_4]fsrMessage
			mov [hTEdit],eax 
			call DragAcceptFiles,[ws01_4],TRUE
		   mov byte[snc256s],  3 
		   mov byte[svm23p], 1
		   mov byte[svmg16_8],  1 
		   mov [startKeep],   1
			call CheckDlgButton, [ws01_4],fsrCHECKBOX, BST_UNCHECKED
			call SendDlgItemMessage, [ws01_4],fsrPT45, EM_LIMITTEXT, 5, 0
			call SendDlgItemMessage, [ws01_4],fsrIS, EM_LIMITTEXT, 15, 0
			call SetDlgItemInt, [ws01_4],fsrPT45, [hpoin90], FALSE
		call GetDlgItemText, [ws01_4],fsrPT45, fgw33qs43, 5 
				stdcall yrdhw3, fgw33qs43
			call SetDlgItemText, [ws01_4],fsrIS, long_s 
			call SetDlgItemText, [ws01_4],fsrU, ni__fgw33qs4
			call SetDlgItemText, [ws01_4],fsrUT, tn__nick_fgw33qs4
				call GetDlgItemText, [ws01_4],fsrU, Name1_SAVE, 32
				call GetDlgItemText, [ws01_4],fsrUT, Name2_SAVE, 32
				call SendMessage,[hProgress],PBM_SETRANGE,0,65535 shl 16
				call SendMessage,[hProgress],PBM_SETPOS,[tmpd4_2],0
			call GetDlgItemText, [ws01_4],fsrIS, _str64, 16      
				call CreateDialogParam, [hInstance], 38, 0, rtd156, 0
			mov [hDebugWnd], eax       
			jmp tmp_257c.processed
		tmp_257c.wmappupdate:
			jmp tmp_257c.processed
		;--
		tmp_257c.wmcommand:
			cmp [wparam], BN_CLICKED shl 16 + IDOK
				jne @f
				mov byte[svmg16_8], 1 
				mov byte[snc256s], 0                      
				mov byte[k26], 0                            
		 jmp tmp_257c.button
				@@:
		   cmp [wparam], BN_CLICKED shl 16 +fsrFILE
		   jne @f
				jmp gh450
		tmp_257c.continueL:		
				ccall wsprintf, 786kgh, filesend, szFileName
				stdcall ert084, 786kgh
						mov byte[svmg16_8], 0 
						mov    [svm23p], 0            
						mov byte[k26], 1        
		tmp_257c.continueEr:
				@@:
			cmp  [wparam],BN_CLICKED shl 16 +fsrABOUT
			jne @f
				stdcall gdrrtn5y5, [ws01_4], testText, 00C04000h 
				stdcall ert084, testText
						jmp tmp_257c.about
			@@:
				cmp [wparam], BN_CLICKED shl 16 +fsrSN         
				jne @f
				mov byte[svmg16_8], 1  
				mov [svm23p],    1
				mov byte[snc256s], 1  
				mov byte[k26], 0
				mov [startKeep],  0  
				mov [Restart], 1   
				jmp tmp_257c.override    
				@@:
			mov eax, [wparam]
			cmp ax,fsrCHECKBOX
			jne @f
			shr eax, 16
			cmp ax, BN_CLICKED
			jne @f
			call IsDlgButtonChecked, [ws01_4],fsrCHECKBOX
			cmp eax, BST_CHECKED
			jne .uncheck
			call SetWindowPos, [ws01_4], HWND_TOPMOST, 0,0,0,0, SWP_NOMOVE+SWP_NOSIZE
			jmp @f
		.uncheck:
			call SetWindowPos, [ws01_4], HWND_NOTOPMOST, 0,0,0,0, SWP_NOMOVE+SWP_NOSIZE
		@@:
			jmp tmp_257c.processed
		;--
		tmp_257c.wmdo_task: 
			cmp byte[snc256s], 2           
			   je @f
			cmp byte[snc256s], 0 
			   je tmp_257c.send_Message
			cmp byte[snc256s], 3             
			   je tmp_257c.send_Message
		   jmp tmp_257c.processed
		@@:
		mov byte[k26], 0
		jmp tmp_257c.send_Message
		   jmp tmp_257c.processed     
		tmp_257c.about:
		stdcall About_ShowDialog, [hInstance]
			jmp tmp_257c.processed           
		tmp_257c.button: 
		@@:                         
		cmp [comp], 0
		jne @f    
		call Sleep, 0.1
		jmp @b    
		@@:
		.if [svm23p]=0            
		tmp_257c.override: 
		mov [comp],0 
		 mov ecx, sizeof.all_nick_fgw33qs4
		 mov edi, ni__fgw33qs4
		 mov eax, 0
		 rep stosb                    
			call GetDlgItemText, [ws01_4],fsrU, ni__fgw33qs4, 32
			stdcall yrdhw3, ni__fgw33qs4
			call GetDlgItemText, [ws01_4],fsrUT, tn__nick_fgw33qs4, 32
			stdcall yrdhw3, tn__nick_fgw33qs4
		mov [comp],1 
		.endif
		;--
		tmp_257c.send_Message:
		@@:                         
		cmp [comp], 0
		jne @f    
		call Sleep, 0.1
		jmp @b    
		@@:
		mov [comp],0 
			cmp [hSocket], INVALID_SOCKET
			jne @f
			ccall wsprintf, 786kgh, buzzy
			stdcall gdrrtn5y5, [ws01_4], 786kgh, MSG_TYPE_ERROR
		jmp .endsend
		@@:
		cmp byte[k26],1 
		je @f
		.if byte[snc256s]=2
		mov byte[k26],0  
		.endif
				call GetDlgItemText, [ws01_4],fsrU, Name1_SAVE, 32
				call GetDlgItemText, [ws01_4],fsrUT, Name2_SAVE, 32
				call GetDlgItemText, [ws01_4],fsrIS, long_s, 15
				call GetDlgItemText, [ws01_4],fsrPT45, fgw33qs43, 5
				stdcall yrdhw3, fgw33qs43
		call GetDlgItemText, [ws01_4],fsrIS, _str64, 16
		 stdcall yrdhw3, _str64
			call GetDlgItemInt, [ws01_4],fsrPT45, 0, FALSE 
		mov [p32n],eax 
		@@:
		.if byte[k26]<>1 
				call GetDlgItemText, [ws01_4],fsrMessage, cons23, 1024
			stdcall yrdhw4, cons23
		.endif  
		.if byte [k26]=0
			.if byte[snc256s]<>2 
				mov [clientAddr.sin_family], AF_INET
			
		;--
				mov eax, [p32n]
				xchg al, ah
				.if ax=0
					mov ax, word[hpoin90] 
					xchg al, ah
				.endif
		;--
				mov [clientAddr.sin_port], ax
				
			call GetDlgItemText, [ws01_4],fsrIS, _str64, 16
			 stdcall yrdhw3, _str64 
		;--
			call inet_addr, _str64
		;--
				mov [clientAddr.sin_addr], eax
				mov dword [clientAddr.sin_zero], 0
				mov dword [clientAddr.sin_zero+4], 0
			
			.endif
		.yt6y76e:
		.if byte[snc256s]=1      
		stdcall yt6y76, [ws01_4]
		.endif
		.if byte[snc256s]=2
			ccall wsprintf, cons23, png_msg, _str64, _str64p 
			mov [savereg3], eax
			mov [height], eax
			
			@@:
		.endif
		.if byte[snc256s]=0
		mov edx,0
		mov esi, cons23
		mov edi, fgw33uqs4  
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
			.if byte[snc256s]=0  
			.if byte[svmg16_8]=1  
		;--
			  call MultiByteToWideChar, CP_ACP, 0, fgw33uqs4, -1, fgw3uqs4, 1024
		;--
			  call WideCharToMultiByte, CP_UTF8, 0, fgw3uqs4, -1, fgw33uqs4, 2048, 0, 0
		;--
			  ccall wsprintf, cons23, str_msg, fgw33uqs4 
			  mov edx, eax
			  mov [height], edx
			.endif
			.endif
		.endif
		.if byte[k26]=1         
		stdcall yt6y76, [ws01_4] 
		.endif 
		.if byte[snc256s]<>2 
				mov edx,[height]
				.if byte[k26]=1
				  mov edx,[heightk]
				.endif
							.if byte[svmg16_8]<>1 
							  jmp .woutf        
							.endif           
		;--
								   call sendto, [hSocket], cons23, edx, 0, clientAddr, SOCKADDR_SIZE
								   call Sleep, 15
								   mov [init_s2], 1
								   call Sleep, 15
									jmp .sk
		 

			.woutf:
			.if dword[cons23]<>'74jh'
				ccall wsprintf, fgw3uqs4, str_msg, fgw33uqs4 

				
		;--
				call sendto, [hSocket], fgw3uqs4, eax, 0, clientAddr, SOCKADDR_SIZE 
				
				jmp .sk
			.endif

			
		;--
			call sendto, [hSocket], cons23, eax, 0, clientAddr, SOCKADDR_SIZE 
			
			 call Sleep, 15
		;--
								   mov [init_s2], 1
								   call Sleep, 15
			.sk:
		.endif
		.if byte[snc256s]=2 
		mov [svm23p], 0   
		mov byte[k26],0 
			ccall wsprintf, 786kgh, chg_format, cons23, _str64, _str64p
			
				stdcall ert084, 786kgh
			mov ecx,6
			mov edx, [savereg3]
			.punch:
			
			mov [savereg2], ecx
		;--
						call sendto, [hSocket], cons23, edx, 0, clientAddr, SOCKADDR_SIZE
						call Sleep, 15
		;--
									mov [init_s2], 1
						call Sleep, 15
			mov ecx, [savereg2]
			dec ecx
				cmp ecx, 0
				jne .punch
				   mov [startKeep], 1  
				   mov [svm23p], 0  
				   
			jmp .skipping
		.endif
		.checkerr:
			cmp eax, SOCKET_ERROR
			.if eax<>SOCKET_ERROR
			jmp .success
				.endif
			call WSAGetLastError
			ccall wsprintf, 786kgh, errMsg, eax
			stdcall gdrrtn5y5, [ws01_4], 786kgh, MSG_TYPE_ERROR
			jmp .endsend
		.success:
		cmp byte[snc256s],3         
		je .skipping               
		cmp byte[k26],1         
		je .skipping            
			call GetDlgItemInt, [ws01_4],fsrPT45, 0, FALSE 
					mov [p32n], eax
		.if byte[snc256s]=1
				ccall wsprintf, 786kgh, msg_format, cons23, _str64, [p32n] 
				jmp @f  
		.endif
				call GetDlgItemText, [ws01_4],fsrMessage, cons23, 1024   
						stdcall yrdhw4, cons23
		stdcall itty_r5 
		movzx eax, word[sysTime.wMinute]
		movzx edx, word[sysTime.wHour]     
				ccall wsprintf, 786kgh, msg_simple, edx, eax, cons23 		
				call SetDlgItemText, [ws01_4],fsrMessage, 0, 1024 
		@@:
			   stdcall gdrrtn5y5, [ws01_4], 786kgh, MSG_TYPE_NORMAL   
		.skipping:
		.endsend:
		stdcall gdtn5     
		 .if dword[svm23p]=0
		   mov byte[snc256s], 3   
		   mov byte[svmg16_8], 1   
		   mov byte[k26], 0    
		   jmp @f
		 .endif
		mov byte[snc256s], 3  
		mov byte[svmg16_8], 1  
		mov byte[k26], 0   
		@@:
		mov [comp],1 
				jmp tmp_257c.processed
		tmp_257c.wmclose:
		wmclose:
		stdcall yr65
			mov [exitFlag2], 1
			call closesocket, [hSocket2]
			cmp [LPTR_storeF], 0
			jz @f
			mov [LPTR_storeF], 0
		@@:
			cmp [LPTR_lfile], 0
			jz @f
		call Sleep, 100
			mov [LPTR_lfile], 0
		@@:
			mov [exitFlag], 1
		tmp_257c.processed:
			mov eax, 1
			jmp @f
		tmp_257c.finish:
		mov eax, 0
		@@:
		   
		   ret
		endp
		;--
		proc ert064 ws01_4
		;--
			.thread_loop:
				cmp [exitFlag], 1
				je ert064.thread_exit
						mov [addrSize], SOCKADDR_SIZE
		;--
				call recvfrom, [hSocket], fgw33qs4, sizeof.fgw33qs4, 0, clientAddr, addrSize 

						cmp eax, SOCKET_ERROR
				jle .no_data
				
				mov byte [fgw33qs4 + eax], 0
						mov [savereg],eax             
		;--
		stdcall ad5_32




		;--
		call MultiByteToWideChar, CP_UTF8, 0, fgw33qs4, -1, tmp, 2048     
		;--
		call WideCharToMultiByte, CP_ACP, 0, tmp, -1, nt_mod8, 2048, 0, 0 

		@@:
		cmp [comp],0
		jne @f
		call Sleep, 1 
		jmp @b
		@@:


				cmp dword[nt_mod8], '344g56'           
				jne @f

				mov [startKeep],  0
				mov byte[k26], 0 
				mov [svm23p],    0    
				mov byte[svmg16_8], 0    




		mov eax, 0
		mov edi, tn__nick_fgw33qs4
		mov ecx, 32/4             
		rep stosd
		stdcall ryul_r5, tn__nick_fgw33qs4


		mov eax,0
		mov edi, _str64
		mov ecx,16/4
		cld
		rep stosd
		stdcall ryul_r5, _str64
		mov esi, _str64
		mov edi, _str642
		mov ecx,16/4
		cld
		;--
		 rep movsd                 

		mov eax,0
		mov edi, _str64p
		mov ecx,6
		cld
		rep stosb
		stdcall ryul_r5, _str64p

		mov eax,0
		mov edi, _str64p2
		mov ecx,6
		cld
		rep stosb
		stdcall ryul_r5, _str64p2
		mov [curSymbol],0              

		;--
						call atoi, _str64p2
							  xchg al,ah
		;--
							  mov [clientAddr2.sin_port], ax
												  xchg al,ah
		;--
						  and eax, 00000000000000001111111111111111b 
						  mov [rfp_32], eax




		call SetDlgItemText, [ws01_4],fsrIS, _str64
		call SetDlgItemText, [ws01_4],fsrPT45, _str64p

					   call inet_addr, _str64 
					   mov [clientAddr.sin_addr], eax 
					   mov [clientAddr2.sin_addr], eax 
					   
		call GetDlgItemInt, [ws01_4],fsrPT45, 0, FALSE 

						mov dword[ressPort],eax 
							  xchg al,ah
							  mov [clientAddr.sin_port], ax


		;--
		ccall wsprintf, income, peer_ress, nt_mod8, _str642, [rfp_32]

		stdcall ert084, income
				mov byte[snc256s], 2    
				mov [al24m],      0    

										jmp .after
		@@:

				cmp dword[nt_mod8], '53te'
				 jne @f
				
				   mov [svm23p], 1

				mov byte[snc256s], 3
				mov [startKeep],  1   
				mov byte[k26], 1

						jmp .fg549
		@@:     
				cmp dword[fgw33qs4], '023:' 
				jne @f
				mov byte[svmg16_8], 1   
				mov byte[snc256s], 3
				mov    [svm23p], 0   
					 mov [al24m], 0   
					   
										jmp .nt_mod9
		@@:     
				cmp dword[nt_mod8], 'MSG_'
				jne @f
				mov byte[snc256s], 3
				   mov [svm23p], 1
						   stdcall gdrrtn5y5, [ws01_4], nt_mod8, MSG_TYPE_SYSTEM  
						jmp .fg549
		@@:     
				cmp dword[nt_mod8], '4562'   
				jne @f                     
				mov byte[snc256s], 0
				   mov byte[svmg16_8], 1   
						jmp .fg549     
		@@:     
				cmp dword[nt_mod8], 'ERRO'
				jne @f
				mov byte[snc256s], 3
				   mov [svm23p], 1
						jmp .fg549
		@@:     
				cmp dword[nt_mod8], 'y5ur'
				jne @f
				mov byte[snc256s], 3
				   mov [svm23p], 1
						jmp .fg549
		@@:     
				cmp dword[nt_mod8], '74jh'
				jne @f
						mov byte[snc256s], 3
						
						mov byte[svmg16_8], 0  
						mov [svm23p], 0
		;--
									mov [init_s2], 1

						jmp .sk3_24notd
		@@:     
				cmp dword[nt_mod8], 'ew45'
				jne @f
				mov byte[snc256s], 3
				   mov [svm23p], 1
						jmp .fg549                           
		@@:     
				cmp dword[fgw33qs4], 'lrJ2' 
				jne @f
			   
					mov byte[snc256s], 3
				   mov [svm23p], 1    
								   

						jmp .sk3_24notd                            
		@@:
				cmp dword[fgw33qs4], 'g14:'   
				jne @f

			   mov byte[svmg16_8], 0   
			   mov byte[snc256s], 3   
			   mov    [svm23p], 0   

							jmp .sk3_24notd

		@@: 
		.nt_mod9:
			   mov byte[snc256s], 0 
			   cmp byte[svmg16_8], 1 
		je .fg549        
		jmp .over           
		.fg549:

						mov esi, nt_mod8
						mov edi, fgw33qs4                
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



		cmp dword[fgw33qs4],'4562' 
		je .over   

		.if byte[snc256s]=0
		.over:
		mov edx,0
		mov ecx, [savereg]   
		mov esi, fgw33qs4
		mov edi, fgw33qs4
		.if dword[fgw33qs4]='4562'
		add esi, 8 
		sub ecx, 8
		.endif
		.if dword[fgw33qs4]='74jh'
		add esi, 4 
		sub ecx, 4
		.endif
		.if dword[fgw33qs4]='023:'
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
		.sk3_24notd:                           
		stdcall itty_r5 
					  

		movzx eax, word[sysTime.wMinute]
		movzx edx, word[sysTime.wHour]
		.if [svm23p]=0
		;--
		ccall wsprintf, income, msg_simple, edx, eax, fgw33qs4 


		jmp @f
		.endif
		;--
		ccall wsprintf, income, msg2_ress, fgw33qs4, _str64, edx, eax
		@@:
		.if dword[nt_mod8]<>'023:'
		.if dword[nt_mod8]<>'4562'
		  stdcall ert084, income
		jmp @f
		.endif
		.endif
				stdcall gdrrtn5y5, [ws01_4], income, MSG_TYPE_USER1
		call InvalidateRect,[hListBox],0,TRUE  
		call UpdateWindow,[hListBox]
		@@:
		.if byte[snc256s]<>2 
		cmp dword[fgw33qs4], 'g14:'
		je .after
		;--
				call SetDlgItemInt, [ws01_4],fsrPT45, dword[ressPort], FALSE 
		;--
				call SetDlgItemText, [ws01_4],fsrIS, _str64 
		.endif
		.after:
		mov dword[nt_mod8],0000 
			stdcall clrfgw33qs4 
		.if [al24m]=0
			call IsIconic, [ws01_4]
			test eax, eax
			jz .not_minimized
			call ShowWindow, [ws01_4], SW_RESTORE
			call Sleep,10
			call ShowWindow, [ws01_4], SW_SHOW
			call MessageBeep, MB_OK
			call Sleep,10
		.not_minimized:
			call SetForegroundWindow, [ws01_4]
			call Sleep,10
			call MessageBeep, MB_ICONQUESTION
				mov [al24m], 1
		call Sleep, 15
		.endif
				jmp .thread_loop
			.no_data: 
				jmp .thread_loop
			ert064.thread_exit:
				call ExitThread, 0
				ret
		endp
		;--
		proc ad5_32
		 
			
								mov eax,0
		;--
								mov ax, [clientAddr.sin_port]
								xchg al,ah
		;--
								mov dword[ressPort], eax

		 
						mov eax, [clientAddr.sin_addr]
				call inet_ntoa, eax
						mov esi, eax
						mov edi, _str64
								mov ecx, 15
								cld
		;--
								rep movsb
				  ret
						
		endp
		;--
		proc rtd512 ws01_4
			call WSAStartup, 0x202, wsaData
			test eax, eax
			jz @f
			jmp .error
		@@:  
			stdcall ert084, wsaStartMsg
			call socket, AF_INET, SOCK_DGRAM, IPPROTO_UDP
			cmp eax, INVALID_SOCKET
			jne @f
			jmp .error
		@@:
			mov [hSocket], eax
			stdcall ert084, socketCreatedMsg
			call setsockopt, [hSocket], SOL_SOCKET, SO_REUSEADDR, [reuse], 4
			call setsockopt, [hSocket], SOL_SOCKET, SO_RCVTIMEO, TIMEOUT, 4
			call setsockopt, [hSocket], SOL_SOCKET, SO_SNDTIMEO, TIMEOUT, 4
			call ioctlsocket, [hSocket], FIONBIO, MODE
			mov [serverAddr.sin_family], AF_INET
			mov ax, word[portserver_value] 
			xchg al, ah
			mov [serverAddr.sin_port], ax
			mov [clientAddr.sin_addr], NULL  
			mov dword [serverAddr.sin_zero], 0
			mov dword [serverAddr.sin_zero+4], 0
			call bind, [hSocket], serverAddr, SOCKADDR_SIZE
			cmp eax, SOCKET_ERROR
			jne .create_thread
			call WSAGetLastError
			ccall wsprintf, 786kgh, bindErrorMsg, eax
			stdcall gdrrtn5y5, [ws01_4], 786kgh, MSG_TYPE_ERROR
			jmp .error
            .Crtd: db 'by @Quriositer 2026',0
		.create_thread:
			mov ax, [serverAddr.sin_port]
			rol ax,8
			ccall wsprintf, 786kgh, portMsg, eax
			stdcall ert084, 786kgh
			mov [hThread], eax
			call Sleep, 100
		.success:
		call Sleep, 100
		call SetThreadAffinityMask, [hThread], 2
			ccall wsprintf, 786kgh, initSuccessMsg
		stdcall gdrrtn5y5, [ws01_4], 786kgh, MSG_TYPE_SYSTEM
			jmp .exit
		.error:
			call WSACleanup
			mov [hSocket], INVALID_SOCKET
		.exit:
		ret
		endp
		;--
		proc rf5_32 hDialog
		.oborot:
				call Sleep, 100
				call GetTickCount
				
				cmp eax,0
				jne @f
				inc eax
				@@:
				mov [alltick], eax
				
				cmp [refreshB],1
				jne .oborot
				mov [refreshB], 0
				call PostMessage,[hProgress],PBM_SETPOS,[tmpd4_2],0
				
		   jmp .oborot
		ret
		endp
		;--
		proc tm_512 ws02_4         
			.looping:
				cmp [exitFlag], 1
				je .exit
		.if [startKeep]=1
			.if byte[svm23p]=0 
			stdcall uur56, [ws02_4]                  
		call Sleep, 30000
			.endif
			.if byte[snc256s]=3
			  .if [svm23p]=1
				mov byte[k26],1
				@@:
				cmp [comp],0
				jne @f
				call Sleep, 0.1 
				jmp @b
				@@:
				call PostMessage, [ws02_4], WM_NULL, 0, 0
		call Sleep, 30000
			 .endif
			.endif
		.endif
			jmp .looping
			   .exit:
			 ret
		endp
		;--
		proc uur56 ws02_4
		mov byte[svmg16_8], 0 

		   mov byte[k26],1
		@@:
		cmp [comp],0
		jne @f
		call Sleep, 0.1 
		jmp @b
		@@:
		 call PostMessage, [ws02_4], WM_NULL, 0, 0
		.nextmin:
			ret
		endp
		;--
		proc itty_r5

		 call GetLocalTime, sysTime  
		 ret
		endp
		;--
		proc ryul_r5 field
		mov esi, nt_mod8
		mov edi, [field]
		.if dword[nt_mod8]='344g56'
		add esi, 5 
		.endif
		.if dword[fgw33qs4]='g14:'
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
		proc yt6y76 ws01_4
			.if byte[snc256s]=1 
				call SetDlgItemInt, [ws01_4],fsrPT45, [hpoin90], FALSE 
				call SetDlgItemText, [ws01_4],fsrIS, hpoin89 
			 
						mov eax, 0 
						mov ecx, 16
						mov esi, hpoin89 
						mov edi, _str64
						cld
						repne movsb
						mov byte[edi],0
				call inet_addr, _str64
				mov [clientAddr.sin_addr], eax
				mov [clientAddr2.sin_addr], eax
						mov ax, word[hpoin90] 
						xchg al, ah
								mov [clientAddr.sin_port], ax
						mov ax, F_SERVER_PORT
						xchg al, ah
								mov [clientAddr2.sin_port], ax
				ccall wsprintf, cons23, str_nick, ni__fgw33qs4, tn__nick_fgw33qs4
				mov [height], eax  
				mov [init_s2], 1   
				jmp @f
			.endif
			.if byte[k26]=1
				ccall wsprintf, cons23, str_keep, ni__fgw33qs4, tn__nick_fgw33qs4
				mov [heightk], eax
			.endif
		@@:
				ret
		endp
		proc Hello
			   stdcall [MessageBox],0,Cont,About,MB_OK
			   ret
		endp
		proc yyjk_43
			   stdcall [MessageBox],0,EULAtxt,"Impotant Information",MB_OKCANCEL + MB_ICONINFORMATION
			   ret
		endp
		;--
		proc yrdhw4 string 

		@@:
		.if[dizzy]=0                              
		call Sleep, 0.1                         
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
		proc yrdhw3 string
		@@:
		.if[dizzy]=0                              
		call Sleep, 0.1                         
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
		proc gdtn5
		mov ebx, edi
		mov ecx, sizeof.input / 4
		mov edi, fgw3uqs4
		mov eax, 0
		rep stosd
		mov edi, ebx
		ret
		endp
		;--
		proc clrfgw33qs4
		mov ebx, edi
		mov ecx, sizeof.fgw33qs4s / 4
		mov edi, tmp
		mov eax, 0
		rep stosd
		mov edi, ebx
		ret
		endp
		;--
		proc gdrrtn5y5 ws01_4, pText, msgType

		@@:
		.if[dizzy]=0                         
		call Sleep, 1                         
		jmp @b
		.endif
		mov [dizzy],0                        
			local hListBox dd 0
			local textLength dd 0
			local index dd 0  
		;--
			call GetDlgItem, [ws01_4],fsrLISTBOX
			mov [hListBox], eax
			call lstrlen, [pText]
			mov [textLength], eax 
			cmp eax, MAX_LINE_LENGTH
			jle .add_as_is 
			mov esi, [pText]
			lea edi, [tempfgw33qs4]
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
			lea edx, [tempfgw33qs4]

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
			stdcall hgfk66gf, [ws01_4], addr tempfgw33qs4, [msgType]
			lea edi, [tempfgw33qs4]
			mov ecx, 0
			jmp .split_string
		.next_char:
			jmp .split_loop
		.add_last_line:
			mov byte[edi], 0
			stdcall hgfk66gf, [ws01_4], addr tempfgw33qs4, [msgType]
				jmp .done
		.add_as_is:
		;--
			stdcall hgfk66gf, [ws01_4], [pText], [msgType]
		.done:
		mov [dizzy],1 
			call InvalidateRect,edx,0,TRUE
			call UpdateWindow,edx
			mov eax, [itemCount]
			dec eax
			call SendMessage, [hListBox], LB_SETCURSEL, eax, 0
				ret
		endp
		;--
		proc hgfk66gf ws01_4, text, itemType    
			mov ebx, [itemCount]
			cmp ebx, MAX_ITEMS
			jl .count_ok
			xor eax,eax
			jmp .exit
		.count_ok:
			call lstrlen,[text] 
			inc eax               
			call LocalAlloc, LPTR, eax
			test eax, eax
			jz .error_alloc
			mov edi, eax    
			call lstrcpy, edi, [text] 
			mov ebx,[itemCount]
			mov edx,0
			imul ebx,sizeof.LIST_ITEM
			lea ecx,[listItems+ebx]
			mov [ecx],edi 
			mov eax,[itemType]        
			mov [ecx+LIST_ITEM.color],eax 
		inc dword [itemCount]  
			call GetDlgItem, [ws01_4],fsrLISTBOX
				mov edx, eax 
			call SendMessage,edx,LB_ADDSTRING,0, 0    
		jmp .exit
		.no_increment:
			jmp .exit
		.error_alloc:
			xor eax, eax
		.exit:
			ret
		endp
		;--
		proc rtd156 hDebugWnd,dmsg,dwparam,dlparam
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
			call GetDlgItem, [hDebugWnd],fsrDEBUG_LISTBOX
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
			call SetWindowPos, esi, 0, 5, 5, ecx, ebx, SWP_NOZORDER   
		.wm_size_done:
			mov eax, 0
			ret
		.wmcommand:
			mov eax,1
			ret
		rtd156.wmclose:
			call DestroyWindow,[hDebugWnd]
			mov [hDebugWnd],0
			mov eax,1
			ret
		endp
		;--
		proc ert084 dmsg
			cmp [hDebugWnd], 0
			je .exit
			call GetDlgItem, [hDebugWnd],fsrDEBUG_LISTBOX
			mov ebx, eax
			call SendMessage, ebx, LB_ADDSTRING, 0, [dmsg]
			call SendMessage, ebx, LB_GETCOUNT, 0, 0
			dec eax   
			call SendMessage, ebx, LB_SETTOPINDEX, eax, 0
		.exit:
			ret
		endp
		;--
		proc br4_16
				call CreateSolidBrush,00000000h  
			mov [hBlackBrush],eax
			call CreateSolidBrush,00008000h  
			mov [hGreenBrush],eax
			call CreateSolidBrush,000000FFh 
			mov [hErrorBrush], eax
				call CreateSolidBrush,00800000h  
			mov [hBlueBrush],eax
				call CreateSolidBrush,00FFFFFFh 
			mov [hWhiteBrush], eax
			call CreateSolidBrush,00F0F0F0h 
			mov [hGrayBrush], eax
			call CreateSolidBrush,00C04000h 
			mov [hHighlightBrush], eax
			ret
		endp
		;--
		proc n543_s
		.Init_block:
		call socket, AF_INET, SOCK_DGRAM, IPPROTO_UDP
		mov [hSocket2], eax
		call setsockopt, [hSocket2], SOL_SOCKET, SO_REUSEADDR, [reuse], 4
		call setsockopt, [hSocket2], SOL_SOCKET, SO_RCVBUF, [InbuffSize], 4
		call setsockopt, [hSocket2], SOL_SOCKET, SO_SNDBUF, [InbuffSize], 4				   
		call setsockopt, [hSocket2], SOL_SOCKET, SO_RCVTIMEO, TIMEOUT, 4
		call setsockopt, [hSocket2], SOL_SOCKET, SO_SNDTIMEO, TIMEOUT, 4
		call ioctlsocket, [hSocket2], FIONBIO, MODE
			mov [clientAddr2.sin_family], AF_INET
			mov ax, word[Fportstart_value] 
			xchg al, ah
			mov [clientAddr2.sin_port], ax
			mov [clientAddr2.sin_addr], NULL 
			mov dword [clientAddr2.sin_zero], 0
			mov dword [clientAddr2.sin_zero+4], 0
			mov [serverAddr2.sin_family], AF_INET
			mov ax, word[cons23f] 
			xchg al, ah
			mov [serverAddr2.sin_port], ax
			mov [serverAddr2.sin_addr], NULL 
			mov dword [serverAddr2.sin_zero], 0
			mov dword [serverAddr2.sin_zero+4], 0
				call bind, [hSocket2], serverAddr2, SOCKADDR_SIZE
			cmp eax, SOCKET_ERROR
			je .error
			mov [hThread2], eax          
			 test eax, eax
			 jnz .success
		 .error:
			 call WSACleanup
			 mov [hSocket2], INVALID_SOCKET
		 jmp .Init_block
		.success:
		call Sleep, 100 
		call SetThreadAffinityMask, [hThread2], 4
		.restart:
		mov [Restart], 0 
		call Sleep, 20 
		cmp [LPTR_lfile],0
			jz @f
		call Sleep, 100
			mov [LPTR_lfile],0
		@@:
		cmp [LPTR_storeF],0      
		jz @f
			mov [LPTR_storeF],0  
		@@:
		.back:           
	pxor xmm0, xmm0
	pxor xmm1, xmm1
	movdqu xword[rsOffSetA],xmm0 
	movdqu xword[rsOffSetA+16],xmm1
	movdqu xword[FNSizeString],xmm0
	movdqu xword[FNSizeString+16],xmm1
	movdqu xword[dbgres],xmm0 
	movdqu xword[dbgres+16],xmm1
		call RtlZeroMemory, szFileName, 260
		call RtlZeroMemory, tmp32_1, UbuffSize
		call RtlZeroMemory, ffgw33qs4, UbuffSize
		call RtlZeroMemory, fpng, 256
		mov ecx, 131072 / 4 
		mov edi, cp3264  
		rep stosd
		mov [tmpd4_2],65535 
		mov [Countpack],0
		mov [Peaces],0
		mov [last_update],0
		mov [refreshB], 1
		ccall wsprintf, f786kgh, msg_systemPI, "Re/Start socket2 recv tread", _str64, F_SERVER_PORT
		stdcall ert084, f786kgh
		mov [sendsize],1 
		mov [m37xv],4 
		mov [tmpd4_3],1
		;--
		.sendblk:
		@@:
		cmp [tmpd4_3],0
		jne @f
		call Sleep, 1 
		jmp @b
		@@:
		mov [tmpd4_3],0  
		cmp [last_rpack_time],0
		je @f
		   cmp [m37xv],4
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
				  mov [m37xc],1
				  mov [m37xv],6  
		@@:
		cmp [last_spack_time],0
		je @f
		mov eax, [alltick]
		sub eax, [last_spack_time]
		cmp eax, TIMEOUT
		jl @f
		mov [m37xc],0
		mov [Restart],1
		@@:
		.if [m37xv]=0  
		mov [startKeep], 0  
		 mov esi, _str64
		 mov edi, _str642
		 mov ecx, 16/4
		 cld
		;--
		 rep movsd
					   call inet_addr, _str64 
		;--
				   mov [clientAddr.sin_addr], eax 
		;--
				   mov [clientAddr2.sin_addr], eax 
						 mov eax,0
		;--
					 mov ax,[clientAddr2.sin_port]
						 xchg al,ah
		;--
					 mov dword[rfp_32],eax
		;--
						 call _itoa, [rfp_32], _str64p2, 10
						 stdcall yrdhw3, _str64p2
		mov [m37xv],2  
		;--
		ccall wsprintf, tmp32_1, data_hdr, session_id, [szFileNameSize], szFileName  
		;--
		call sendto, [hSocket2], tmp32_1, eax, 0, clientAddr2, SOCKADDR_SIZE
		call Sleep, 3500 
		.endif
		.if [m37xv]=1  
		call  GetProcessHeap
			mov     dword[hHeap],eax
			 mov eax, [szFileNameSize]
			 cmp eax, 0
			 jz n543_s.restart
			add eax, UbuffSize * 2
			call  HeapAlloc,[hHeap],HEAP_ZERO_MEMORY+HEAP_GENERATE_EXCEPTIONS,eax
			test eax, eax
			jnz .alloc_ok
			mov [LPTR_storeF], 0
			call Sleep, 100
			call MessageBox, 0, "Err HeapAlloc", "Dest File - Err HeapAlloc" , MB_ICONERROR
			xor eax, eax
			jmp n543_s.restart
		.alloc_ok:
		mov [LPTR_storeF], eax   
		call Sleep, 100 
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
		mov [m36xc],eax 
		stdcall rtd756
		mov [m37xv],4 
		mov [tmpd4_3], 1
		jmp .sendblk
		.endif
		.if [m37xv]=7  
		 ;--
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
		mov [m36xc], eax
		mov [m37xc],1 
		mov [last_rpack_time],0 
		mov [skipcnt], 0
		 @@:
		cmp [mapsize],0  
		jne @f
		.completret:
		mov [m37xv],4
		mov [firstEnter],1
		mov [tmpd4_3], 1
		jmp n543_s.sendblk
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
		ccall wsprintf, tmp32_1, data_retry, session_id, dword[szOffSet]  
		mov eax, 128
		mov [headerSize], 128
		jmp n543_s.rit
		.endif
		.if [m37xv]=2  
		.if [sendsize]>0 
				  mov eax, [alltick]
		mov [last_spack_time],eax 
		mov eax, [LPTR_lfile]
		add eax, [szOffSet]
		mov [flow_file], eax   
		cmp dword[ffgw33qs4], '568:' 
		je n543_s.fixing                 
		ccall wsprintf, tmp32_1, data_cnt, session_id, dword[szOffSet]  
		mov eax, 128
		mov [headerSize], 128
		n543_s.rit:        
		mov ebx, UbuffSize      
		sub ebx, [headerSize]   
		mov esi, [flow_file]    
		mov edi, tmp32_1
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
		call yadf_t86 
		n543_s.flow03:
		inc [skipcnt]
		.if [skipcnt]>7
		cmp [skipcnt], 19
		jae .normal
		jmp @f
		.endif
		.normal:
		mov eax, UbuffSize
		;--
		call sendto, [hSocket2], tmp32_1, eax, 0, clientAddr2, SOCKADDR_SIZE
		@@:
		mov eax, UbuffSize
		sub eax, 128 
		cmp [m37xv],7
		je @f
		add [szOffSet], eax     
		mov eax,[sendsize]      
		@@:
		cmp dword[ffgw33qs4], '568:' 
		je n543_s.fixing
		.if [firstEnter]<>0  
		mov ebx, [szFileNameSize]
		add ebx, [headerSize] 
		cmp ebx, UbuffSize
		jna .minis
		.if eax>=[szFileNameSize]    
		.minis:
		.if [sendsize]>1
		cmp [m37xv],7    
		je n543_s.fixing          
		mov [m37xv],4
		mov [szOffSet],0
		mov [sendsize],0     
		mov [flow_file],0
		mov [szFileNameSize],0
		mov byte[szFileName],0
		mov [headerSize],0
		.endif
		.endif
		mov eax, [szOffSet]
		mov [sendsize], eax
		n543_s.fixing:
		.endif
		.endif
		.endif
		.if [m37xv]=6  
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
		ccall wsprintf, tmp32_1, data_matrix, session_id, dword[mapsize], dword[szOffSet]  
		mov eax, 128
		mov [headerSize], 128
		mov ebx, dword[szOffSet]          
		lea esi, [cp3264+ebx] 
		lea edi, [tmp32_1+eax]       
		 mov ecx, 16256
		 shr ecx, 2
		 cld
		 rep movsd           
		mov ecx, [m36xc]   
		mov ebx, [headerSize]
		add ebx, ecx         
		cmp ebx, UbuffSize   
		jna @f               
		mov ecx, UbuffSize
		sub ecx, [headerSize]
		sub [m36xc], ecx   
		add [szOffSet], ecx  
		jmp .sendmtx
		@@:
		mov eax, [mapsize] 
		mov [m36xc], eax 
		mov [last_spack_time],0 
		mov [m37xv],4      
		mov [firstEnter], 1
		.sendmtx:
		mov eax, UbuffSize 
		;--
		call sendto, [hSocket2], tmp32_1, eax, 0, clientAddr2, SOCKADDR_SIZE
		jmp n543_s.Bupas 
		.endif
		.if [m37xv]=3  
		mov [m37xv],5  
		mov [tmpd4_3], 0 
		jmp gh453
		;--
		n543_s.continueS:
		.endif
		.if [init_s2]=1
		cmp [m37xv],4  
		jne .newremya
		cmp [m37xc],1
		je .newremya
		mov eax, [last_spack_time]
		  .if [last_rpack_time]=eax

			   .if byte[snc256s]=1             
				ccall wsprintf, fpng, str_nick, ni__fgw33qs4, tn__nick_fgw33qs4
		mov edx, eax
				 jmp @f		 
		.endif
								  .if byte[k26]=1
									 mov edx,4
									 mov dword[fpng],'74jh'     
									 jmp @f
								   
								  .endif
				.if byte[snc256s]=2             
				 mov edx,4
				 mov dword[fpng],'g14:'       
				 jmp @f
				.endif
							mov edx,[height]
							mov esi,cons23  
							mov edi,fpng
							mov ecx, edx
							cld
			;--
							rep movsb
							mov byte[edi],0
				@@:
			;--
								   call sendto, [hSocket2], fpng, edx, 0, clientAddr2, SOCKADDR_SIZE
		  .endif
		.newremya:  
		;--
		mov [init_s2], 0
		.endif
		n543_s.Bupas:
		;--
		call RtlZeroMemory, tmp32_1, UbuffSize 
		.flow:
		.if [Restart]=1
		mov [Restart], 0
		jmp n543_s.restart
		.endif
		mov [tmpd4_3],1        
		call Sleep, 10 
		jmp n543_s.sendblk
		ret
		endp
		;--
		proc rtd256 ws01_4 
			rtd256.thread_loop: 
				cmp [exitFlag2], 1
				je rtd256.thread_exit
			 cmp [last_rpack_time],0
			 jz @f
			 cmp[last_spack_time],0 
			 jne @f
			 cmp [m37xv], 4 
			 jne @f      
				  mov eax, [alltick]       
				  sub eax, [last_rpack_time] 	  
		.generic:
			  cmp eax, TIMEOUT
			  jl @f
			  mov [last_rpack_time],0

						  mov [Restart], 1
		@@:
		mov [addrSize], SOCKADDR_SIZE
		;--
				call recvfrom, [hSocket2], ffgw33qs4, sizeof.ffgw33qs4, 0, clientAddr2, addrSize 
						cmp eax, SOCKET_ERROR
				je rtd256.no_data      
		;--
				mov byte [ffgw33qs4 + eax], 0
						mov [RdataWOHead], eax            
		@@:
		call Sleep, 0 
		cmp [tmpd4_3],0
		jne @f
		jmp @b
		@@:
		mov [tmpd4_3],0
		cmp dword[ffgw33qs4], '568:'
		jne .norix
		stdcall lrJrtui2, session_id
		cmp [session_id], '1234'  
		jne rtd256.thread_loop  
		stdcall lrJrtui2, FNSizeString
		stdcall lrJrtui2, rsOffSetA
		mov dword[curFSymbol], 0    
		call atoi, FNSizeString    
		mov [mapsize],eax   
		call atoi, rsOffSetA
		mov [rsOffSet], eax 
		.if [firstPacket]=1
		mov [firstPacket],0
		mov [m37xv], 4 
		mov [last_spack_time],0 
		.endif
		mov ebx, 128
		mov [RecvHeader], ebx
		lea esi, [ffgw33qs4+ebx]
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
		mov [m37xv], 7       
		mov [firstPacket],1     
		mov [last_rpack_time],0 
		mov [RecvHeader], 0
		.endif
		call RtlZeroMemory, FNSizeString, 32
		jmp rtd256.iter 
		.norix:
		cmp [m37xv],2                    
		je rtd256.skipmode
		cmp [m37xv],3                    
		je rtd256.skipmode
		cmp [m37xv],5
		je rtd256.skipmode
		cmp [m37xv],7
		je rtd256.skipmode
		.if dword[ffgw33qs4]='268:' 
		cmp [Retry],0
		jne rtd256.Ritri
		mov [m37xv],4
		mov [last_spack_time],0 
		mov [Retry],1  
		mov [last_OffSet],-1
		jmp rtd256.Ritri
		.endif
		cmp [m37xv],6          
		je rtd256.badpacket
		cmp [firstEnter],0        
		je rtd256.badpacket 
		.if dword[ffgw33qs4]='114:'  
		;--
		rtd256.Ritri:
		stdcall lrJrtui2, session_id
		cmp [session_id], '1234'  
		jne rtd256.thread_loop          
		;--
		stdcall lrJrtui2, rsOffSetA
		mov dword[curFSymbol], 0 
		;--
		call atoi, rsOffSetA
		cmp  eax, [BaseFileSize] 
		jnb rtd256.badpacket  
		mov ebx, eax
		add ebx, [LPTR_storeF]
		cmp ebx, [LPTR_storeF]
		jb rtd256.badpacket  
		 mov [rsOffSet], eax
		 cmp [last_OffSet],0      
		 je @f
		 cmp [last_OffSet], eax  
		 je rtd256.iter
		@@:
		 mov [last_OffSet], eax  
		jmp rtd256.ProgressBarR     
		rtd256.flow02:              
		mov ebx, 128
		mov [RecvHeader], ebx
		sub [RdataWOHead], ebx   
		lea esi, [ffgw33qs4+ebx]   
		mov edi, [LPTR_storeF]   
		add edi, [rsOffSet]      
		 cmp dword[edi],0  
		 jz .netu          
		 jmp rtd256.iter
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
		mov ebx, cp3264  
		add ebx, eax
		mov byte[ebx],1
		inc [bingoCount]      
		mov eax, [alltick]
		mov [last_rpack_time],eax 
		.if [m37xc]=1
		mov edi, cp3264   
		add edi, [m36xc] 
		dec edi
		mov eax,0
		mov ecx, [m36xc]
		std
		repne scasb
		cld
		.filler:
		cmp ecx,0 
		jne rtd256.skpfinchk 
		mov edi, cp3264   
		add edi, [mapsize] 
		dec edi
		mov eax,0
		mov ecx, [mapsize]
		std
		repne scasb
		cld
		mov [m36xc], ecx 
		mov [mapsize], ecx 
		cmp ecx,0 
		je rtd256.bingobin
		rtd256.Reply:
		mov [Retry],0
		mov [m37xv],6  
		mov [last_rpack_time],0 
		rtd256.skpfinchk:
		jmp @f
		rtd256.bingobin:
		jmp rtd256.right
		@@:
		jmp rtd256.iter 
		.endif
		mov ebx, [RecvHeader]
		add ebx, [szFileNameSize] 
		cmp ebx, UbuffSize
		jna rtd256.minir
		mov eax, [rsOffSet]     
		add eax, [RdataWOHead]      
		.if eax>=[szFileNameSize] 
		mov edi, cp3264   
		add edi, [mapsize] 
		dec edi
		mov eax,0
		mov ecx, [mapsize]
		std
		repne scasb
		cld
		je @f
		 jmp rtd256.right
		@@:
		mov [m37xc],1                      
		mov [m37xv],6  
		mov [last_rpack_time],0 
		jmp rtd256.iter 
		rtd256.right:
		mov [m37xc],0  
		mov [Retry],0
		rtd256.minir:
		mov [cnt_recv_mode],0
		mov [last_rpack_time],0 
		mov [last_spack_time],0 
		.if [m37xv]<>3
		mov [rsOffSet],0     
		mov [last_OffSet],-1 
		mov [RdataWOHead],0  
		.if [m37xc]=0
		mov [m37xv],3     
		jmp rtd256.iter
		.endif
		.endif
		.endif
		.endif

		.if [last_rpack_time]=0 
				cmp dword[ffgw33qs4], '74jh'
				jne @f
		 mov esi, _str64
		 mov edi, _str642
		 mov ecx, 16/4
		 cld
		;--
		 rep movsd
						 mov eax,0
						 mov ax,[clientAddr2.sin_port]
						 xchg al,ah
						 mov dword[rfp_32],eax
						 call _itoa, [rfp_32], _str64p2, 10
						 stdcall yrdhw3, _str64p2
		;--
		ccall wsprintf, f786kgh, FnpU_ress, "keep channel", _str642, _str64p2
		stdcall ert084, f786kgh
		@@:
		.endif
		.if [last_rpack_time]=0 
				cmp dword[ffgw33qs4], 'g14:'
				jne @f
		;--
		ccall wsprintf, f786kgh, FnpU_ress, "Ping", _str642, _str64p2
		stdcall ert084, f786kgh
		@@:
		.endif
		.if [last_rpack_time]=0
		.if dword[ffgw33qs4]='264:'
		xor ebx, ebx
		xor edx, edx
		xor ecx, ecx
		xor esi, esi
		xor edi, edi
		mov [startKeep], 0  
		mov [szFileNameSize],0
		mov [rsOffSet],0     
		mov [last_OffSet],-1 
		mov dword[curFSymbol], 0
		stdcall lrJrtui2, session_id
		stdcall lrJrtui2, FNSizeString
		call atoi, FNSizeString           
		mov [szFileNameSize], eax
		mov [BaseFileSize], eax
		stdcall lrJrtui2, szFileName
		mov dword[curFSymbol], 0 
		call RtlZeroMemory, FNSizeString, 32
		mov [m37xv],1 
		;--
		mov eax, [alltick]
		mov [last_rpack_time],eax 
		jmp rtd256.iter
		.endif
		.endif
		.if [last_rpack_time]=0
		.if dword[ffgw33qs4]='124:'  
		stdcall lrJrtui2, session_id
		stdcall lrJrtui2, FNSizeString
		mov dword[curFSymbol], 0 
		call atoi, FNSizeString
		cmp eax, [szFileNameSize]
		jz ._ok
			call MessageBox, 0, "err", " wrongs 124:szFileNameSize", MB_OK
			jmp n543_s.restart
		._ok:
		call RtlZeroMemory, FNSizeString, 32
		mov [m37xv],  2 
		jmp rtd256.iter
		.endif
		.endif
		rtd256.badpacket:
		rtd256.iter:
		call RtlZeroMemory, rsOffSetA, 32 
		rtd256.skipmode:
		mov [tmpd4_3], 1 
			   jmp rtd256.thread_loop
			rtd256.no_data: 
				jmp rtd256.thread_loop
			rtd256.thread_exit:
				call Sleep, 500
				call ExitThread, 0
		rtd256.ProgressBarR:
		cmp [Countpack], 0
		je .complet
		mov ebx, [Peaces]
		sub [tmpd4_2],ebx
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
		jmp rtd256.flow02
		   ret
		endp
		;--
		proc yadf_t86
		cmp [Countpack], 0
		je .comples
		mov ebx, [Peaces]
		sub [tmpd4_2],ebx
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
		proc lrJrtui2 field
		mov esi, ffgw33qs4
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
		cmp dword[ffgw33qs4],'114:'
		je @b
		cmp dword[ffgw33qs4],'268:'
		je @b
		cmp dword[ffgw33qs4],'568:'
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
		proc ybnk79 

								mov eax,0
							mov ax, [clientAddr2.sin_port]
								xchg al,ah
							mov dword[rfp_32], eax
		;--
								call _itoa, [rfp_32], _str64p2, 10      
		 mov esi, _str64
		 mov edi, _str642
		 mov ecx, 16/4
		 cld
		;--
		 rep movsd
		ret
		endp
		;--
		proc yrw4
		call GetWindowRect, [ws01_4], myRect
		mov eax, [myRect.left]
		mov [windowX], eax
		mov eax, [myRect.top]
		mov [windowY], eax
		ret
		endp
		proc gr65
			call GetPrivateProfileStringA, sec_name, tms34, 0, gw33qs4, 20, gdbn_2sst
			call GetPrivateProfileStringA, sec_name, rtuio, 0, firstchk, 4, gdbn_2sst
			call GetPrivateProfileStringA, sec_name, skip_dot, start_ip, long_s, 16, gdbn_2sst
			call GetPrivateProfileStringA, sec_name, long_st, tm32, hpoin89, 15, gdbn_2sst
				call GetPrivateProfileStringA, sec_name, _Name1, 0, ni__fgw33qs4, 32, gdbn_2sst
				call GetPrivateProfileStringA, sec_name, _Name2, 0, tn__nick_fgw33qs4, 32, gdbn_2sst 
			call GetPrivateProfileIntA, sec_name, _window_posX, [windowX], gdbn_2sst
				mov [windowX], eax
			call GetPrivateProfileIntA, sec_name, _window_posY, [windowY], gdbn_2sst
			mov [windowY], eax   
			call GetPrivateProfileIntA, sec_name, _portstart, [stp], gdbn_2sst
			mov [hpoin90], eax
			call GetPrivateProfileIntA, sec_name, _portS, [iutyre], gdbn_2sst
				mov [portserver_value], eax
			call GetPrivateProfileIntA, sec_name, _Fportstart, [nvbftry], gdbn_2sst
			mov [Fportstart_value], eax
			call GetPrivateProfileIntA, sec_name, _FportS, [dfghkee5], gdbn_2sst
				mov [cons23f], eax
		ret
		endp
		proc yr65 ws01_4  
				call WritePrivateProfileString, sec_name, rtuio, firstchk, gdbn_2sst       
				call WritePrivateProfileString, sec_name, _Name1, Name1_SAVE, gdbn_2sst
				call WritePrivateProfileString, sec_name, _Name2, Name2_SAVE, gdbn_2sst
		ret
		endp
		proc jh987
			call GetModuleHandle, 0   
			call GetModuleFileNameA, eax, gdbn_2sst, 260   
			mov edi, gdbn_2sst + 260
			mov ecx, 260
			mov al, '/'
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
			ret
		endp
		proc jh984
			mov edi, szFileName + 260
			mov ecx, 260
			mov al, '/'
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
		ret
		endp
		proc rtd756
		mov [tmpd4_2],65535 
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
		ret
		endp
		gh450: 
			mov [ofn.lStructSize], sizeof.OPENFILENAME
			mov [ofn.lpstrFile], szFileName
			mov [ofn.nMaxFile], 260
			mov [ofn.Flags], OFN_PATHMUSTEXIST or OFN_FILEMUSTEXIST
			mov [ofn.lpstrTitle], szTitle               
		mov eax,0
		mov byte [szFileName], 0
			call GetOpenFileName, ofn
			cmp byte [szFileName], 0
				jnz @f

				jmp tmp_257c.continueEr
		@@:    
			test eax, eax                    
			jnz @f
			jmp tmp_257c.continueEr
		@@:    
		gh450.ole_case:    
			call CreateFile, szFileName, GENERIC_READ, FILE_SHARE_READ, 0, OPEN_EXISTING, FILE_ATTRIBUTE_NORMAL, 0
			cmp eax, INVALID_HANDLE_VALUE    
			je .err
			mov [hlFile], eax                    
			call GetFileSize, [hlFile], 0
			 mov [szFileNameSize], eax
			 mov [BaseFileSize], eax
			 cmp eax, 0
			 jnz @f
			 mov [Restart], 1
			jmp tmp_257c.continueEr	
		@@:
			 add eax, UbuffSize * 2   
			call LocalAlloc, LPTR, eax
			mov [LPTR_lfile], eax
			test eax, eax
			jz .close_error   
		mov [total_read], 0
		mov [bytes_read], 0
		mov eax, [szFileNameSize]
		mov [bytes_to_read], eax
		mov ebx, [LPTR_lfile]
		.read_loop:
		call ReadFile, [hlFile], ebx, [bytes_to_read], bytes_read, 0
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
			call Sleep, 100
			mov [LPTR_lfile],0
			xor eax, eax
			
			call CloseHandle, [hlFile]
			mov [hlFile],0
		.err:
			
		.exit:
			
			mov [Restart], 1
			jmp tmp_257c.continueL
		.next:
		.close_file:
			call CloseHandle, [hlFile] 

		call jh984
		mov [szOffSet],0
		mov [flow_file],0
		mov [m37xv],0                
		mov [sendsize],1 
		stdcall rtd756
		jmp tmp_257c.continueL
		gh453:
			mov [ofn.lStructSize], sizeof.OPENFILENAME
			mov [ofn.lpstrFile], szFileName
			mov [ofn.nMaxFile], 260
			mov [ofn.Flags], OFN_PATHMUSTEXIST or OFN_OVERWRITEPROMPT
			mov [ofn.lpstrTitle], szTitleS               
			mov eax,0    
			call GetSaveFileName, ofn
			test eax, eax                    
				jz .Sexit
		cmp byte [szFileName], 0
				jz .Sexit
			call CreateFile, szFileName, GENERIC_WRITE, 0, 0, CREATE_ALWAYS, FILE_ATTRIBUTE_NORMAL, 0
			cmp eax, INVALID_HANDLE_VALUE    
			jz .Snext
			mov [hFileS], eax                 
		   
			mov esi, [LPTR_storeF]
			mov ebx, [szFileNameSize]
			.write_loop:
			cmp ebx,0
			je .Sclose_file
			
			call WriteFile, [hFileS], esi, ebx, bytesWritten, 0
			
			cmp [bytesWritten],0
			jz .Sclose_file
			add esi, [bytesWritten]
			sub ebx, [bytesWritten]
			jnz .write_loop
			test eax, eax                    
			jz .Sclose_error
		.Sclose_file:
			
			call CloseHandle, [hFileS]
			mov [hFileS], 0

			cmp [LPTR_storeF],0      
		jz @f
			mov [LPTR_storeF],0  
		@@:
						ccall wsprintf, f786kgh, filerecv, szFileName
							stdcall ert084, f786kgh              
			jmp .Snext
		   .Sclose_error:
		   .Serror:
			call CloseHandle, [hFileS]
			mov [hFileS], 0

			cmp [LPTR_storeF],0      
		jz @f
			mov [LPTR_storeF],0  
		@@:
		.Sexit:   
		.Snext:
		call Sleep, 100

		mov [Restart],1
		jmp n543_s.continueS
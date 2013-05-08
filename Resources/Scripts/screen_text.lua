--
--
--ShowText��ʹ�÷���:
--����Ϊ:(��Ļ���,{"����","���",������,����λ��,����,{"ѡ���֧1","ѡ���֧2"},�ص�����},{"����",{"ѡ���˷�֧1","ѡ���˷�֧2"},������,λ��,����,{"��֧1","��֧2"},"û���������ֺ������ĵ����仰"},{"ͼƬһ","ͼƬ��"})
--ShowText(101, {{"Yu","һ����������",2,1,102,{'��֧1','��֧2'},callback},{"���ص���",{"��֧1�Ľ��","��֧2�Ľ��"},1,2,101,{'��֧3','��֧4'}},{"Yu","b",2,1,101},{"���ص���","c",1,2,102},{"Yu","d",2,1,102},"һ�����������߰�"},{"Resources/Images/SCA07.png","Resources/Images/hero.png"})
--
--
--���ô�����Ϣ
--������ɫ:0.18,0.62,0.34
--�Ի�������ɫ205 205 180,
--ѡ����ɫ0.55,0.55,0.48
--�Ķ������ɫ139 139 122
TextColor={
	Name=flux.Color(0.18,0.62,0.34),
	UnfinshRead=flux.Color(0.8,0.8,0.71),
	FinishRead=flux.Color(0.55,0.55,0.48),--139 139 122
	SwitchCase=flux.Color(0.42,0.57,0.14),
	}
function SetNext(this,curpos,ch_info)
	local text = ScreenText.textlist[curpos]
	if type(text) == 'string' then		
		if ScreenText.t==nil then
			ScreenText.t = flux.TextView(this, nil, 'wqy',text):SetAlign(flux.ALIGN_TOPLEFT)
			ScreenText.t:SetHUD(true)
			ScreenText.t:SetColor(TextColor.UnfinshRead)
			this:AddView(ScreenText.t,8)
		end
		ScreenText.t:SetText(text):SetPosition(-11,-4.5)
		
		--�����������������
		if ScreenText.portrait then
			ScreenText.portrait:AnimCancel()
			ScreenText.portrait:FadeOut(1,nil,-1):AnimDo()
		end
		--���ִ���������
		if ScreenText.name then
			ScreenText.name:AnimCancel()
			ScreenText.name:FadeOut(1,nil,-1):AnimDo()
		end
	else
		--����
		if ScreenText.name ==nil then
			ScreenText.name = flux.TextView(this, nil, 'wqy',text[1])
			ScreenText.name:SetHUD(true):SetColor(TextColor.Name):SetAlign(flux.ALIGN_TOPLEFT):SetPosition(-11,-3.4)
			this:AddView(ScreenText.name,5)
		else
			ScreenText.name:AnimCancel()
			ScreenText.name:SetText(text[1]):SetAlpha(1)
		end
		--����
		local msg
		if type(text[2])=='table' then
			msg=text[2][ScreenText.curSelection]
		elseif type(text[2])=='string' then
			msg=text[2]
		end
		if ScreenText.t==nil then
			ScreenText.t = flux.TextView(this, nil, 'wqy',msg):SetAlign(flux.ALIGN_TOPLEFT)
			ScreenText.t:SetHUD(true)
			ScreenText.t:SetColor(TextColor.UnfinshRead)
			this:AddView(ScreenText.t,8)
		end
		ScreenText.t:SetText(msg):SetPosition(-11,-4.5)
		--����������Ϣ
		if ScreenText.portrait then
			ScreenText.portrait:AnimCancel()
			ScreenText.portrait:SetSprite(ch_info[text[3]]):SetSize(8.8,20.34)--:SetAlpha(1)
		else 
			ScreenText.portrait = flux.View(this):SetSprite(ch_info[text[3]]):SetSize(8.8,20.34)--:SetAlpha(1)
			this:AddView(ScreenText.portrait,-2)
		end
		--����λ��
		if text[4] == 1then
			ScreenText.portrait:SetPosition(-8,-4)
		elseif text[4] == 2 then
			ScreenText.portrait:SetPosition(8,-4)
		end
		ScreenText.portrait:SetAlpha(1)
		--����
		if text[5] then
			theSound:PlaySound(text[5])
		end
		
		--ѡ���֧
		if type(text[6])=='table' then
			if ScreenText.switchCase==nil then
				ScreenText.switchCase={}
			else
				--�¸��Ի����ڷ�֧,��������һ���ķ�֧
				for i=1,#ScreenText.switchCase do
					if ScreenText.switchCase[i] then
						ScreenText.switchCase[i]:SetAlpha(0)
					end
				end
			end
			--��ӷ�֧
			for i=1,#text[6] do
				ScreenText.switchCase[i]=flux.TextView(this,nil,'wqy','>   '..text[6][i]):SetColor(TextColor.SwitchCase):SetPosition(-9,-5+-1*i):SetAlign(flux.ALIGN_LEFT)
				this:AddView(ScreenText.switchCase[i])
			end
			--��ʾѡ����
			if ScreenText.selection==nil then 
				ScreenText.selection=flux.View(this):SetSize(1,1):SetSprite('Resources/Images/hand.png'):SetAlign(flux.ALIGN_LEFT)
				this:AddView(ScreenText.selection)
			end
			ScreenText.selection:SetAlpha(1):SetPosition(-10.3,-5-ScreenText.curSelection)
			--���ô��ڷ�֧
			ScreenText.curExistSwitch=true
			--callback
			ScreenText.callback = text[7]
			--��֧���ڵ�λ��
			ScreenText.switchFlag =curpos
		else
			--��һ���Ի������ڷ�֧,�����ص�ǰ��֧
			if ScreenText.switchCase then
				--����ѡ����
				if ScreenText.selection then
					ScreenText.selection:SetAlpha(0)
				end
				for i=1,#ScreenText.switchCase do
					ScreenText.switchCase[i]:SetAlpha(0)
				end
			end
			--�����ڷ�֧
			ScreenText.curExistSwitch=false
			
		end
	end
end
--�������к�,�Ի�����,����,����ͼ
function ShowText(fromcode,textlist,ch_info,bgpic)
	-- fromcode=100
	-- textlist{{'����','��һ�仰', ������, ����λ��, ����,{'��֧1','��֧2'...},callback}, '�ڶ��仰'}
	-- textlist{{'����','��һ�仰', ������, ����λ��, ����,{'��֧1','��֧2'...},callback}, {{'��֧1res'},{'��֧2res'}...}}
	-- ch_info = {'pic1', 'pic2', ...}
    if scr.ScreenText == nil then
        ScreenText = {}
        scr.ScreenText = flux.Screen()
		scr.ScreenText:lua_Init(wrap(function(this)
            local bg = flux.View(this)
            bg:SetHUD(true)
			bg:SetSize(24, 6)
            bg:SetPosition(0, -6):SetAlpha(0.8)
			--���ñ���
			if bgpic then
				bg:SetSprite(bgpic)
			else
				bg:SetSprite('Resources/Images/textbg.png')
			end
            this:AddView(bg)
            -- ע�ᰴ��
			this:RegKey(_b'Z')
            this:RegKey(flux.GLFW_KEY_LEFT)
            this:RegKey(flux.GLFW_KEY_ESC)
            this:RegKey(flux.GLFW_KEY_ENTER)
            this:RegKey(flux.GLFW_KEY_SPACE)
            this:RegKey(flux.GLFW_KEY_RIGHT)
			this:RegKey(flux.GLFW_KEY_UP)
			this:RegKey(flux.GLFW_KEY_DOWN)

            -- ��������
           ScreenText.bg = bg

			scr.ScreenText:lua_OnPush(wrap(function(this)
				SetNext(this,1,ch_info)
				theWorld:PhyPause()
			end))
			
		end))
		
		--�ָ�
        scr.ScreenText:lua_OnPop(wrap(function(this)
			theWorld:PhyContinue()
		end))

        scr.ScreenText:lua_KeyInput(wrap(function(this, key, state)
            if state == flux.GLFW_PRESS then
                if key == flux.GLFW_KEY_ENTER or key == flux.GLFW_KEY_SPACE or key == _b'Z' or key == flux.GLFW_KEY_RIGHT then
					--enterѡ�е�ǰѡ��
					if ScreenText.curExistSwitch then
						if  key == flux.GLFW_KEY_ENTER then
							--print("ѡ��:"..ScreenText.curSelection)
							--callback
							if type(ScreenText.callback)=='function' then
								--�ص�ѡ����
								ScreenText.callback(ScreenText.curSelection)
							end
						else
							--��ѡ����
							return
						end 
					end

					if ScreenText.curpos > #ScreenText.textlist then
						this:SetFromCode(ScreenText.fromcode)
						theWorld:PopScreen()
					else
						SetNext(this,ScreenText.curpos,ch_info)
						--������ɫ
						if ScreenText.readpos<=ScreenText.curpos then
							ScreenText.readpos =ScreenText.curpos
							ScreenText.t:SetColor(TextColor.UnfinshRead)
						else
							ScreenText.t:SetColor(TextColor.FinishRead)
						end
						ScreenText.curpos = ScreenText.curpos + 1
					end
				elseif key == flux.GLFW_KEY_LEFT then
					if ScreenText.curpos-2<=ScreenText.switchFlag then
						--ScreenText.switchFlag���ڷ�֧���ܷ���
						return
					end
					-- ��ʱ�����ǰһ�仰
					if ScreenText.curpos > 2 then
						SetNext(this,ScreenText.curpos-2,ch_info)
						--������ɫ
						ScreenText.t:SetColor(TextColor.FinishRead)
						ScreenText.curpos = ScreenText.curpos - 1
					end
				elseif key == flux.GLFW_KEY_ESC then
					this:SetFromCode(ScreenText.fromcode)
					theWorld:PopScreen()
                end
				
				--ѡ���֧
				if ScreenText.curExistSwitch then
					if key==flux.GLFW_KEY_UP then
						if ScreenText.curSelection <= 1 then
							ScreenText.curSelection=#ScreenText.switchCase
						else
							ScreenText.curSelection=ScreenText.curSelection-1
						end
						
						ScreenText.selection:SetPosition(-10.3,-5-ScreenText.curSelection)
					elseif key==flux.GLFW_KEY_DOWN then
						if ScreenText.curSelection>=#ScreenText.switchCase then
							ScreenText.curSelection=1
							else
							ScreenText.curSelection=ScreenText.curSelection+1
						end
						ScreenText.selection:SetPosition(-10.3,-5-ScreenText.curSelection)
					end
				end
            end
        end))

    end
	
	--���һ�����ڷ�֧��λ��
	ScreenText.switchFlag=0
	--��ǰ�Ƿ���ڷ�֧ѡ��
	ScreenText.curExistSwitch=false
	--��ǰѡ����
	ScreenText.curSelection=1
	--�Ķ�λ��
	ScreenText.readpos = 2
	ScreenText.fromcode = fromcode
	ScreenText.textlist = textlist
	ScreenText.curpos = 2
    theWorld:PushScreen(scr['ScreenText'], flux.SCREEN_APPEND)
end

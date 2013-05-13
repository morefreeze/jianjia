

ScreenAlignmentChoose = {

    new = function()
        if ScreenAlignmentChoose.scr then return end

        -- �����趨
        ScreenAlignmentChoose.scr = flux.Screen()
        
        -- OnPush �¼�
        ScreenAlignmentChoose.scr:lua_OnPush(wrap(function(this)
            ScreenAlignmentChoose.splash:FadeOut(0.5):AnimDo()
        end))

        -- ������Ӧ
        ScreenAlignmentChoose.scr:lua_KeyInput(wrap(function(this, key, state)
            if state == flux.GLFW_PRESS then
                local cursel = ScreenAlignmentChoose.cursel
                if key == flux.GLFW_KEY_RIGHT then
                    if cursel == 5 then return end
                    ScreenAlignmentChoose.Items[cursel]:AnimCancel()
                    ScreenAlignmentChoose.Items[cursel+1]:AnimCancel()
                    ScreenAlignmentChoose.Items[cursel]:ResizeTo(0.5, ScreenAlignmentChoose.normalSize):AnimDo()
                    ScreenAlignmentChoose.Items[cursel+1]:ResizeTo(0.8, ScreenAlignmentChoose.bigSize):AnimDo()
                    ScreenAlignmentChoose.text:SetText(ScreenAlignmentChoose.ItemText[cursel+1])
                    ScreenAlignmentChoose.text2:SetText(ScreenAlignmentChoose.ItemText2[cursel+1])
                    ScreenAlignmentChoose.cursel = cursel + 1                    
                elseif key == flux.GLFW_KEY_LEFT then
                    if cursel == 1 then return end
                    ScreenAlignmentChoose.Items[cursel]:AnimCancel()
                    ScreenAlignmentChoose.Items[cursel-1]:AnimCancel()
                    ScreenAlignmentChoose.Items[cursel]:ResizeTo(0.5, ScreenAlignmentChoose.normalSize):AnimDo()
                    ScreenAlignmentChoose.Items[cursel-1]:ResizeTo(0.8, ScreenAlignmentChoose.bigSize):AnimDo()
                    ScreenAlignmentChoose.text:SetText(ScreenAlignmentChoose.ItemText[cursel-1])
                    ScreenAlignmentChoose.text2:SetText(ScreenAlignmentChoose.ItemText2[cursel-1])
                    ScreenAlignmentChoose.cursel = cursel - 1
                elseif key == flux.GLFW_KEY_SPACE or key == flux.GLFW_KEY_ENTER or key == _b'Z' then
                    this:SetFromCode(1001)
                    this:SetRetCode(cursel)
                    theWorld:PopScreen()
                end
            end
        end))

        -- ��ʼ���ؼ��¼�
        ScreenAlignmentChoose.scr:lua_Init(wrap(function(this)
            -- ���ɿؼ�
            ScreenAlignmentChoose.bg = flux.View(this)
            ScreenAlignmentChoose.bg:SetHUD(true):SetSize(32, 24)

            ScreenAlignmentChoose.splash = flux.View(this)
            ScreenAlignmentChoose.splash:SetSize(32, 24):SetColor(0,0,0):SetHUD(true)
                        
            ScreenAlignmentChoose.normalSize = flux.Vector2(3, 4)
            ScreenAlignmentChoose.bigSize = flux.Vector2(5, 6.67)
            
            ScreenAlignmentChoose.cursel = 3

            ScreenAlignmentChoose.ItemText = {
                '��������',
                '����',
                '����Ӫ(����)',
                'а��',
                '����а��'
            }
            
            ScreenAlignmentChoose.ItemText2 = {
                '���¹ۣ�����������\n       ����Ӫ�Ľ�ɫ������Ȩ��������Ʒ��׼�򡢷��ɺ��쵼�ߣ�����������Щ׼���Ǵ����������;������Ȩ�߹������������ƣ���ֹ���ǻ����˺������������Ľ�ɫ�������Ľ�ɫͬ�����������ļ�ֵ�������ڸ��ӹ�ע�������ߺͷ�����ѹ�ȵ��ˡ����������ĵ䷶�ǽܳ��Ķ�ʿ�����Ǽ�����塢����������Ϊ����ֹа�������������ӿ��Ժ�����ԥ���׳�������\n       ����Ȩ�߿�ʼ�����ǵ�Ȩ��Ĳȡ˽���������ɱ��ά��һ�����˵���Ȩ�Ĺ��߶������˱����ū�۵Ľ׼�ʱ������Ҳ�ͱ����а��Ȩ���컯Ϊ����������Ӫ�Ľ�ɫ�������ڷ��������Ĳ�������Ҳ�ڵ�����ǿ�ҵ��ơ�����������Ӫ�Ľ�ɫ���ǻᾡ�������Ʒ�Χ�ھ�����Щ���⣬����Ը��ȡ�����ҵĺͲ��Ϸ��ķ�ʽ��',
                '���¹ۣ�������Ȱ���\n       ����Ӫ�Ľ�ɫ���Ű���������Σ���е���������ȷ�ġ������ܱ�Ҫ������˵���������Լ�������֮�ϣ���ʱ�����ζ�Ŷ���������𺦡�\n       ����֮����а��֮����������Ĺ������໥��ͻ������֮�伤�ҶԿ����޷���ƽ����������֮�������������Ľ�ɫ�ദ�û����������������Ľ�ɫ�������������Ķ��ѿ����е�̫���壬̫���ع�أ������Ǿ�ֱȥ��Ӧ�������¡�',
                '���¹ۣ�û����Ӫ��û������\n       ����Ӫ�Ľ�ɫ����������˺����ˣ�����û�кô��������Ҳ����ðʲô���ա���֧�ַ��ɺ�������Ϊ���ܴ������档�������Լ������ɣ�ȴ�������ر������˵����ɡ�',
                '���¹ۣ���Ű���ޡ�\n       ����Ӫ�Ľ�ɫ��һ����Ҫ�˺����ˣ��������Ǻ�Ը���������˵����㲢��˵õ�������Ҫ�Ķ�����\n       ����Ӫ�Ľ�ɫ��������ù���ͷ������ø���������󻯡����ǲ�������Щ�����Ƿ���˺������ˡ�����֧����Щ��������Ȩ�������ṹ����ʹȨ��������ū�������˵Ļ����ϡ�а��֮�˲�����ͬ����������ū���ƺ�ɭ�ϵĵȼ��ƶȣ�ֻҪ���ǻ����������λ���ϡ�',
                '���¹ۣ����������\n       ����Ӫ�Ľ�ɫ��ȫ���˼������ˡ�������Ϊ�Լ�����Ψһ��Ҫ�ģ�����ɱ¾�����ԡ��������ˣ������ȡ���������ǹ���ʳ�ԣ����ǵ���Ϊ�����������ǵ�����ۼ���Ť������ٵ����и����ǵ���Ȥû��ֱ�ӹ�ϵ���˺Ͷ�����\n       �������������˿���������а���а��һ���ɶ����������������ޡ�����а��Ĺ�������ħ�����ˣ���в�������Ͱ����ĳ̶ȱ���а��Ĺ����й�֮���޲�����а��ͻ���а������ﶼ������֮�˵����У��������ǻ���֮�䲢û�ж��پ��⣬���ٻ�Ϊ��ͬĿ���������'
            }

            ScreenAlignmentChoose.text = flux.TextView(this, nil, 'wqy', ScreenAlignmentChoose.ItemText[3])
            ScreenAlignmentChoose.text:SetPosition(0, -1):SetColor(0, 0, 1):SetHUD(true)
            -- ScreenAlignmentChoose.text:SetAlign(flux.ALIGN_LEFT)

            ScreenAlignmentChoose.text2 = flux.TextView(this, nil, 'wqy')
            ScreenAlignmentChoose.text2:SetPosition(-11, -2):SetHUD(true)
            ScreenAlignmentChoose.text2:SetAlign(flux.ALIGN_TOPLEFT):SetTextAreaWidth(800):SetText(ScreenAlignmentChoose.ItemText2[3])

            ScreenAlignmentChoose.ItemPos = {
                flux.Vector2(-10, 4),
                flux.Vector2(-5, 4),
                flux.Vector2( 0, 4),
                flux.Vector2( 5, 4),
                flux.Vector2( 10, 4),
            }

            ScreenAlignmentChoose.Items = {
                flux.View(this),
                flux.View(this),
                flux.View(this),
                flux.View(this),
                flux.View(this),
            }
            
            for k,v in pairs(ScreenAlignmentChoose.Items) do
                v:SetSize(ScreenAlignmentChoose.normalSize):SetSprite('Resources/Images/alignment' .. k .. '.jpg')
                v:SetPosition(ScreenAlignmentChoose.ItemPos[k]):SetHUD(true)
                this:AddView(v)
            end
            
            ScreenAlignmentChoose.Items[3]:SetSize(ScreenAlignmentChoose.bigSize)

            -- ע�ᰴ��
            this:RegKey(_b'Z')
            this:RegKey(flux.GLFW_KEY_ESC)
            this:RegKey(flux.GLFW_KEY_SPACE)
            this:RegKey(flux.GLFW_KEY_LEFT)
            this:RegKey(flux.GLFW_KEY_RIGHT)
            this:RegKey(flux.GLFW_KEY_UP)
            this:RegKey(flux.GLFW_KEY_DOWN)

            this:AddView(ScreenAlignmentChoose.bg, -1)
            this:AddView(ScreenAlignmentChoose.splash)
            this:AddView(ScreenAlignmentChoose.text)
            this:AddView(ScreenAlignmentChoose.text2)
        end))

    end,
    
    free = function()
        ScreenAlignmentChoose = nil
    end,
}

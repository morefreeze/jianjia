
-- װ����λ id
-- 1ͷ����2�·���3���ס�4������5Ь�ӡ�6��Ʒ

item_prefix = {
    {'ǿ����', change={}, scale={}, spell={}}, -- 1
}

items = {
    -- ���֣�          ����,
    {_'����',         id=1, req={ge={level=5}},  equip={pos=1, change={}, scale={hp_max=0.1}}, use=nil, spell=nil, prefix={}, txt=_'�������ɱ仯��С��˫���ؽ���'}, -- 1
    {_'��ʿ�̵�',      id=2, equip={pos=1, change={}, scale={}}, use=nil, spell=nil, prefix={{0.1}, {1}}, txt=_'ֻ�����߲���ӵ�еĶ̵�!'}, -- 2
    {_'��������֮��',   id=3, txt=_'��ǰ����һ���ݴԡ���'},
    {_'��������ҩ��',   id=4, use={change={hp=150}}, txt='��������ҩ�����ظ� 150 ��HP��'},
}

Items = Class()

-- �ڲ�����������id��ȡ��Ʒtable��������ı��������Ʒtable����ԭ�����ء�
--         ��ô����ԭ������ʱ��Ҫ��id����Ʒ����ʱ��ֱ�Ӵ���Ʒtable
function Items:_getitem(id_or_table)
    local _type = type(id_or_table)
    if _type == 'table' then
        return id_or_table
    elseif _type == 'number' then
        return items[id_or_table]
    end
end

-- ��һ����Ʒ
-- @param item ��Ʒ��id����������Ʒ�ı�
-- @param num ��ø���Ʒ������
function Items:GetItem(item, num)
    data.items = data.items or {}
    num = num or 1
    local item = self:_getitem(item)
    if item then
        local is_equip = Items:IsEquipment(item) or Items:IsItem(item)
        -- �����һ��װ������Ʒ����ôװ��/��Ʒ��Զռһ�񣬲���ѵ�
        if is_equip then
            for i=1,num do
                table.insert(data.items, {item.id, 1})
            end
        -- ���������Ʒ����ô���Զѵ�
        else
            -- ����������б��У���������
            for k,v in pairs(data.items) do
                if v[1] == item.id then
                    v[2] = v[2] + num
                    return
                end
            end
            -- �������ڣ�ֱ�Ӳ���
            table.insert(data.items, {item.id, num})
        end
    end
end

-- �Ƿ���һ��װ����Ʒ
-- ˵����������װ������Ϊװ����Ʒ
function Items:IsEquipment(item)
    return Items:_getitem(item).equip
end

-- �Ƿ�������Ʒ
-- ˵����������Ʒ���Ա�ʹ�ã�����Ϊ����Ʒ
function Items:IsConsumable(item)
    return Items:_getitem(item).use
end

-- �Ƿ���һ������Ʒ��
-- ˵����������Ʒ����װ����ͬʱ�޷���Ϊ����Ʒʹ�ã���Ϊ����Ʒ��
function Items:IsItem(item)
    local i = Items:_getitem(item)
    return (not i.equip) and (not i.use)
end

-- ����Ƿ���װ����ʹ��ĳ��Ʒ
-- ����ֵ����һ��Ϊ true �� false���ڶ���Ϊԭ��
function Items:CanUse(ch, item)
    local i = Items:_getitem(item)
    if not i then
        return false, _'�޷��ҵ���Ӧ��Ʒ'
    end

    -- ���������ڵ��ڣ�������С�����ʱ���ش���
    if i.ge then
        for k,v in pairs(i.ge) do
            if v < ch[k] then
                return false, _'�������Բ��ܴﵽҪ��'
            end
        end        
    end
    
    -- ���������ڣ�������С�ڵ������ʱ���ش���
    if i.gt then
        for k,v in pairs(i.gt) do
            if v <= ch[k] then
                return false, _'�������Բ��ܴﵽҪ��'
            end
        end
    end

    -- ���������ڣ�����������ʱ���ش���
    if i.eq then
        for k,v in pairs(i.eq) do
            if v ~= ch[k] then
                return false, _'�������Բ��ܴﵽҪ��'
            end
        end
    end

    -- ��������ȣ�����������ʱ���ش���
    if i.eq then
        for k,v in pairs(i.eq) do
            if v ~= ch[k] then
                return false, _'�������Բ��ܴﵽҪ��'
            end
        end
    end

    -- ������С�ڣ��������ڵ���ʱ���ش���
    if i.lt then
        for k,v in pairs(i.lt) do
            if v >= ch[k] then
                return false, _'�������Գ���Ҫ��'
            end
        end
    end

    -- ������С�ڵ��ڣ���������ʱ���ش���
    if i.le then
        for k,v in pairs(i.le) do
            if v > ch[k] then
                return false, _'�������Գ���Ҫ��'
            end
        end
    end
    
    return true, _'����ʹ��'
end

Items.CanEquip = Items.CanUse
